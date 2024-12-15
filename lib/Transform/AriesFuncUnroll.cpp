#include "aries/Transform/Passes.h"
#include "aries/Transform/Utils.h"
#include "aries/Dialect/ADF/ADFDialect.h"
#include "mlir/Dialect/Affine/IR/AffineOps.h"
#include "mlir/Dialect/Affine/LoopUtils.h"
#include "mlir/IR/BuiltinOps.h"
#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/Dialect/MemRef/IR/MemRef.h"
#include "mlir/Dialect/Affine/Analysis/LoopAnalysis.h"

using namespace mlir;
using namespace aries;
using namespace adf;
using namespace mlir::affine;
using namespace mlir::memref;
using namespace func;


namespace {

struct AriesFuncUnroll : public AriesFuncUnrollBase<AriesFuncUnroll> {
public:
  void runOnOperation() override {
    auto mod = dyn_cast<ModuleOp>(getOperation());  
    if (!FuncUnroll(mod))
      signalPassFailure();
  }

private:
  bool FuncUnroll (ModuleOp mod) {
    auto builder = OpBuilder(mod);
    // Tranverse all the adf.func
    for (auto func : mod.getOps<FuncOp>()) {
      if(!func->hasAttr("adf.func"))
        continue;
      // Find the CellOp
      CellOp cellOp = getFirstOpOfType<CellOp>(func.getBody());
      if(!cellOp)
        return true;
      SmallVector<AffineForOp, 6> band;
      getNestedLoopBand(cellOp.getBody(), band, true);
      SmallVector<Attribute, 3> tripCountList;
      auto indexType = builder.getIndexType();
      auto zeroAttr = builder.getIntegerAttr(indexType, 0);
      auto oneAttr = builder.getIntegerAttr(indexType, 1);
      //Start from the innermost loop
      unsigned index = 0;
      SmallVector<unsigned, 3> indexList;
      bool flowFull = false;
      for (auto loop: band) {
        // Keep the tripCount info after unrolling
        auto tripCount = getConstantTripCount(loop);
        if(!tripCount.has_value())
          return false;
        auto tripCountVal = tripCount.value();
        if(tripCountVal>1){
          auto tripCountAttr = builder.getIntegerAttr(indexType, tripCountVal);
          tripCountList.push_back(tripCountAttr);
          indexList.push_back(index);
        }
        index++;
        // Unroll reduction loop
        if (loop->getAttr("flow")){
          auto annotateFn = [](unsigned i, Operation *op, OpBuilder builder) {
            auto indexType = builder.getIndexType();
            auto valueAttr = builder.getIntegerAttr(indexType,i);
            if (auto dmaop = dyn_cast<DmaOp>(op)){
              if(auto attr = dmaop->getAttr("write"))
                dmaop->setAttr("write", valueAttr);
              else if(auto attr = dmaop->getAttr("read"))
                dmaop->setAttr("read", valueAttr);
            }else if (auto callop = dyn_cast<CallOp>(op)){
              // Mark kernel in the reduction chain to modify the kernel interface 
              callop->setAttr("kernel", valueAttr);
              // Mark each loop iteration info for placement
              if(auto attr = callop->getAttr("ivs")){
                auto arrayAttr = dyn_cast<ArrayAttr>(attr);
                SmallVector<Attribute, 3> newAttrList;
                for (auto oldAttr : arrayAttr){
                  newAttrList.push_back(oldAttr);
                }
                newAttrList.push_back(valueAttr);
                auto newArrayAttr = builder.getArrayAttr(newAttrList);
                callop->setAttr("ivs", newArrayAttr);
              }else{
                auto arrayAttr = builder.getArrayAttr({valueAttr});
                callop->setAttr("ivs", arrayAttr);
              }
            }
          };
          if (failed(loopUnrollFull(loop, annotateFn)))
            return false;
          if(flowFull){ // Only support one reduction loop
            assert("Support only one reduction loop\n");
            return false;
          }
          if(tripCount>1)
            flowFull = true;
        }
        // Unroll non-reduction loop
        else {
          auto annotateFn = [](unsigned i, Operation *op, OpBuilder builder) {
            auto indexType = builder.getIndexType();
            auto valueAttr = builder.getIntegerAttr(indexType,i);
            if (auto callop = dyn_cast<CallOp>(op)){
              // Mark kernel in the reduction chain to modify the kernel interface 
              // Mark each loop iteration info for placement
              if(auto attr = callop->getAttr("ivs")){
                auto arrayAttr = dyn_cast<ArrayAttr>(attr);
                SmallVector<Attribute, 3> newAttrList;
                for (auto oldAttr : arrayAttr){
                  newAttrList.push_back(oldAttr);
                }
                newAttrList.push_back(valueAttr);
                auto newArrayAttr = builder.getArrayAttr(newAttrList);
                callop->setAttr("ivs", newArrayAttr);
              }else{
                auto arrayAttr = builder.getArrayAttr({valueAttr});
                callop->setAttr("ivs", arrayAttr);
              }
            }
          };

          if (failed(loopUnrollFull(loop, annotateFn)))
            return false;
        }
      }
      // Identify the loops that has tripcounts > 1, and complete the three dims
      // for core placement
      int listSize = (int)tripCountList.size();
      bool midFlag = false; // Decide if insert single tripcount loop info to mid
      if(listSize>3)
        return false;
      else{
        if(listSize<=1){
          for(int i = 0; i < (3-listSize); i++)
            tripCountList.push_back(oneAttr);
        }else if(listSize==2){ //listSize=2
          unsigned diff = indexList[1] - indexList[0];
          auto lastElem = tripCountList[1];
          tripCountList.pop_back();
          tripCountList.push_back(oneAttr);
          tripCountList.push_back(lastElem);
          if(diff>1)
            midFlag =true;
        }
      }
      // Mark the tripCount info for placement
      auto arrayAttr = builder.getArrayAttr(tripCountList);
      cellOp->setAttr("tripCount", arrayAttr);
      // Add a name for each function call
      llvm::SmallVector<std::pair<StringRef, unsigned>, 4> calleeCounts;
      cellOp.walk([&](CallOp call){
        auto calleeName = call.getCallee();
        bool found = false;
        for (auto &entry : calleeCounts) {
          if (entry.first == calleeName) {
            entry.second++;
            auto valueAttr 
                 = builder.getIntegerAttr(builder.getIndexType(), entry.second);
            call->setAttr(calleeName,valueAttr);
            call->setAttr("adf.kernel",builder.getUnitAttr());
            found = true;
            // Fill the ivs attributes to three if needed
            if(listSize<3){
              SmallVector<Attribute, 3> newAttrList;
              auto arrayAttr = call->getAttr("ivs");
              if(!arrayAttr)
                for(int i = 0; i < (3-listSize); i++)
                  newAttrList.push_back(zeroAttr);
              else{
                auto ivArrayAttr = dyn_cast<ArrayAttr>(call->getAttr("ivs"));
                if(midFlag){
                  newAttrList.push_back(ivArrayAttr[0]);
                  newAttrList.push_back(zeroAttr);
                  newAttrList.push_back(ivArrayAttr[1]);
                }else{
                  if(ivArrayAttr)
                    for (auto oldAttr : ivArrayAttr)
                      newAttrList.push_back(oldAttr);
                  for(int i = 0; i < (3-listSize); i++)
                    newAttrList.push_back(zeroAttr);
                }
              }
              auto newArrayAttr = builder.getArrayAttr(newAttrList);
              call->setAttr("ivs", newArrayAttr);
            }
            break;
          }
        }
        if (!found) {
          calleeCounts.push_back(std::make_pair(calleeName, 0));
          auto valueAttr = builder.getIntegerAttr(builder.getIndexType(), 0);
          call->setAttr(calleeName,valueAttr);
          call->setAttr("adf.kernel",builder.getUnitAttr());
          // Fill the ivs attributes to three if needed
          if(listSize<3){
            SmallVector<Attribute, 3> newAttrList;
            auto arrayAttr = call->getAttr("ivs");
            if(!arrayAttr)
              for(int i = 0; i < (3-listSize); i++)
                newAttrList.push_back(zeroAttr);
            else{
              auto ivArrayAttr = dyn_cast<ArrayAttr>(call->getAttr("ivs"));
              if(midFlag){
                newAttrList.push_back(ivArrayAttr[0]);
                newAttrList.push_back(zeroAttr);
                newAttrList.push_back(ivArrayAttr[1]);
              }else{
                if(ivArrayAttr)
                  for (auto oldAttr : ivArrayAttr)
                    newAttrList.push_back(oldAttr);
                for(int i = 0; i < (3-listSize); i++)
                  newAttrList.push_back(zeroAttr);
              }
            }
            auto newArrayAttr = builder.getArrayAttr(newAttrList);
            call->setAttr("ivs", newArrayAttr);
          }
        }
      });
    }
    return true;
  }

};
} // namespace



namespace mlir {
namespace aries {

std::unique_ptr<Pass> createAriesFuncUnrollPass() {
  return std::make_unique<AriesFuncUnroll>();
}

} // namespace aries
} // namespace mlir