#include "mlir/Tools/mlir-translate/Translation.h"
#include "mlir/Dialect/ControlFlow/IR/ControlFlow.h"
#include "mlir/Dialect/DLTI/DLTI.h"
#include "mlir/Dialect/EmitC/IR/EmitC.h"
#include "mlir/Dialect/Index/IR/IndexDialect.h"
#include "mlir/Dialect/LLVMIR/LLVMDialect.h"
#include "mlir/Dialect/Math/IR/Math.h"
#include "aries/Translation/Emitter.h"
#include "mlir/Dialect/Vector/IR/VectorOps.h"
#include "aries/Dialect/ADF/ADFDialect.h"
#include "aie/Dialect/AIE/IR/AIEDialect.h"
#include "aie/Dialect/AIEVec/IR/AIEVecOps.h"

using namespace mlir;
using namespace aries;


void aries::registerEmitAriesCppTranslation() {
  static TranslateFromMLIRRegistration registration(
  "emit-aries-kernels", "Emit AIE Single Kernel + AIE ADF Graph + Vitis HLS", 
  emitAriesCpp,
  [&](DialectRegistry &registry) {
    registry.insert<
      mlir::aries::adf::ADFDialect,
      mlir::func::FuncDialect,
      mlir::affine::AffineDialect,
      mlir::memref::MemRefDialect,
      mlir::arith::ArithDialect,
      mlir::memref::MemRefDialect,
      mlir::scf::SCFDialect,
      mlir::vector::VectorDialect,
      arith::ArithDialect,
      emitc::EmitCDialect,
      LLVM::LLVMDialect,
      math::MathDialect,
      cf::ControlFlowDialect,
      DLTIDialect,
      xilinx::aievec::AIEVecDialect,
      index::IndexDialect
    >();
  });
}

void aries::registeremitKernelFuncTranslation() {
  static TranslateFromMLIRRegistration registration(
      "emit-kenrel-func", "Emit ADF Kernel Func", emitKernelFunc,
      [&](DialectRegistry &registry) {
        registry.insert<
          mlir::aries::adf::ADFDialect,
          mlir::func::FuncDialect,
          mlir::affine::AffineDialect,
          mlir::memref::MemRefDialect,
          mlir::scf::SCFDialect,
          mlir::vector::VectorDialect,
          arith::ArithDialect,
          emitc::EmitCDialect,
          LLVM::LLVMDialect,
          math::MathDialect,
          cf::ControlFlowDialect,
          DLTIDialect,
          xilinx::aievec::AIEVecDialect,
          index::IndexDialect
        >();
      });
}


void aries::registerAriesEmitters() {
  registerEmitAriesCppTranslation();
  registeremitKernelFuncTranslation();
}