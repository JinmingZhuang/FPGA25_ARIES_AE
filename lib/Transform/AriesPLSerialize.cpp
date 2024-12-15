#include "mlir/IR/BuiltinOps.h"
#include "mlir/IR/Builders.h"
#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/Dialect/SCF/IR/SCF.h"
#include "mlir/Analysis/Liveness.h"
#include "mlir/Dialect/Affine/Utils.h"
#include "mlir/Dialect/Affine/LoopUtils.h"
#include "mlir/Dialect/Affine/Analysis/LoopAnalysis.h"
#include "llvm/Support/Debug.h"
#include "aries/Transform/Passes.h"
#include "aries/Transform/Utils.h"
#include "aries/Dialect/ADF/ADFDialect.h"

using namespace mlir;
using namespace aries;
using namespace adf;
using namespace mlir::memref;
using namespace mlir::func;
using namespace mlir::affine;

namespace {

struct AriesPLSerialize 
       : public AriesPLSerializeBase<AriesPLSerialize> {
public:
  void runOnOperation() override {
    auto mod = dyn_cast<ModuleOp>(getOperation());
  
    if (!PLSerialize(mod))
      signalPassFailure();
  }

private:
  bool getPacksize(ArrayAttr typeAttrs, unsigned width, unsigned dis,
                   unsigned& packNum, SmallVector<int64_t, 4> idxs){
    auto it1 = llvm::find(idxs, dis);
    if(it1 == idxs.end())
      return false;
    int64_t dis1 = std::distance(idxs.begin(),it1);
    auto typeAttr = dyn_cast<TypeAttr>(typeAttrs[dis1]);
    auto originType = typeAttr.getValue();
    auto originWidth = originType.getIntOrFloatBitWidth();
    packNum = (unsigned)(width/originWidth);
    return true;
  }

  // This function create the memref size of one dim
  // TODO: For dynamic size, now assumes that it's determined by one argument
  bool getMemSize(Value operand, Value &memSize, Region::BlockArgListType args){
    auto loop = getForInductionVarOwner(operand);
    if(!loop || loop.hasConstantUpperBound()){
      llvm::outs() << "Const loop\n";
      return true;
    }
    // Get original type and packing number
    auto ubMap = loop.getUpperBoundMap(); 
    if (ubMap.getNumResults() != 1){
      llvm::outs() << "Upperbound map has more than one result\n";
      return false;
    }
    auto symExpr = dyn_cast<AffineSymbolExpr>(ubMap.getResult(0));
    if(!symExpr){
      llvm::outs() << "Result 0 is not a symbol expr\n";
      return false;
    }
    // TODO:: Now assumes that the upperbound is either in the args or
    // calculated by divui
    unsigned symPos = symExpr.getPosition();
    auto s0 = loop.getUpperBoundOperands()[symPos];
    auto defineOp = s0.getDefiningOp();
    Value arg;
    if(!defineOp){
      arg = s0;
      llvm::outs() << "Enter\n";
    }else{
      auto divOp = dyn_cast<arith::DivUIOp>(defineOp);
      if(!divOp){
        llvm::outs() << "The upperbound is not defined by DivUIOp";
        return false;
      }
      llvm::outs() << "Enter 1\n";
      arg = divOp.getLhs();
    }
    auto it = llvm::find(args, arg);
    if(it ==args.end()){
      llvm::outs() << "Can't find the dynmic memory size";
      return false;
    }
    memSize = arg;
    return true;
  }

  // This function will update the arguments with dynamic shape in adf.pl funcs
  bool typeUpdate(OpBuilder builder, FuncOp func){
    auto loc = builder.getUnknownLoc();
    // Traverse the arguments and replace the ones with dynamic shape
    auto inTypes =SmallVector<Type,8>(func.getArgumentTypes().begin(),
                                      func.getArgumentTypes().end());
    auto outTypes = func.getResultTypes();
    auto args = func.getArguments();
    auto idxAttrs = func->getAttrOfType<ArrayAttr>("mem_idx");
    auto typeAttrs = func->getAttrOfType<ArrayAttr>("mem_type");
    SmallVector<int64_t, 4> idxs;
    if(idxAttrs){
      for (auto attr : idxAttrs) {
        if (auto intAttr = attr.dyn_cast<IntegerAttr>()){
          idxs.push_back(intAttr.getInt());
        }
      }
    }
    for (unsigned i=0; i < func.getNumArguments(); i++){
      auto arg = args[i];
      auto memType = dyn_cast<MemRefType>(arg.getType());
      if(!memType || memType.hasStaticShape())
        continue;
      auto memSizes = memType.getShape();
      auto eleType = memType.getElementType();
      auto width = eleType.getIntOrFloatBitWidth();
      auto newType = MemRefType::get({ShapedType::kDynamic},eleType);
      //inTypes[i] = newType;
      //arg.setType(newType);
      if(!typeAttrs)
        continue;
      unsigned packNum;
      if(!getPacksize(typeAttrs, width, i, packNum, idxs)){
        llvm::outs() << "Find dynamic memref not in the arguments\n";
        return false;
      }
      // Update the affine.load/affine.store that uses the arg
      // TODO: Handle other operations
      for (auto use: arg.getUsers()){
        if(dyn_cast<CallOp>(use)){
          continue;
        }
        else if(auto load = dyn_cast<AffineLoadOp>(use)){
          llvm::outs() << "Func is: " << func.getName() << "\n";
          auto map = load.getAffineMap();
          auto operands = load.getMapOperands();
          int numRes = map.getNumResults();
          auto numDim = map.getNumDims();
          auto numSym = map.getNumSymbols();
          
          llvm::outs() << "Enter here3\n";
          if(numSym>0)      
            return false;
          if(numRes<=1){
            continue;
          }else{
            // Serialize the memory access by calculating the new mem access
            // using arith dialect
            builder.setInsertionPoint(load);
            auto pAttr = builder.getIndexAttr(packNum);
            auto pVal = builder.create<arith::ConstantOp>(loc, pAttr);
            Value addL1; //Left op to add different memory dims
            SmallVector<Value, 4> memVals;
            for(int i = numRes-1; i >= 0; i--){
              llvm::outs() << "Mem dim is: " << i << "\n";
              auto res = map.getResult(i);
              // flattened form [dims, symbols, locals, constant]
              llvm::SmallVector<int64_t> flatExpr;
              if (failed(getFlattenedAffineExpr(res, numDim, numSym,&flatExpr)))
                return false;
              auto memInt = memSizes[i];
              // Save the constant mem size
              if(memInt>0){
                auto sizeAttr = builder.getIndexAttr(memInt);
                auto sizeVal = builder.create<arith::ConstantOp>(loc, sizeAttr);
                memVals.push_back(sizeVal);
              }
              llvm::outs() << "Enter here2\n";
              Value memSize;
              Value addL0; //Left op to add one memory dim
              for(unsigned dim = 0; dim < numDim; dim++){
                auto stride = flatExpr[dim];
                auto operand = operands[dim];
                if(stride==0)
                  continue;
                if(memInt<0 && !memSize){
                  llvm::outs() << "Enter here1\n";
                  llvm::outs() << "stride is: " << stride << "\n";
                  if(!getMemSize(operand, memSize, args)){
                    llvm::outs() << "Can't get memref size\n";
                    return false;
                  }
                  if(memSize){
                    llvm::outs() << "Enter here\n";
                    Value sizeNew;
                    if(i == numRes-1){
                      auto divOp 
                           = builder.create<arith::DivUIOp>(loc, memSize, pVal);
                      sizeNew = divOp.getResult();
                    }else{
                      sizeNew = memSize;
                    }
                    memVals.push_back(sizeNew);
                    llvm::outs() << "Enter here-1\n";
                  }
                }
                Value mulRes;
                if(stride==1){
                  mulRes = operand;
                }else{
                  auto mulL = operand;
                  auto mulRAttr = builder.getIndexAttr(stride);
                  auto mulR = builder.create<arith::ConstantOp>(loc, mulRAttr);
                  auto mul = builder.create<arith::MulIOp>(loc, mulL, mulR);
                  mulRes = mul.getResult();
                }
                llvm::outs() << "Enter here-2\n";
                Value addRes;
                if(!addL0){
                  addRes = mulRes;
                }else{
                  auto addR = mulRes;
                  auto add = builder.create<arith::AddIOp>(loc, addL0, addR);
                  addRes = add.getResult();
                }
                addL0 = addRes;
                llvm::outs() << "Enter here-3\n";
              }
              Value addRes1;
              if(!addL1){
                addRes1 = addL0;
                llvm::outs() << "Enter here-4\n";
              }else{
                auto mulL1 = addL0;
                llvm::outs() << "memVal size is: " << memVals.size() << "\n";
                for(unsigned idx=0; idx < memVals.size()-1; idx++){
                  auto mulR1 = memVals[idx];
                  auto mul1 = builder.create<arith::MulIOp>(loc, mulL1, mulR1);
                  mulL1 = mul1.getResult();
                }
                auto add1 = builder.create<arith::AddIOp>(loc, addL1, mulL1);
                addRes1 = add1.getResult();
              }
              addL1 = addRes1;
              llvm::outs() << "Enter here-5\n";
            }
            
          }
        }else if(auto store = dyn_cast<AffineStoreOp>(use)){

        }else{
          llvm::outs() << "Argument with dynamic size is used by other ops\n";
          return false;
        }
      }
    }
    // Update the callee function type.
    //func.setType(builder.getFunctionType(inTypes, outTypes));
    return true;
  }

  // This pass will serialize all the memref arguments of the top function
  // that has dynamic size. This pass will serialize the affine.load and
  // affine.store that uses the argument. And will update the memref in all the
  // arguments of the parent functions.
  bool PLSerialize (ModuleOp mod) {
    auto builder = OpBuilder(mod);
    for (auto func: mod.getOps<FuncOp>()){
      if(!func->hasAttr("adf.pl") && !func->hasAttr("adf.func"))
        continue;
      if(!typeUpdate(builder, func))
        return false;
    }
    return true;
  }

};
} // namespace



namespace mlir {
namespace aries {

std::unique_ptr<Pass> createAriesPLSerializePass() {
  return std::make_unique<AriesPLSerialize>();
}

} // namespace aries
} // namespace mlir