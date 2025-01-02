##  Reproduce ARIES Experiment Results
### We use the fp32 GEMM as an example to demonstrate the whole flow for end-to-end on-board testing. <br><br>

## *** Step 1: VCK190 compilation environment setup

### Please make sure xilinx-versal-common-v2023.1 is downloaded from AMD Website:<br/>
https://www.xilinx.com/member/forms/download/xef.html?filename=xilinx-versal-common-v2023.1_05080224.tar.gz
### Unzip and install
```sh 
tar -xf xilinx-versal-common-v2023.1.tar.gz
cd xilinx-versal-common-v2023.1
sh sdk.sh
```

### Setup Vitis environment
```sh 
source /opt/tools/xilinx/Vitis/2023.1/settings64.sh
source /opt/xilinx/xrt/setup.sh
unset LD_LIBRARY_PATH (If needed)
source /opt/petalinux/2023.1/environment-setup-cortexa72-cortexa53-xilinx-linux
```


## ***  Step 2: Compilation
### Flow 1: Use pre-built binary files (Takes around 5 hours for compilation, after this jump to step 3). 
```sh
cd example/example_gemm/fp32/gemm_fp32
make package EDGE_COMMON_SW_PATH=${PATH_Include_xilinx-versal-common-v2023.1}
```

### Flow 2: Run end-to-end flows.
### Create ARIES Initial IR from user defined ARIES Python-based frontend. (Please refer here to setup the Python3.12 environment: [Python3.12 Setup](#python312-environment-setup-for-aries-examples))
```sh
cd example/example_gemm/fp32
python3.12 gemm_fp32.py >gemm.mlir
```

### Generate code for Host + PL + AIE (Need to have ARIES installed, i.e.,  tools including aries-opt and aries-translate should run correctly)
```sh
make all PROJECT_NAME=my_project
```

### Compile the generated project
```sh
cd my_project
make package EDGE_COMMON_SW_PATH=${PATH_Include_xilinx-versal-common-v2023.1}
```

## *** Step 3: On-board test

### 1. After step 2, sd_card.img should be generated under package_hw.

### 2. Users can flash it into a micro sd card and boot up the system with the following default user info. 
```sh
[Username]: petalinux; [passwd]: root.
```

### 3. Then execute the following commands to get the execution results. 
```sh
sudo su
cd /run/media/mmcblk0p1/
./hostexe vck190_aie_base_graph_hw.xclbin
```

## *** Python3.12 Environment Setup for ARIES Examples
### Before running the end-to-end flow, a virtual Python environment with version >3.12 is required to support the ARIES frontend. 

#### For example, Ubuntu users could follow the instructions below to install Python3.12 and setup the environment.
```sh
sudo apt-get install python3.12-dev
sudo apt install python3.12-venv
python3.12 -m venv aries
source aries/bin/activate
python3.12 -m pip install --upgrade pip
pip3 install numpy astor
```