get_property(dialect_libs GLOBAL PROPERTY MLIR_DIALECT_LIBS)
get_property(conversion_libs GLOBAL PROPERTY MLIR_CONVERSION_LIBS)

set (LIBS
    ${dialect_libs}
    ${conversion_libs}
    MLIRAriesPasses
    MLIRAriesLowerToADF
    MLIROptLib
    MLIRPass
    MLIRADF
    AIE
    AIETransforms
    MLIRAIEVecDialect
    MLIRAIEVecTransformOps
    MLIRAIEVecTransforms
)

add_llvm_executable(aries-opt aries-opt.cpp)

llvm_update_compile_flags(aries-opt)

target_link_libraries(aries-opt PRIVATE ${LIBS})

mlir_check_all_link_libraries(aries-opt)