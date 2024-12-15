#ifndef ARIES_CONVERSION_PASSES_TD
#define ARIES_CONVERSION_PASSES_TD

include "mlir/Pass/PassBase.td"

def AriesLowerToADF : Pass<"aries-lower-to-adf"> {
  let summary = "Lower to adf dialect";

  let description = [{
    This pass lowers the front-end IRs to adf dialect.
  }];
  let dependentDialects = [
    "mlir::aries::adf::ADFDialect",
    "mlir::affine::AffineDialect"
  ];
  let constructor = "mlir::aries::adf::createAriesLowerToADFPass()";
}

#endif  // ARIES_CONVERSION_PASSES_TD