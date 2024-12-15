LLVM_DIR=`realpath ${1:-"$PWD/externals/llvm-project"}`
BUILD_DIR=build
INSTALL_DIR=install

PYTHON_ROOT=`pip3 show pybind11 | grep Location | awk '{print $2}'`

mkdir -p $LLVM_DIR/$BUILD_DIR
mkdir -p $LLVM_DIR/$INSTALL_DIR

# Enter a sub-shell to avoid messing up with current directory in case of error
cd $LLVM_DIR
# Make mlir_async_runtime library's symbol visible
# so that we can link to this library in channel sim tests
sed -i '/set_property(TARGET mlir_async_runtime PROPERTY CXX_VISIBILITY_PRESET hidden)/d' ./mlir/lib/ExecutionEngine/CMakeLists.txt
cd $BUILD_DIR
set -o pipefail
set -e

CMAKE_CONFIGS="\
    -GNinja \
    -DCMAKE_C_COMPILER=clang \
    -DCMAKE_CXX_COMPILER=clang++ \
    -DLLVM_USE_LINKER=lld \
    -DPython3_FIND_VIRTUALENV=ONLY \
    -DLLVM_BUILD_EXAMPLES=OFF \
    -DLLVM_BUILD_UTILS=ON \
    -DLLVM_INSTALL_UTILS=ON \
    -DCMAKE_INSTALL_PREFIX=../$INSTALL_DIR \
    -DLLVM_ENABLE_PROJECTS=clang;lld;mlir \
    -DLLVM_TARGETS_TO_BUILD:STRING=X86;ARM;AArch64; \
    -DCMAKE_BUILD_TYPE=Release \
    -DLLVM_BUILD_LLVM_DYLIB=OFF \
    -DLLVM_LINK_LLVM_DYLIB=OFF \
    -DCLANG_LINK_CLANG_DYLIB=OFF \
    -DMLIR_BUILD_MLIR_DYLIB=OFF \
    -DLLVM_INCLUDE_UTILS=ON \
    -DLLVM_BUILD_TOOLS=ON \
    -DLLVM_INSTALL_TOOLCHAIN_ONLY=OFF \
    -DLLVM_ENABLE_ASSERTIONS=ON \
    -DLLVM_OPTIMIZED_TABLEGEN=OFF \
    -DMLIR_ENABLE_BINDINGS_PYTHON=ON \
    -Dpybind11_DIR=${PYTHON_ROOT}/pybind11/share/cmake/pybind11 \
    -DLLVM_DISTRIBUTION_COMPONENTS=cmake-exports;not;count;FileCheck;MLIRPythonModules;mlir-cpu-runner;mlir-linalg-ods-yaml-gen;mlir-opt;mlir-reduce;mlir-tblgen;mlir-translate;mlir-headers;mlir-cmake-exports"


cmake $CMAKE_CONFIGS ../llvm 2>&1 | tee cmake.log
ninja 2>&1 | tee ninja.log
ninja install 2>&1 | tee ninja-install.log