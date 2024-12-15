#include "mlir/InitAllTranslations.h"
#include "mlir/Support/LogicalResult.h"
#include "mlir/Tools/mlir-translate/MlirTranslateMain.h"
#include "aries/Translation/Emitter.h"
#include "aries/Dialect/ADF/ADFDialect.h"

int main(int argc, char **argv) {
  mlir::registerAllTranslations();
  mlir::aries::registerAriesEmitters();

  return mlir::failed(
      mlir::mlirTranslateMain(argc, argv, "Aries ADF Translation Tool"));
}