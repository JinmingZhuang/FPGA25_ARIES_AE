# Aries
## Installation Guide

### Prerequisites
```
cmake 3.29.1 
clang
lld
python 3.8.x
ninja
AMD Vitis 2023.1
```

### 1. Download Aries & Submodules
```sh
$ git clone --recursive https://github.com/JinmingZhuang/FPGA25_ARIES_AE.git
$ cd FPGA25_ARIES_AE
```

### 2. Setup Python Virtual Environment
```sh
source utils/setup_python_packages.sh
source sandbox/bin/activate
```

### 3. Build LLVM & MLIR Projects
```sh
source utils/build-llvm.sh
```

### 4. Build MLIR-AIE Project 
#### Need to specify using local cmake instead of Vitis cmake inside "utils/build-mlir-aie.sh"
```sh
source /tools/Xilinx/Vitis/2023.1/settings64.sh
source utils/build-mlir-aie.sh
```

### 5. Build Aries Project
```sh
source utils/build-aries.sh
export PATH=$PATH:$PWD/build/bin
```


##  Test Examples
### 1. GEMM (FP32)
#### Generate code for Host + PL + AIE
```sh
cd example/example_gemm/fp32
make all PROJECT_NAME=my_project
```

#### Compile the generated project
```sh
cd my_project
make all
```