add_mlir_dialect_library(MLIRADF
  ADFDialect.cpp
  ADFOps.cpp

  ADDITIONAL_HEADER_DIRS
  ${PROJECT_SOURCE_DIR}/include/aries

  DEPENDS
  MLIRADFEnumsIncGen
  MLIRADFAttrsIncGen

	LINK_LIBS PUBLIC
  MLIRIR
	)