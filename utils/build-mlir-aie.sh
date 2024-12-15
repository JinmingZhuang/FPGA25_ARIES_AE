LLVM_DIR=`realpath ${1:-"$PWD/externals/llvm-project"}`
AIE_DIR=`realpath ${2:-"$PWD/externals/mlir-aie"}`
CMAKEMODULES_DIR=`realpath ${3:-"$PWD/externals/mlir-aie/cmake/modulesXilinx"}`

BUILD_DIR=build
INSTALL_DIR=install

mkdir -p $AIE_DIR/$BUILD_DIR
mkdir -p $AIE_DIR/$INSTALL_DIR
cd $AIE_DIR/$BUILD_DIR

/usr/local/bin/cmake -GNinja \
    -DCMAKE_C_COMPILER=clang \
    -DCMAKE_CXX_COMPILER=clang++ \
    -DLLVM_USE_LINKER=lld \
    -DLLVM_DIR=${LLVM_DIR}/build/lib/cmake/llvm \
    -DMLIR_DIR=${LLVM_DIR}/build/lib/cmake/mlir \
    -DCMAKE_MODULE_PATH=${CMAKEMODULES_DIR}/ \
    -DCMAKE_INSTALL_PREFIX="../${INSTALL_DIR}" \
    -DBUILD_SHARED_LIBS=off \
    -DCMAKE_BUILD_TYPE=Release \
    -DLLVM_ENABLE_ASSERTIONS=ON \
    -DAIE_ENABLE_BINDINGS_PYTHON=ON \
    -DAIE_ENABLE_GENERATE_CDO_DIRECT=OFF \
    .. |& tee cmake.log

ninja |& tee ninja.log
ninja install |& tee ninja-install.log