add_mlir_dialect_library(MLIRBufferizationDialect
  AllocationOpInterface.cpp
  BufferizableOpInterface.cpp
  BufferDeallocationOpInterface.cpp
  BufferizationOps.cpp
  BufferizationDialect.cpp
  BufferViewFlowOpInterface.cpp
  UnstructuredControlFlow.cpp
  BufferizationTypeInterfaces.cpp

  ADDITIONAL_HEADER_DIRS
  ${MLIR_MAIN_INCLUDE_DIR}/mlir/Dialect/Bufferization

  DEPENDS
  MLIRAllocationOpInterfaceIncGen
  MLIRBufferizationOpsIncGen
  MLIRBufferizationEnumsIncGen

  LINK_LIBS PUBLIC
  MLIRAffineDialect
  MLIRArithDialect
  MLIRDestinationStyleOpInterface
  MLIRDialect
  MLIRFuncDialect
  MLIRFunctionInterfaces
  MLIRIR
  MLIRSparseTensorDialect
  MLIRSubsetOpInterface
  MLIRTensorDialect
  MLIRMemRefDialect
  )
