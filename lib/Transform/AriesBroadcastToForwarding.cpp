#include "mlir/IR/BuiltinOps.h"
#include "mlir/IR/Builders.h"
#include "mlir/Dialect/MemRef/IR/MemRef.h"
#include "mlir/Pass/PassManager.h"
#include "mlir/Dialect/Affine/Passes.h"
#include "llvm/Support/Debug.h"
#include "aries/Transform/Passes.h"
#include "aries/Transform/Utils.h"
#include "aries/Dialect/ADF/ADFDialect.h"

using namespace mlir;
using namespace aries;
using namespace adf;
using namespace mlir::memref;

namespace {

struct AriesBroadcastToForwarding 
      : public AriesBroadcastToForwardingBase<AriesBroadcastToForwarding> {
public:
  void runOnOperation() override {
    auto mod = dyn_cast<ModuleOp>(getOperation());
    StringRef topFuncName = "top_func";
    if (!BroadcastToForwarding(mod,topFuncName))
      signalPassFailure();
  }

private:
  bool findNextCall(Value res, CallOp& newCall){
    for(auto use : res.getUsers()){
      if(auto dmaOp = dyn_cast<DmaOp>(use)){
        auto dst = dmaOp.getDst();
        for(auto use1 : dst.getUsers()){
          if(auto nextCall = dyn_cast<CallOp>(use1)){
            newCall = nextCall;
            return true;
          }
        }
      }
    }
    return false;
  }

  //Recursively find calls in the reduction chain
  bool callCollection(Value res, SmallVector<CallOp>& calls){
    auto end_flag = false;
    auto curRes = res;
    CallOp call;
    while(!end_flag){
      if(!findNextCall(curRes, call))
        end_flag = true;
      if(call.getNumResults()!=1)
        return false;
      calls.push_back(call);
      curRes = call.getResult(0);
    }
    return true;
  }

  // Check if these values are broadcasted from the same source
  bool isBroadCast(Value dst0, Value dst1, DmaOp& dmaOp0, DmaOp& dmaOp1){
    for(auto use : dst0.getUsers()){
      if(auto dmaOp = dyn_cast<DmaOp>(use)){
        dmaOp0 = dmaOp;
        break;
      }
    }
    for(auto use : dst1.getUsers()){
      if(auto dmaOp = dyn_cast<DmaOp>(use)){
        dmaOp1 = dmaOp;
        break;
      }
    }
    if(!dmaOp0 || !dmaOp1)
      return false;
    if (dmaOp0.getSrc() == dmaOp1.getSrc() &&
      dmaOp0.getSrcOffsets() == dmaOp1.getSrcOffsets() &&
      dmaOp0.getSrcSizes() == dmaOp1.getSrcSizes() &&
      dmaOp0.getSrcStrides() == dmaOp1.getSrcStrides())
      return true;
    return false;
  }

  // Function to find positions of same numbers
  void findSameNumberPositions(const SmallVector<SmallVector<int, 4>, 4> &vectors) {
    // Iterate over the elements of the first vector as candidate numbers
    for (size_t i = 0; i < vectors[0].size(); ++i) {
      int candidate = vectors[0][i];
      SmallVector<int, 4> positions; // To store the matching positions
      // Assume the candidate is valid initially
      bool is_valid = true;
      // Check this candidate against all other vectors
      for (size_t j = 0; j < vectors.size(); ++j) {
        bool found = false;
        for (size_t k = 0; k < vectors[j].size(); ++k) {
          if (vectors[j][k] == candidate) {
            positions.push_back(k); // Store the position of the matching number
            found = true;
            break;
          }
        }
        if (!found) {
          is_valid = false;
          break;
        }
      }
    }
  }

  // Function to find all the broadcasts that broadcast to all the calls
  void findBroadcast(SmallVector<SmallVector<Value, 4>> operandList,
                     SmallVector<SmallVector<DmaOp, 4>>& broadcastList,
                     SmallVector<unsigned, 4>& indeices){
    for (unsigned i = 0; i < operandList[0].size(); ++i) {
      Value operand0 = operandList[0][i];
      SmallVector<DmaOp, 4> dmaOps;
      bool is_valid = true;
      for (unsigned j = 0; j < operandList.size(); ++j) {
        bool found = false;
        for (unsigned k = 0; k < operandList[j].size(); ++k) {
          DmaOp dmaOp0, dmaOp1;
          if (isBroadCast(operandList[j][k], operand0, dmaOp0, dmaOp1) && i==k){
            dmaOps.push_back(dmaOp0);
            found = true;
            break;
          }
        }
        if (!found) {
          is_valid = false;
          break;
        }
      }
      if (is_valid && dmaOps.size() == operandList.size()) {
        broadcastList.push_back(dmaOps);
        indeices.push_back(i);
      }
    }
  }


  // This is a work around need to be generalized
  bool BroadcastToForwarding (ModuleOp mod, StringRef topFuncName) {
    // auto builder = OpBuilder(mod);
    // FuncOp topFunc;
    // if(!topFind(mod, topFunc, topFuncName)){
    //   topFunc->emitOpError("Top function not found\n");
    //   return false;
    // }

    // // Find the CellOp
    // // TODO: Handle Multiple CellOp
    // CellOp cell = getFirstOpOfType<CellOp>(topFunc.getBody());
    // if(!cell)
    //   return true;

    // cell.walk([&](CallOp call){
    //   // Deal with the calls at start of the reduction chain
    //   // Here only support for 1d reduction chain
    //   if(call->hasAttr("kernel"))
    //     return WalkResult::advance();
      
    //   // Find the next kernel in the reduction chain
    //   auto numResult = call.getNumResults();
    //   if(numResult!=1)
    //     return WalkResult::advance();
    //   Value res = call.getResult(0);
    //   SmallVector<CallOp> calls;
    //   calls.push_back(call);
    //   callCollection(res, calls);
    //   if(calls.size()==1)
    //     return WalkResult::advance();
      
    //   //Collect all the operands of these calls
    //   SmallVector<SmallVector<Value, 4>> operandList;
    //   for(auto call : calls){
    //     auto operands = call.getOperands();
    //     operandList.push_back(operands);
    //   }
    //   // Tranverse the chain to detect broadcast dmas on all calls
    //   SmallVector<SmallVector<DmaOp,4>> broadcastList;
    //   SmallVector<unsigned, 4> indeices;
    //   findBroadcast(operandList, broadcastList, indeices);
    //   if(!broadcastList.size())
    //     return WalkResult::advance();
      
    //   // TODO: Here have a very preservative assumpssion:
    //   // Only do this optimization when all the callers need to do the same
    //   // update by marking the functions with attributes first
    //   // Mark the middle calls with the argument needs to be returned
    //   SmallVector<Attribute, 4> integerAttrs;
    //   for(unsigned i=1; i < calls.size(); i++){
    //     auto call = calls[i];
    //     for(auto index : indeices){

    //     }
        
    //   }
      
      
    //   return WalkResult::advance();
    // });

    return true;
  }

};
} // namespace



namespace mlir {
namespace aries {

std::unique_ptr<Pass> createAriesBroadcastToForwardingPass() {
  return std::make_unique<AriesBroadcastToForwarding>();
}

} // namespace aries
} // namespace mlir