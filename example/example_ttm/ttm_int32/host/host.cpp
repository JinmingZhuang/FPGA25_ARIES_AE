
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
void ttm_host(
  int32_t v3856[4][1408][8192],
  int32_t v3857[8192][1536],
  int32_t v3858[4][1408][1536]
){
  for (int v3859 = 0; v3859 < 4; v3859++) {	// L6454
    for (int v3860 = 0; v3860 < 1408; v3860++) {	// L6455
      for (int v3861 = 0; v3861 < 1536; v3861++) {	// L6456
        for (int v3862 = 0; v3862 < 8192; v3862++) {	// L6457
          int32_t v3863 = v3856[v3859][v3860][v3862];	// L6458
          int32_t v3864 = v3857[v3862][v3861];	// L6459
          int32_t v3865 = v3863 * v3864;	// L6460
          int32_t v3866 = v3858[v3859][v3860][v3861];	// L6461
          int32_t v3867 = v3866 + v3865;	// L6462
          v3858[v3859][v3860][v3861] = v3867;	// L6463
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
  auto in_bohdl0 = xrt::bo(device, 46137344 * sizeof(int32_t), top_0.group_id(0));
  auto in_bomapped0 = in_bohdl0.map<int32_t*>();
  for (unsigned i=0; i < 46137344; i++){
    in_bomapped0[i] = (int32_t)(rand()%5);
  }
  in_bohdl0.sync(XCL_BO_SYNC_BO_TO_DEVICE, 46137344 * sizeof(int32_t), 0);

  auto in_bohdl1 = xrt::bo(device, 12582912 * sizeof(int32_t), top_0.group_id(0));
  auto in_bomapped1 = in_bohdl1.map<int32_t*>();
  for (unsigned i=0; i < 12582912; i++){
    in_bomapped1[i] = (int32_t)(rand()%5);
  }
  in_bohdl1.sync(XCL_BO_SYNC_BO_TO_DEVICE, 12582912 * sizeof(int32_t), 0);

  auto out_bohdl0 = xrt::bo(device, 8650752 * sizeof(int32_t), top_0.group_id(0));
  auto out_bomapped0 = out_bohdl0.map<int32_t*>();

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
  const int I=4;
  const int J=1408;
  const int K=1536;
  const int L=8192;
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
  double TOPS = (double)(I * K) * (double) (J * L * 2 * iter * 1e-9) / kernel_time_in_sec;
  std::cout << "TTM Size:"<< I << " * " << J << " * " << K << " * " << L << std::endl;
  std::cout << "Total time is: "<< kernel_time_in_sec <<"s, TOPS = " << TOPS << " GOPS/s" << std::endl;

  // Sync output buffer back to host
  out_bohdl0.sync(XCL_BO_SYNC_BO_FROM_DEVICE , 8650752 * sizeof(int32_t), 0);
  std::cout << "Output buffer sync back finished\n";

  std::cout << "Host Run Finished!\n";
  return 0;
}


