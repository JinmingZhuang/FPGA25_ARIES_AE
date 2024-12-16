
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
  int16_t v3765[2816][32768],
  int16_t v3766[32768][4096],
  int16_t v3767[2816][4096]
){
  for (int v3768 = 0; v3768 < 2816; v3768++) {	// L6270
    for (int v3769 = 0; v3769 < 4096; v3769++) {	// L6271
      for (int v3770 = 0; v3770 < 32768; v3770++) {	// L6272
        int16_t v3771 = v3765[v3768][v3770];	// L6273
        int16_t v3772 = v3766[v3770][v3769];	// L6274
        int16_t v3773 = v3771 * v3772;	// L6275
        int16_t v3774 = v3767[v3768][v3769];	// L6276
        int16_t v3775 = v3774 + v3773;	// L6277
        v3767[v3768][v3769] = v3775;	// L6278
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
  auto in_bohdl0 = xrt::bo(device, 92274688 * sizeof(int16_t), top_0.group_id(0));
  auto in_bomapped0 = in_bohdl0.map<int16_t*>();
  for (unsigned i=0; i < 92274688; i++){
    in_bomapped0[i] = (int16_t)(rand()%5);
  }
  in_bohdl0.sync(XCL_BO_SYNC_BO_TO_DEVICE, 92274688 * sizeof(int16_t), 0);

  auto in_bohdl1 = xrt::bo(device, 134217728 * sizeof(int16_t), top_0.group_id(0));
  auto in_bomapped1 = in_bohdl1.map<int16_t*>();
  for (unsigned i=0; i < 134217728; i++){
    in_bomapped1[i] = (int16_t)(rand()%5);
  }
  in_bohdl1.sync(XCL_BO_SYNC_BO_TO_DEVICE, 134217728 * sizeof(int16_t), 0);

  auto out_bohdl0 = xrt::bo(device, 11534336 * sizeof(int16_t), top_0.group_id(0));
  auto out_bomapped0 = out_bohdl0.map<int16_t*>();

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
  const int I=2816;
  const int J=4096;
  const int K=32768;
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
  out_bohdl0.sync(XCL_BO_SYNC_BO_FROM_DEVICE , 11534336 * sizeof(int16_t), 0);
  std::cout << "Output buffer sync back finished\n";

  std::cout << "Host Run Finished!\n";
  return 0;
}


