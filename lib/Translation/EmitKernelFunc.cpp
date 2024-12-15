#include "mlir/Tools/mlir-translate/Translation.h"
#include "aries/Translation/Emitter.h"

using namespace mlir;
using namespace aries;
using namespace func;

LogicalResult aries::emitKernelFunc(ModuleOp module, raw_ostream &os) {
  std::string kernel_header = R"XXX(
//===------------------------------------------------------------*- C++ -*-===//
//
// Automatically generated file for AIE kernel supported by Vitis Flow.
//
//===----------------------------------------------------------------------===//

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <aie_api/aie.hpp>
#include <aie_api/aie_adf.hpp>
#include <aie_api/utils.hpp>
#include <adf/io_buffer/io_buffer.h>
using namespace adf;
static int iteration = 0;
)XXX";

  for (auto func : module.getOps<FuncOp>()) {
    if(func->getAttr("adf.kernel")){
      auto funcName = func.getName();
      std::string split_header = "//_aries_split_//" + funcName.str()
                                 + ".cc//_aries_split_//";
      os << split_header;
      os << kernel_header;

      if (failed(aries::emitAIEVecToCpp(func,/*aieml=*/false,/*vitis=*/true, 
                                        /*enres=*/true, os)))
        return failure();
    }
  }

  return success();
}
