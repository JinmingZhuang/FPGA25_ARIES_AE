#include "aries/Transform/Utils.h"
#include "mlir/IR/BuiltinOps.h"
#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/Dialect/Affine/IR/AffineOps.h"
#include "mlir/Dialect/Affine/LoopUtils.h"
#include "mlir/Dialect/Affine/Analysis/Utils.h"
#include "mlir/Dialect/Affine/Analysis/LoopAnalysis.h"
#include "mlir/Dialect/Affine/Analysis/AffineAnalysis.h"
#include "mlir/Dialect/Affine/Analysis/AffineStructures.h"
#include "mlir/IR/IRMapping.h"
#include "mlir/IR/IntegerSet.h"
#include "llvm/Support/Debug.h"

using namespace mlir;
using namespace affine;
using namespace func;
using namespace presburger;

namespace mlir {
namespace aries {

/// Unrolls this loop completely.
LogicalResult loopUnrollFull(AffineForOp forOp, 
              function_ref<void(unsigned, Operation *, OpBuilder)> annotateFn) {
  std::optional<uint64_t> mayBeConstantTripCount 
                                    = mlir::affine::getConstantTripCount(forOp);
  if (mayBeConstantTripCount.has_value()) {
    uint64_t tripCount = *mayBeConstantTripCount;
    if (tripCount == 0)
      return success();
    if (tripCount == 1)
      return promoteIfSingleIteration(forOp);
    return loopUnrollByFactor(forOp, tripCount, annotateFn);
  }
  return failure();
}

// Traverse all the surrounding 'affine.for' of op
void getSurroundingLoops(Operation &op, SmallVector<AffineForOp, 6>& band) {
  auto *currOp = op.getParentOp();
  AffineForOp currAffineForOp;
  while (currOp) {
    if (AffineForOp currAffineForOp = dyn_cast<AffineForOp>(currOp))
      band.push_back(currAffineForOp);
    currOp = currOp->getParentOp();
  }
  std::reverse(band.begin(), band.end());
}

/// Get the common loops of op 'a' and 'b'
/// Only return true when all the parent loops are common loops 
bool getCommonSurroundingLoops(Operation &a, Operation &b, 
                               SmallVector<AffineForOp, 6>& commonLoops){
  SmallVector<Value, 4> ivsA;
  SmallVector<Value, 4> ivsB;
  getAffineIVs(a, ivsA);
  getAffineIVs(b, ivsB);
  if(ivsA.size()!=ivsB.size())
    return false;
  for (unsigned i = 0; i < ivsA.size(); ++i) {
    if (ivsA[i] != ivsB[i])
      return false;
    commonLoops.push_back(ivsA[i].getDefiningOp<AffineForOp>());
  }
  return true;
}

unsigned getLoopNum(Operation *op, AffineForOp &loop) {
  unsigned loopNum = 0;
  for (auto &region : op->getRegions())
    for (auto &block : region)
      for (auto &op : block)
        if (auto forOp = dyn_cast<AffineForOp>(op)){
          loop = forOp;
          loopNum++;
        }
  return loopNum;
}

AffineForOp getLoopBandFromOutermost(AffineForOp forOp,
                                     SmallVector<AffineForOp, 6> &band) {
  band.clear();
  auto currentLoop = forOp;
  while (true) {
    band.push_back(currentLoop);
    AffineForOp emptyLoop;
    if (getLoopNum(currentLoop, emptyLoop) == 1)
      currentLoop = *currentLoop.getOps<AffineForOp>().begin();
    else
      break;
  }
  return band.back();
}

/// Get the whole loop band given the innermost loop and return it in "band".
void getLoopBandFromInnermost(AffineForOp forOp, 
                              SmallVector<AffineForOp, 6> &band) {
  band.clear();
  SmallVector<AffineForOp, 6> reverseBand;

  auto currentLoop = forOp;
  while (true) {
    reverseBand.push_back(currentLoop);

    auto parentLoop = currentLoop->getParentOfType<AffineForOp>();
    if (!parentLoop)
      break;
    AffineForOp emptyForOp;
    if (getLoopNum(parentLoop, emptyForOp) == 1)
      currentLoop = parentLoop;
    else
      break;
  }
  band.append(reverseBand.rbegin(), reverseBand.rend());
}

// Extend getPerfectlyNestedLoops func to imperfect nested loops
void getNestedLoops(
    SmallVectorImpl<AffineForOp> &nestedLoops, AffineForOp root) {
  SmallVector<AffineForOp> loops;
  for (unsigned i = 0; i < std::numeric_limits<unsigned>::max(); ++i) {
    nestedLoops.push_back(root);
    AffineForOp loop;
    auto loopNum = getLoopNum(root, loop);
    if(loopNum != 1)
      return;
    root = loop;
  }
}

// Get all the affine.for loops within a region and return them in the band
void getNestedLoopBand(Region &region, SmallVector<AffineForOp, 6> &band, 
                       bool reverse) {
  auto forOp = getFirstOpOfType<AffineForOp>(region);
  getNestedLoops(band, forOp);
  if (reverse)
    std::reverse(band.begin(), band.end());
}

/// Built-in Function: Checks whether a loop nest is hyper-rectangular or not.
LogicalResult checkIfHyperRectangular(MutableArrayRef<AffineForOp> input) {
  FlatAffineValueConstraints cst;
  SmallVector<Operation *, 8> ops(input.begin(), input.end());
  // 0-d or 1-d is trivially hyper-rectangular.
  if (input.size() <= 1)
    return success();
  if (failed(getIndexSet(ops, &cst))) {
    llvm::dbgs() << "Index set computation failed!\n";
    return failure();
  }
  if (!cst.isHyperRectangular(0, input.size())) {
    llvm::dbgs()<< "Non-hyperrectangular nests not supported for tiling!\n";
    return failure();
  }
  return success();
}

// Find topFunc and collect the Callee functions
bool topFind(ModuleOp mod, FuncOp& topFunc, StringRef topFuncName){
  bool topFunc_flag = false;
  for (FuncOp func : mod.getOps<FuncOp>()) {
    // Check if the attribute exists in this function.
    if (func->getAttr(topFuncName)){
      topFunc = func;
      topFunc_flag = true;
    }
  }
  return topFunc_flag;
}

// Find the callee function called in the topFunc
bool calleeFind(ModuleOp mod, FuncOp topFunc, FuncOp &calleeFuncOp){
  bool calleeFunc_flag = false;
  SmallVector<FuncOp, 2> CalleeList;
  auto topFuncName = topFunc.getName();
  //Collect the callee function list
  for (FuncOp func : mod.getOps<FuncOp>()) {
    if (func.getName()!= topFuncName)
      CalleeList.push_back(func);
  }

  topFunc.walk([&](CallOp callerFuncOp){
    auto calleeName = callerFuncOp.getCallee();
    for(auto funcOp : CalleeList) {
      if (funcOp.getName() == calleeName) {
        calleeFuncOp = funcOp;
        calleeFunc_flag = true;
        break;
      }
    }
  });
  return calleeFunc_flag;
}

}   // namespace aries
}   // namespace mlir