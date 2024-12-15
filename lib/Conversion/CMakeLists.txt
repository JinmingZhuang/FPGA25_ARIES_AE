get_property(conversion_libs GLOBAL PROPERTY MLIR_CONVERSION_LIBS)

add_mlir_library(MLIRAriesLowerToADF
  Passes.cpp
  AriesLowerToADF.cpp

  ADDITIONAL_HEADER_DIRS
  ${PROJECT_SOURCE_DIR}/include/aries/Conversion
  
  DEPENDS
  MLIRAriesPassesIncGen
  MLIRAriesLowerToADFPassIncGen

  LINK_LIBS PUBLIC
  ${conversion_libs}
  MLIRADF
  MLIRIR
  MLIRPass
  MLIRTransforms
  MLIRAriesPasses
  )