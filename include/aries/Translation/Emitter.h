#ifndef ARIES_TRANSLATION_EMITTER_H
#define ARIES_TRANSLATION_EMITTER_H

#include "mlir/IR/BuiltinOps.h"
#include "mlir/InitAllDialects.h"
#include "aries/Dialect/ADF/ADFDialect.h"

namespace mlir {
namespace aries {

LogicalResult emitAriesCpp(ModuleOp module, llvm::raw_ostream &os);
void registerEmitAriesCppTranslation();

/// Translates the AIE vector dialect MLIR to C++ code for Vitis Flow.
LogicalResult emitAIEVecToCpp(mlir::Operation *op, bool aieml,
                              bool vitis, bool enres, mlir::raw_ostream &os);
LogicalResult emitKernelFunc(ModuleOp module, llvm::raw_ostream &os);
void registeremitKernelFuncTranslation();

/// Register all exporters.
void registerAriesEmitters();

//===----------------------------------------------------------------------===//
// Base Classes of emitters
//===----------------------------------------------------------------------===//

/// This class maintains the mutable state that cross-cuts and is shared by the
/// various emitters.
class ADFEmitterState {
public:
  explicit ADFEmitterState(raw_ostream &os) : os(os) {}

  // The stream to emit to.
  raw_ostream &os;

  bool encounteredError = false;
  unsigned currentIndent = 0;

  // This table contains all declared values.
  DenseMap<Value, SmallString<8>> nameTable;
  DenseMap<func::CallOp, SmallString<8>> callTable;
  std::map<std::string, int> nameConflictCnt;
  SmallVector<unsigned, 3> idxCnts={0,0,0};

private:
  ADFEmitterState(const ADFEmitterState &) = delete;
  void operator=(const ADFEmitterState &) = delete;
};

/// This is the base class for all of the ADFCpp emitters.
class ADFEmitterBase {
public:
  explicit ADFEmitterBase(ADFEmitterState &state): state(state), os(state.os) {}

  raw_ostream &indent() { return os.indent(state.currentIndent); }

  void addIndent() { state.currentIndent += 2; }
  void reduceIndent() { state.currentIndent -= 2; }

  // All of the mutable state we are maintaining.
  ADFEmitterState &state;

  // The stream to emit to.
  raw_ostream &os;

  /// Value name management methods.
  SmallString<8> addName(Value val, bool isPtr = false, std::string name = "");

  SmallString<8> addCall(func::CallOp call, std::string name = "");

  SmallString<8> getName(Value val);

  SmallString<8> getCall(func::CallOp call);

  SmallString<16> getDMAAccess(adf::DmaOp op, unsigned rank, 
                               bool isSrc, bool dir);

  bool isDeclared(Value val) {
    if (getName(val).empty()) {
      return false;
    } else
      return true;
  }

  bool isDeclared(func::CallOp call) {
    if (getCall(call).empty()) {
      return false;
    } else
      return true;
  }

private:
  ADFEmitterBase(const ADFEmitterBase &) = delete;
  void operator=(const ADFEmitterBase &) = delete;
};



} // namespace aries
} // namespace mlir

#endif // ARIES_TRANSLATION_EMITTER_H