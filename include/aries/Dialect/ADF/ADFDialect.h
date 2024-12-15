#ifndef ARIES_DIALECT_ARIES_ADF_DIALECT_H
#define ARIES_DIALECT_ARIES_ADF_DIALECT_H

#include "mlir/IR/Builders.h"
#include "mlir/IR/BuiltinAttributes.h"
#include "mlir/IR/BuiltinOps.h"
#include "mlir/IR/BuiltinTypes.h"
#include "mlir/IR/DialectImplementation.h"
#include "mlir/IR/Dialect.h"
#include "mlir/IR/OpDefinition.h"
#include "mlir/IR/OpImplementation.h"
#include "mlir/IR/SymbolTable.h"
#include "mlir/IR/TypeSupport.h"
#include "mlir/IR/Types.h"
#include "mlir/Interfaces/CallInterfaces.h"
#include "mlir/Interfaces/FunctionInterfaces.h"
#include "mlir/Interfaces/InferTypeOpInterface.h"

#include "aries/Dialect/ADF/ADFDialect.h.inc"
#include "aries/Dialect/ADF/ADFEnums.h.inc"

#define GET_TYPEDEF_CLASSES
#include "aries/Dialect/ADF/ADFTypes.h.inc"

#define GET_OP_CLASSES
#include "aries/Dialect/ADF/ADF.h.inc"

#define GET_ATTRDEF_CLASSES
#include "aries/Dialect/ADF/ADFAttrs.h.inc"

#endif // ARIES_DIALECT_ARIES_ADF_DIALECT_H