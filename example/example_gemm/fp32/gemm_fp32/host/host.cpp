
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
  float v3765[2816][8192],
  float v3766[8192][3072],
  float v3767[2816][3072]
){
  for (int v3768 = 0; v3768 < 2816; v3768++) {	// L6246
    for (int v3769 = 0; v3769 < 3072; v3769++) {	// L6247
      for (int v3770 = 0; v3770 < 8192; v3770++) {	// L6248
        float v3771 = v3765[v3768][v3770];	// L6249
        float v3772 = v3766[v3770][v3769];	// L6250
        float v3773 = v3771 * v3772;	// L6251
        float v3774 = v3767[v3768][v3769];	// L6252
        float v3775 = v3774 + v3773;	// L6253
        v3767[v3768][v3769] = v3775;	// L6254
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
  auto in_bohdl0 = xrt::bo(device, 23068672 * sizeof(float), top_0.group_id(0));
  auto in_bomapped0 = in_bohdl0.map<float*>();
  for (unsigned i=0; i < 23068672; i++){
    in_bomapped0[i] = (float)(rand()%5);
  }
  in_bohdl0.sync(XCL_BO_SYNC_BO_TO_DEVICE, 23068672 * sizeof(float), 0);

  auto in_bohdl1 = xrt::bo(device, 25165824 * sizeof(float), top_0.group_id(0));
  auto in_bomapped1 = in_bohdl1.map<float*>();
  for (unsigned i=0; i < 25165824; i++){
    in_bomapped1[i] = (float)(rand()%5);
  }
  in_bohdl1.sync(XCL_BO_SYNC_BO_TO_DEVICE, 25165824 * sizeof(float), 0);

  auto out_bohdl0 = xrt::bo(device, 8650752 * sizeof(float), top_0.group_id(0));
  auto out_bomapped0 = out_bohdl0.map<float*>();

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
  const int J=3072;
  const int K=8192;
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
  std::cout << "Total time is: "<< kernel_time_in_sec <<"s, TOPS = " << TOPS << " GFLOPS/s" << std::endl;

  // Sync output buffer back to host
  out_bohdl0.sync(XCL_BO_SYNC_BO_FROM_DEVICE , 8650752 * sizeof(float), 0);
  std::cout << "Output buffer sync back finished\n";

  std::cout << "Host Run Finished!\n";
  return 0;
}


