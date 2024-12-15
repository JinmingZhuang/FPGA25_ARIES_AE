get_property(dialect_libs GLOBAL PROPERTY MLIR_DIALECT_LIBS)
get_property(translation_libs GLOBAL PROPERTY MLIR_TRANSLATION_LIBS)

set(LLVM_LINK_COMPONENTS
  Support
  )

add_llvm_executable(aries-translate
aries-translate.cpp
  )

llvm_update_compile_flags(aries-translate)

target_link_libraries(aries-translate
  PRIVATE
  ${dialect_libs}
  ${translation_libs}
  MLIRIR
  MLIRPass
  MLIRTranslateLib
  MLIRSupport
  MLIRADF
  MLIRARIESEmitAriesCpp
  AIE
  AIETransforms
  AIETargets
  MLIRTargetAIEVecCpp
  MLIRAIEVecDialect
  )

mlir_check_all_link_libraries(aries-translate)