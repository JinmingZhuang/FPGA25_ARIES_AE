#include "mlir/IR/BuiltinOps.h"
#include "mlir/IR/Builders.h"
#include "mlir/Dialect/Func/IR/FuncOps.h"
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

struct AriesIOPlacement : public AriesIOPlacementBase<AriesIOPlacement> {
public:
  AriesIOPlacement() = default;
  AriesIOPlacement(const AriesOptions &opts) {
    FirstCol=opts.OptFirstCol;
    NumShim=opts.OptNumShim;
    MidLine=opts.OptMidLine;
    ChalIn=opts.OptChalIn;
    ChalOut=opts.OptChalOut;
    EnableIOCons=opts.OptEnableIOCons;
  }
  void runOnOperation() override {
    auto mod = dyn_cast<ModuleOp>(getOperation());
  
    if (!IOPlacement(mod))
      signalPassFailure();
  }

private:
  bool checkValidChal(unsigned& col, unsigned& chl, int arrayIndex,
                      unsigned colFirst, bool enable, 
                      std::vector<int>& tileChannel){
    auto curChl = tileChannel[arrayIndex];
    if((!enable && curChl>=0) || (enable && curChl>=1)){
      col = arrayIndex + colFirst;
      chl = curChl * 2;
      tileChannel[arrayIndex] = curChl -1;
      return true;
    }
    return false;
  }

  // Here find available channel at the startPos, if not then jump forward and
  // back forward between startPos, if reach one end then only go another side
  bool findPlacement(unsigned colFirst, unsigned numTile, unsigned startPos, 
                     unsigned midLine, bool en, unsigned& col, 
                     unsigned& chl, std::vector<int>& tileChannel){
    unsigned colLast = colFirst + (numTile-1);
    if(startPos < colFirst)
      startPos = colFirst;
    if(startPos > colLast)
      startPos = colLast;
    int firstIndex = startPos - colFirst; // Record start pos of tileChannel
    int arrayIndex = firstIndex; //Used to move position of tileChannel
    bool direction = false; //Towards left
    bool end_flag = false;
    bool reachEnd = false;
    unsigned forwardCnt = 1;
    unsigned backwardCnt = 1;
    while(!end_flag){
      if(checkValidChal(col, chl, arrayIndex, colFirst, en, tileChannel))
        break;
      // If reachEnd been marked, then one side is already full
      // Only search one direction
      if(reachEnd){
        if(direction){
          arrayIndex++;
          if(arrayIndex > (int)(numTile-1))
            return false;
          if(checkValidChal(col, chl, arrayIndex, colFirst, en, tileChannel))
            end_flag = true;
        }else{
          arrayIndex--;
          if(arrayIndex < 0)
            return false;
          if(checkValidChal(col, chl, arrayIndex, colFirst, en, tileChannel))
            end_flag = true;
        }
      }else{
        // If both sides doesn't reach end, alternatively change direction
        if(direction){
          arrayIndex = firstIndex + forwardCnt;
          if(arrayIndex > (int)(numTile-1)){
            reachEnd = true;
            arrayIndex = numTile-1;
            if(checkValidChal(col, chl, arrayIndex, colFirst, en, tileChannel))
              end_flag = true;
            direction = !direction;
          }else{
            if(checkValidChal(col, chl, arrayIndex, colFirst, en, tileChannel))
              end_flag = true;
            forwardCnt++;
            direction = !direction;
          }
        }else{
          arrayIndex = firstIndex - backwardCnt;
          if(arrayIndex < 0){
            reachEnd = true;
            arrayIndex = 0;
            if(checkValidChal(col, chl, arrayIndex, colFirst, en, tileChannel))
              end_flag = true;
            direction = !direction;
          }else{
            if(checkValidChal(col, chl, arrayIndex, colFirst, en, tileChannel))
              end_flag = true;
            backwardCnt++;
            direction = !direction;
          }
        }
      }
    }
    return true;
  }
  bool IOPlacement (ModuleOp mod) {
    auto builder = OpBuilder(mod);
    auto indexType = builder.getIndexType();
    unsigned colFirst = FirstCol;
    unsigned numTile = NumShim;
    unsigned midLine = MidLine;
    unsigned numInChl = ChalIn;
    unsigned numOutChl = ChalOut;
    bool enableIOCons= EnableIOCons;
    std::vector<int> tileInChl(numTile, numInChl-1);
    std::vector<int> tileOutChl(numTile, numOutChl-1);
    if(EnableIOCons){
      tileInChl[0]=0;
      tileInChl[1]=0;
      tileInChl[2]=1;
      tileInChl[36]=1;
      tileInChl[37]=0;
      tileInChl[38]=0;
    }
    auto flag = mod.walk([&](FuncOp func){
      if(!func->hasAttr("adf.cell"))
        return WalkResult::advance();
      for(auto configOp : func.getOps<ConfigPLIOOp>()){
        SmallVector<unsigned, 4> corePlace;
        SmallVector<int, 4> broadPos;
        auto plio = configOp.getPlio();
        int disToMid = 0;
        int cnt = 0;
        bool inDir;
        for(auto use : plio.getUsers()){
          if(!dyn_cast<ConnectOp>(use))
            continue;
          auto connectOp = dyn_cast<ConnectOp>(use);
          auto src = connectOp.getSrc();
          auto dst = connectOp.getDst();
          CallOp call;
          if(src!=plio){
            auto defineOp = src.getDefiningOp();
            if(!defineOp || !dyn_cast<CallOp>(defineOp))
              return WalkResult::interrupt();
            inDir = false;
            call = dyn_cast<CallOp>(defineOp);
          }else{
            for(auto valUse : dst.getUsers()){
              if(!dyn_cast<CallOp>(valUse))
                continue;
              call = dyn_cast<CallOp>(valUse);
              inDir = true;
              break;
            }
          }
          if(!call)
            return WalkResult::interrupt();
          auto corePlaceAttr = dyn_cast<ArrayAttr>(call->getAttr("col, row"));
          auto colAttr = corePlaceAttr[0];
          auto intAttr = dyn_cast<IntegerAttr>(colAttr);
          int colCore = intAttr.getInt();
          broadPos.push_back(colCore);
          disToMid += colCore-midLine;
          cnt++;
        }
        if(cnt == 0)
          return WalkResult::advance();
        unsigned col;
        unsigned chl;
        int avgToMid = std::ceil(disToMid/(float)cnt);
        unsigned startPos = avgToMid + midLine;
        // when enableIOCons is enabled check if the variance of the position
        // of the broadcast ops is too small (<1) then limit the number used in
        // this shim
        bool enable = false;
        if(cnt>1 && enableIOCons){
          // Calculate the mean
          double sum = std::accumulate(broadPos.begin(), broadPos.end(), 0.0);
          double mean = sum / cnt;
          // Calculate the variance
          double variance = 0.0;
          for (int num : broadPos)
            variance += (num - mean) * (num - mean);
          variance /= cnt;
          // Calculate the standard deviation
          auto sdvar = std::sqrt(variance);
          if (sdvar < 1.0){
            enable = true;
          }
        }
        if(inDir){
          if(!findPlacement(colFirst, numTile, startPos, midLine, enable, 
                            col, chl, tileInChl))
            return WalkResult::interrupt();
        }else{
          if(!findPlacement(colFirst, numTile, startPos, midLine, enable, 
                            col, chl, tileOutChl))
            return WalkResult::interrupt();
        }
        auto colAttr = builder.getIntegerAttr(indexType, col);
        auto chlAttr = builder.getIntegerAttr(indexType, chl);
        auto arrayAttr = builder.getArrayAttr({colAttr, chlAttr});
        configOp->setAttr("col, chl", arrayAttr);
      } 
      return WalkResult::advance();
    });
    if(flag == WalkResult::interrupt())
      return false;
    return true;
  }

};
} // namespace



namespace mlir {
namespace aries {

std::unique_ptr<Pass> createAriesIOPlacementPass() {
  return std::make_unique<AriesIOPlacement>();
}

std::unique_ptr<Pass> createAriesIOPlacementPass(const AriesOptions &opts) {
  return std::make_unique<AriesIOPlacement>(opts);
}

} // namespace aries
} // namespace mlir