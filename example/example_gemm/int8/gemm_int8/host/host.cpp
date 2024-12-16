
//===----------------------------------------------------------------------===//
//
// Automatically generated file for host.cpp
//
//===----------------------------------------------------------------------===//
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <iostream>
#include <time.h>
#include <vector>
#include <math.h>
#include <string>

// This is used for the PL Kernels
#include "experimental/xrt_bo.h"
#include "experimental/xrt_device.h"
#include "experimental/xrt_kernel.h"


// Using the ADF API that call XRT API
#include "adf/adf_api/XRTConfig.h"
//#include "../aie/adf_graph.h"

using namespace std;
void gemm_host(
  int8_t v3527[2560][65536],
  int8_t v3528[65536][4096],
  int8_t v3529[2560][4096]
){
  for (int v3530 = 0; v3530 < 2560; v3530++) {	// L5882
    for (int v3531 = 0; v3531 < 4096; v3531++) {	// L5883
      for (int v3532 = 0; v3532 < 65536; v3532++) {	// L5884
        int8_t v3533 = v3527[v3530][v3532];	// L5885
        int8_t v3534 = v3528[v3532][v3531];	// L5886
        int8_t v3535 = v3533 * v3534;	// L5887
        int8_t v3536 = v3529[v3530][v3531];	// L5888
        int8_t v3537 = v3536 + v3535;	// L5889
        v3529[v3530][v3531] = v3537;	// L5890
      }
    }
  }
}



int main(int argc, char **argv) {
  char* xclbinFilename = argv[1];
  
  // Open xclbin
  auto device = xrt::device(0); //device index=0
	auto uuid = device.load_xclbin(xclbinFilename);
	auto dhdl = xrtDeviceOpenFromXcl(device);

  // PL control
  auto top_0= xrt::kernel(device, uuid, "top:{top_0}");

  // Define arguments
  auto in_bohdl0 = xrt::bo(device, 167772160 * sizeof(int8_t), top_0.group_id(0));
  auto in_bomapped0 = in_bohdl0.map<int8_t*>();
  for (unsigned i=0; i < 167772160; i++){
    in_bomapped0[i] = (int8_t)(rand()%5);
  }
  in_bohdl0.sync(XCL_BO_SYNC_BO_TO_DEVICE, 167772160 * sizeof(int8_t), 0);

  auto in_bohdl1 = xrt::bo(device, 268435456 * sizeof(int8_t), top_0.group_id(0));
  auto in_bomapped1 = in_bohdl1.map<int8_t*>();
  for (unsigned i=0; i < 268435456; i++){
    in_bomapped1[i] = (int8_t)(rand()%5);
  }
  in_bohdl1.sync(XCL_BO_SYNC_BO_TO_DEVICE, 268435456 * sizeof(int8_t), 0);

  auto out_bohdl0 = xrt::bo(device, 10485760 * sizeof(int8_t), top_0.group_id(0));
  auto out_bomapped0 = out_bohdl0.map<int8_t*>();

  // AI Engine Graph Control
  std::cout << "Graph run\n";
  auto adf_cell0_gr0= xrt::graph(device, uuid, "adf_cell0_gr0");
  adf_cell0_gr0.run(-1);

  // Set arguments of the PL function
  xrt::run top_0_run= xrt::run(top_0);
  top_0_run.set_arg(0, in_bohdl0);
  top_0_run.set_arg(1, in_bohdl1);
  top_0_run.set_arg(2, out_bohdl0);
  std::cout << "Kernel run\n";

  //profile performance
  int iter = 10;
  const int I=2560;
  const int J=4096;
  const int K=65536;
  double kernel_time_in_sec = 0;
  std::chrono::duration<double> kernel_time(0);
  auto kernel_start = std::chrono::high_resolution_clock::now();

  for (int i = 0; i<iter; i++){
    top_0_run.start();
    top_0_run.wait();
  }
  
  std::cout << "Kernel run finished!\n";
  auto kernel_end = std::chrono::high_resolution_clock::now();
  kernel_time = std::chrono::duration<double>(kernel_end - kernel_start);
  kernel_time_in_sec = kernel_time.count();
  double TOPS = (double)(I * K) * (double) (J * 2 * iter * 1e-9) / kernel_time_in_sec;
  std::cout << "MM Size:"<< I << " * " << K << " * " << J << std::endl;
  std::cout << "Total time is: "<< kernel_time_in_sec <<"s, TOPS = " << TOPS << " GOPS/s" << std::endl;

  // Sync output buffer back to host
  out_bohdl0.sync(XCL_BO_SYNC_BO_FROM_DEVICE , 10485760 * sizeof(int8_t), 0);
  std::cout << "Output buffer sync back finished\n";

  std::cout << "Host Run Finished!\n";
  return 0;
}


