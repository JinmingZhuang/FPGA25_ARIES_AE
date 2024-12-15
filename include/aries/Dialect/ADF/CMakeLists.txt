add_mlir_dialect(ADF adf)

set(LLVM_TARGET_DEFINITIONS ADF.td)
mlir_tablegen(ADFEnums.h.inc -gen-enum-decls)
mlir_tablegen(ADFEnums.cpp.inc -gen-enum-defs)
add_public_tablegen_target(MLIRADFEnumsIncGen)
add_dependencies(aries-headers MLIRADFEnumsIncGen)

set(LLVM_TARGET_DEFINITIONS ADFAttrs.td)
mlir_tablegen(ADFAttrs.h.inc -gen-attrdef-decls)
mlir_tablegen(ADFAttrs.cpp.inc -gen-attrdef-defs)
add_public_tablegen_target(MLIRADFAttrsIncGen)
add_dependencies(aries-headers MLIRADFAttrsIncGen)