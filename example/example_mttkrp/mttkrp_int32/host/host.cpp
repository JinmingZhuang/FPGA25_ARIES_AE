
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
void mttkrp_host(
  int32_t v3220[64][768][2048],
  int32_t v3221[768][6144],
  int32_t v3222[2048][6144],
  int32_t v3223[64][6144]
){
  for (int v3224 = 0; v3224 < 64; v3224++) {	// L5283
    for (int v3225 = 0; v3225 < 6144; v3225++) {	// L5284
      for (int v3226 = 0; v3226 < 768; v3226++) {	// L5285
        for (int v3227 = 0; v3227 < 2048; v3227++) {	// L5286
          int32_t v3228 = v3220[v3224][v3226][v3227];	// L5287
          int32_t v3229 = v3221[v3226][v3225];	// L5288
          int32_t v3230 = v3222[v3227][v3225];	// L5289
          int32_t v3231 = v3228 * v3229;	// L5290
          int32_t v3232 = v3231 * v3230;	// L5291
          int32_t v3233 = v3223[v3224][v3225];	// L5292
          int32_t v3234 = v3233 + v3232;	// L5293
          v3223[v3224][v3225] = v3234;	// L5294
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
  auto in_bohdl0 = xrt::bo(device, 100663296 * sizeof(int32_t), top_0.group_id(0));
  auto in_bomapped0 = in_bohdl0.map<int32_t*>();
  for (unsigned i=0; i < 100663296; i++){
    in_bomapped0[i] = (int32_t)(rand()%5);
  }
  in_bohdl0.sync(XCL_BO_SYNC_BO_TO_DEVICE, 100663296 * sizeof(int32_t), 0);

  auto in_bohdl1 = xrt::bo(device, 4718592 * sizeof(int32_t), top_0.group_id(0));
  auto in_bomapped1 = in_bohdl1.map<int32_t*>();
  for (unsigned i=0; i < 4718592; i++){
    in_bomapped1[i] = (int32_t)(rand()%5);
  }
  in_bohdl1.sync(XCL_BO_SYNC_BO_TO_DEVICE, 4718592 * sizeof(int32_t), 0);

  auto in_bohdl2 = xrt::bo(device, 12582912 * sizeof(int32_t), top_0.group_id(0));
  auto in_bomapped2 = in_bohdl2.map<int32_t*>();
  for (unsigned i=0; i < 12582912; i++){
    in_bomapped2[i] = (int32_t)(rand()%5);
  }
  in_bohdl2.sync(XCL_BO_SYNC_BO_TO_DEVICE, 12582912 * sizeof(int32_t), 0);

  auto out_bohdl0 = xrt::bo(device, 393216 * sizeof(int32_t), top_0.group_id(0));
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
  const int I=64;
  const int J=6144;
  const int K=768;
  const int L=2048;
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
  double TOPS = (double)(I * K) * (double) (J * L * 2 * 2 * iter * 1e-9) / kernel_time_in_sec;
  std::cout << "MTTKRP Size:"<< I << " * " << J << " * " << K << " * " << L << std::endl;
  std::cout << "Total time is: "<< kernel_time_in_sec <<"s, TOPS = " << TOPS << " GOPS/s" << std::endl;

  // Sync output buffer back to host
  out_bohdl0.sync(XCL_BO_SYNC_BO_FROM_DEVICE , 393216 * sizeof(int32_t), 0);
  std::cout << "Output buffer sync back finished\n";

  std::cout << "Host Run Finished!\n";
  return 0;
}


