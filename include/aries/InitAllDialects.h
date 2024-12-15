//===----------------------------------------------------------------------===//
//
// Copyright 2021-2022 The PolyAIE Authors.
//
//===----------------------------------------------------------------------===//

#ifndef ARIES_INITALLDIALECTS_H
#define ARIES_INITALLDIALECTS_H


#include "mlir/Dialect/Affine/IR/AffineOps.h"
#include "mlir/Dialect/Arith/IR/Arith.h"
#include "mlir/Dialect/Bufferization/IR/Bufferization.h"
#include "mlir/Dialect/ControlFlow/IR/ControlFlowOps.h"
#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/Dialect/Math/IR/Math.h"
#include "mlir/Dialect/Vector/IR/VectorOps.h"
#include "mlir/IR/Dialect.h"
#include "mlir/Dialect/LLVMIR/LLVMDialect.h"
#include "mlir/Dialect/MemRef/IR/MemRef.h"

namespace mlir {
namespace aries {

// Add all the related dialects to the provided registry.
inline void registerAllDialects(mlir::DialectRegistry &registry) {
  // clang-format off
  registry.insert<
    mlir::func::FuncDialect,
    mlir::cf::ControlFlowDialect,
    mlir::affine::AffineDialect,
    mlir::memref::MemRefDialect,
    mlir::arith::ArithDialect,
    mlir::math::MathDialect,
    mlir::vector::VectorDialect,
    mlir::bufferization::BufferizationDialect,
    mlir::LLVM::LLVMDialect
  >();
  // clang-format on
}

} // namespace aries
} // namespace mlir

#endif // ARIES_INITALLDIALECTS_H
