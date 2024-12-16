//_aries_split_//kernel_gemm0.cc//_aries_split_//
//===------------------------------------------------------------*- C++ -*-===//
//
// Automatically generated file for AIE kernel supported by Vitis Flow.
//
//===----------------------------------------------------------------------===//

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <aie_api/aie.hpp>
#include <aie_api/aie_adf.hpp>
#include <aie_api/utils.hpp>
#include <adf/io_buffer/io_buffer.h>
using namespace adf;
static int iteration = 0;
void kernel_gemm0(input_buffer<float, adf::extents<1024>>&  __restrict in0, input_buffer<float, adf::extents<1024>>&  __restrict in1, output_buffer<float, adf::extents<1024>>&  __restrict out0) {
  float * __restrict v1 = (float *)in0.data();
  float * __restrict v2 = (float *)in1.data();
  float * __restrict v3 = (float *)out0.data();
  size_t v4 = 8;
  size_t v5 = 7;
  size_t v6 = 6;
  size_t v7 = 5;
  size_t v8 = 4;
  size_t v9 = 3;
  size_t v10 = 2;
  size_t v11 = 1;
  size_t v12 = 32;
  size_t v13 = 0;
  aie::vector<float,8> v14{(float)0.0e+00, (float)0.0e+00, (float)0.0e+00, (float)0.0e+00, (float)0.0e+00, (float)0.0e+00, (float)0.0e+00, (float)0.0e+00};
  for (size_t v15 = v13; v15 < v12; v15 += v11)
  chess_prepare_for_pipelining
  chess_loop_range(32, 32)
  {
    aie::store_v(v3+32*v15+v13,v14);
    aie::store_v(v3+32*v15+v11,v14);
    aie::store_v(v3+32*v15+v10,v14);
    aie::store_v(v3+32*v15+v9,v14);
    aie::store_v(v3+32*v15+v8,v14);
    aie::store_v(v3+32*v15+v7,v14);
    aie::store_v(v3+32*v15+v6,v14);
    aie::store_v(v3+32*v15+v5,v14);
  }
  for (size_t v16 = v13; v16 < v12; v16 += v11)
  chess_prepare_for_pipelining
  chess_loop_range(32, 32)
  {
    for (size_t v17 = v13; v17 < v12; v17 += v4)
    chess_prepare_for_pipelining
    chess_loop_range(4, 4)
    {
      aie::vector<float,8> v18 = aie::load_v<8>(v3+32*v16+v17);
      for (size_t v19 = v13; v19 < v12; v19 += v4)
      chess_prepare_for_pipelining
      chess_loop_range(4, 4)
      {
        aie::vector<float,8> v20 = aie::load_v<8>(v1+32*v16+v19);
        aie::vector<float,8> v21 = aie::load_v<8>(v2+32*v19+v17);
        aie::vector<float,16> v22 = concat(v21, v21);
        v18 = fpmac(v18, v22, 0, 0x76543210, v20, 0, 0x00000000);
        size_t v23 = v19 + v11;
        aie::vector<float,8> v24 = aie::load_v<8>(v2+32*v23+v17);
        aie::vector<float,16> v25 = concat(v24, v24);
        v18 = fpmac(v18, v25, 0, 0x76543210, v20, 1, 0x00000000);
        size_t v26 = v19 + v10;
        aie::vector<float,8> v27 = aie::load_v<8>(v2+32*v26+v17);
        aie::vector<float,16> v28 = concat(v27, v27);
        v18 = fpmac(v18, v28, 0, 0x76543210, v20, 2, 0x00000000);
        size_t v29 = v19 + v9;
        aie::vector<float,8> v30 = aie::load_v<8>(v2+32*v29+v17);
        aie::vector<float,16> v31 = concat(v30, v30);
        v18 = fpmac(v18, v31, 0, 0x76543210, v20, 3, 0x00000000);
        size_t v32 = v19 + v8;
        aie::vector<float,8> v33 = aie::load_v<8>(v2+32*v32+v17);
        aie::vector<float,16> v34 = concat(v33, v33);
        v18 = fpmac(v18, v34, 0, 0x76543210, v20, 4, 0x00000000);
        size_t v35 = v19 + v7;
        aie::vector<float,8> v36 = aie::load_v<8>(v2+32*v35+v17);
        aie::vector<float,16> v37 = concat(v36, v36);
        v18 = fpmac(v18, v37, 0, 0x76543210, v20, 5, 0x00000000);
        size_t v38 = v19 + v6;
        aie::vector<float,8> v39 = aie::load_v<8>(v2+32*v38+v17);
        aie::vector<float,16> v40 = concat(v39, v39);
        v18 = fpmac(v18, v40, 0, 0x76543210, v20, 6, 0x00000000);
        size_t v41 = v19 + v5;
        aie::vector<float,8> v42 = aie::load_v<8>(v2+32*v41+v17);
        aie::vector<float,16> v43 = concat(v42, v42);
        v18 = fpmac(v18, v43, 0, 0x76543210, v20, 7, 0x00000000);
        aie::store_v(v3+32*v16+v17,v18);
      }
    }
  }
  return;
}

//_aries_split_//kernel_gemm.cc//_aries_split_//
//===------------------------------------------------------------*- C++ -*-===//
//
// Automatically generated file for AIE kernel supported by Vitis Flow.
//
//===----------------------------------------------------------------------===//

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <aie_api/aie.hpp>
#include <aie_api/aie_adf.hpp>
#include <aie_api/utils.hpp>
#include <adf/io_buffer/io_buffer.h>
using namespace adf;
static int iteration = 0;
void kernel_gemm(input_buffer<float, adf::extents<1024>>&  __restrict in0, input_buffer<float, adf::extents<1024>>&  __restrict in1, input_buffer<float, adf::extents<1024>>&  __restrict in2, output_buffer<float, adf::extents<1024>>&  __restrict out0) {
  float * __restrict v1 = (float *)in0.data();
  float * __restrict v2 = (float *)in1.data();
  float * __restrict v3 = (float *)in2.data();
  float * __restrict v4 = (float *)out0.data();
  size_t v5 = 7;
  size_t v6 = 6;
  size_t v7 = 5;
  size_t v8 = 4;
  size_t v9 = 3;
  size_t v10 = 2;
  size_t v11 = 8;
  size_t v12 = 1;
  size_t v13 = 32;
  size_t v14 = 0;
  for (size_t v15 = v14; v15 < v13; v15 += v12)
  chess_prepare_for_pipelining
  chess_loop_range(32, 32)
  {
    for (size_t v16 = v14; v16 < v13; v16 += v11)
    chess_prepare_for_pipelining
    chess_loop_range(4, 4)
    {
      aie::vector<float,8> v17 = aie::load_v<8>(v3+32*v15+v16);
      aie::store_v(v4+32*v15+v16,v17);
      aie::vector<float,8> v18 = aie::load_v<8>(v4+32*v15+v16);
      for (size_t v19 = v14; v19 < v13; v19 += v11)
      chess_prepare_for_pipelining
      chess_loop_range(4, 4)
      {
        aie::vector<float,8> v20 = aie::load_v<8>(v1+32*v15+v19);
        aie::vector<float,8> v21 = aie::load_v<8>(v2+32*v19+v16);
        aie::vector<float,16> v22 = concat(v21, v21);
        v18 = fpmac(v18, v22, 0, 0x76543210, v20, 0, 0x00000000);
        size_t v23 = v19 + v12;
        aie::vector<float,8> v24 = aie::load_v<8>(v2+32*v23+v16);
        aie::vector<float,16> v25 = concat(v24, v24);
        v18 = fpmac(v18, v25, 0, 0x76543210, v20, 1, 0x00000000);
        size_t v26 = v19 + v10;
        aie::vector<float,8> v27 = aie::load_v<8>(v2+32*v26+v16);
        aie::vector<float,16> v28 = concat(v27, v27);
        v18 = fpmac(v18, v28, 0, 0x76543210, v20, 2, 0x00000000);
        size_t v29 = v19 + v9;
        aie::vector<float,8> v30 = aie::load_v<8>(v2+32*v29+v16);
        aie::vector<float,16> v31 = concat(v30, v30);
        v18 = fpmac(v18, v31, 0, 0x76543210, v20, 3, 0x00000000);
        size_t v32 = v19 + v8;
        aie::vector<float,8> v33 = aie::load_v<8>(v2+32*v32+v16);
        aie::vector<float,16> v34 = concat(v33, v33);
        v18 = fpmac(v18, v34, 0, 0x76543210, v20, 4, 0x00000000);
        size_t v35 = v19 + v7;
        aie::vector<float,8> v36 = aie::load_v<8>(v2+32*v35+v16);
        aie::vector<float,16> v37 = concat(v36, v36);
        v18 = fpmac(v18, v37, 0, 0x76543210, v20, 5, 0x00000000);
        size_t v38 = v19 + v6;
        aie::vector<float,8> v39 = aie::load_v<8>(v2+32*v38+v16);
        aie::vector<float,16> v40 = concat(v39, v39);
        v18 = fpmac(v18, v40, 0, 0x76543210, v20, 6, 0x00000000);
        size_t v41 = v19 + v5;
        aie::vector<float,8> v42 = aie::load_v<8>(v2+32*v41+v16);
        aie::vector<float,16> v43 = concat(v42, v42);
        v18 = fpmac(v18, v43, 0, 0x76543210, v20, 7, 0x00000000);
        aie::store_v(v4+32*v15+v16,v18);
      }
    }
  }
  return;
}

