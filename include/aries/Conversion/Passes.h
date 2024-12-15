#ifndef ARIES_CONVERSION_PASSES_H
#define ARIES_CONVERSION_PASSES_H

#include "mlir/IR/BuiltinOps.h"
#include "mlir/Pass/Pass.h"
#include "aries/Dialect/ADF/ADFDialect.h"
#include "aries/Transform/Passes.h"

namespace mlir {
class Pass;
} // namespace mlir

namespace mlir {
namespace aries {
namespace adf {

std::unique_ptr<Pass> createAriesLowerToADFPass();
void registerConvertToADFPasses();

#define GEN_PASS_CLASSES
#include "aries/Conversion/Passes.h.inc"

}  // namespace adf
}  // namespace aries
}  // namespace mlir

#endif // ARIES_CONVERSION_PASSES_H