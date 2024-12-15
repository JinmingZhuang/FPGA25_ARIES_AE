PRO_PATH=$PWD
LLVM_DIR=`realpath ${1:-"$PWD/externals/llvm-project"}`
AIE_DIR=`realpath ${2:-"$PWD/externals/mlir-aie"}`

mkdir -p ${PRO_PATH}/build && cd ${PRO_PATH}/build

/usr/local/bin/cmake ../ \
    -GNinja \
    -DLLVM_DIR=$LLVM_DIR/build/lib/cmake/llvm \
    -DMLIR_DIR=$LLVM_DIR/build/lib/cmake/mlir \
    -DAIE_DIR=$AIE_DIR/build/lib/cmake/aie \
    -DCMAKE_BUILD_TYPE=Debug \
    -DLLVM_ENABLE_ASSERTIONS=ON \
    -DLLVM_USE_LINKER=lld \
    -DCMAKE_C_COMPILER=clang \
    -DCMAKE_CXX_COMPILER=clang++

ninja

cd ${PRO_PATH}