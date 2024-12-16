
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
void ttmc_host(
  int32_t v3016[4][1024][4096],
  int32_t v3017[1024][512],
  int32_t v3018[4096][768],
  int32_t v3019[4][512][768]
){
  for (int v3020 = 0; v3020 < 4; v3020++) {	// L5110
    for (int v3021 = 0; v3021 < 512; v3021++) {	// L5111
      for (int v3022 = 0; v3022 < 768; v3022++) {	// L5112
        for (int v3023 = 0; v3023 < 1024; v3023++) {	// L5113
          for (int v3024 = 0; v3024 < 4096; v3024++) {	// L5114
            int32_t v3025 = v3016[v3020][v3023][v3024];	// L5115
            int32_t v3026 = v3017[v3023][v3021];	// L5116
            int32_t v3027 = v3018[v3024][v3022];	// L5117
            int32_t v3028 = v3025 * v3026;	// L5118
            int32_t v3029 = v3028 * v3027;	// L5119
            int32_t v3030 = v3019[v3020][v3021][v3022];	// L5120
            int32_t v3031 = v3030 + v3029;	// L5121
            v3019[v3020][v3021][v3022] = v3031;	// L5122
          }
        }
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
  auto in_bohdl0 = xrt::bo(device, 16777216 * sizeof(int32_t), top_0.group_id(0));
  auto in_bomapped0 = in_bohdl0.map<int32_t*>();
  for (unsigned i=0; i < 16777216; i++){
    in_bomapped0[i] = (int32_t)(rand()%5);
  }
  in_bohdl0.sync(XCL_BO_SYNC_BO_TO_DEVICE, 16777216 * sizeof(int32_t), 0);

  auto in_bohdl1 = xrt::bo(device, 524288 * sizeof(int32_t), top_0.group_id(0));
  auto in_bomapped1 = in_bohdl1.map<int32_t*>();
  for (unsigned i=0; i < 524288; i++){
    in_bomapped1[i] = (int32_t)(rand()%5);
  }
  in_bohdl1.sync(XCL_BO_SYNC_BO_TO_DEVICE, 524288 * sizeof(int32_t), 0);

  auto in_bohdl2 = xrt::bo(device, 3145728 * sizeof(int32_t), top_0.group_id(0));
  auto in_bomapped2 = in_bohdl2.map<int32_t*>();
  for (unsigned i=0; i < 3145728; i++){
    in_bomapped2[i] = (int32_t)(rand()%5);
  }
  in_bohdl2.sync(XCL_BO_SYNC_BO_TO_DEVICE, 3145728 * sizeof(int32_t), 0);

  auto out_bohdl0 = xrt::bo(device, 1572864 * sizeof(int32_t), top_0.group_id(0));
  auto out_bomapped0 = out_bohdl0.map<int32_t*>();

  // AI Engine Graph Control
  std::cout << "Graph run\n";
  auto adf_cell0_gr0= xrt::graph(device, uuid, "adf_cell0_gr0");
  adf_cell0_gr0.run(-1);

  // Set arguments of the PL function
  xrt::run top_0_run= xrt::run(top_0);
  top_0_run.set_arg(0, in_bohdl0);
  top_0_run.set_arg(1, in_bohdl1);
  top_0_run.set_arg(2, in_bohdl2);
  top_0_run.set_arg(3, out_bohdl0);
  std::cout << "Kernel run\n";
  
   //profile performance
  int iter = 10;
  const int I=4;
  const int J=512;
  const int K=768;
  const int L=1024;
  const int M=4096;
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
  double TOPS = (double)(I * K) * (double) (J * L)  * ( M * 2 * 2 * iter * 1e-9) / kernel_time_in_sec;
  std::cout << "TTMc Size:"<< I << " * " << J << " * " << K << " * " << L << " * " << M << std::endl;
  std::cout << "Total time is: "<< kernel_time_in_sec <<"s, TOPS = " << TOPS << " GOPS/s" << std::endl;

  // Sync output buffer back to host
  out_bohdl0.sync(XCL_BO_SYNC_BO_FROM_DEVICE , 1572864 * sizeof(int32_t), 0);
  std::cout << "Output buffer sync back finished\n";

  std::cout << "Host Run Finished!\n";
  return 0;
}


