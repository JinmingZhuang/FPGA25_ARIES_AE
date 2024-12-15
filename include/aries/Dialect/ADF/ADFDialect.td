#ifndef ARIES_DIALECT_ARIES_ADF_DIALECT_TD
#define ARIES_DIALECT_ARIES_ADF_DIALECT_TD

include "mlir/IR/OpBase.td"
include "mlir/IR/AttrTypeBase.td"
include "mlir/IR/EnumAttr.td"
include "mlir/IR/BuiltinTypes.td"
include "mlir/IR/BuiltinTypeInterfaces.td"
include "mlir/IR/CommonTypeConstraints.td"
include "mlir/IR/SymbolInterfaces.td"
include "mlir/Interfaces/InferTypeOpInterface.td"
include "mlir/Interfaces/SideEffectInterfaces.td"
include "mlir/Interfaces/CallInterfaces.td"
include "mlir/Interfaces/ControlFlowInterfaces.td"
include "mlir/Interfaces/FunctionInterfaces.td"
include "mlir/IR/CommonAttrConstraints.td"


def ADF_Dialect : Dialect {
  let name = "adf";
  let summary = "A dialect for the AIE dataflow graph (ADF)";
  let description = [{
    The `adf` dialect defines the data movement, physical connection,
    placement of AIE cores. This dialect will be translated into the
    C/C++ graph representation.
  }];

  let cppNamespace = "::mlir::aries::adf";

  let useDefaultTypePrinterParser = 1;
}

#endif  // ARIES_DIALECT_ARIES_ADF_DIALECT_TD