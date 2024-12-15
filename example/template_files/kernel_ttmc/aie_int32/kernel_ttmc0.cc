#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <aie_api/aie.hpp>
#include <aie_api/aie_adf.hpp>
#include <aie_api/utils.hpp>
#include <adf/io_buffer/io_buffer.h>

using namespace adf;

const int I=2;
const int J=16;
const int K=16;
const int L=16;
const int M=32;
const int A_SIZE=I*L*M;
const int B_SIZE=L*J;
const int C_SIZE=M*K;
const int D_SIZE=I*J*K;
const int boundary_i=I/2;
const int boundary_j=J;
const int boundary_k=K/8;
const int boundary_l=L;
const int boundary_m=M/8-1;
const int judge_j=boundary_j-1;
const int judge_k=boundary_k-1;
const int judge_l=boundary_l-1;
const int A_jump0=L*M;
const int A_jump1=A_jump0-4;
const int A_jump2=2*A_jump0-4;
const int A_jump3=-4;
const int B_jump0=(L-1)*J;
const int B_jump1=B_jump0-8;
const int B_jump2=L*J-8;
const int B_jumpJ=-J;
const int C_jump0=(M-1)*K;
const int C_jump1=C_jump0-8;
const int C_jump2=M*K-8;
const int C_jumpK=K;
const int OUT_jump0=K*J;
const int OUT_jump1=OUT_jump0-8;
const int OUT_jump2=-8;

// Assumes all the operands are row-major
// The basic block is 2*8*8 (i, k, m)
// D(i, j, k)+ = A(i, l, m) * B(l, j) * C(m, k)
void kernel_ttmc0(input_buffer<int32_t, extents<A_SIZE>>&  in0, input_buffer<int32_t, extents<B_SIZE>>&  in1, input_buffer<int32_t, extents<C_SIZE>>&  in2, output_buffer<int32_t, extents<D_SIZE>>&  out0){
  int32_t *  A = (int32_t *)in0.data();
  int32_t *  B = (int32_t *)in1.data();
  int32_t *  C = (int32_t *)in2.data();
  int32_t *  D_OUT = (int32_t *)out0.data();

  aie::vector<int32, 16> chess_storage(xa) a_v16 = null_v16int32();
  aie::vector<int32, 16> chess_storage(xb) c_v16 = null_v16int32();
  aie::vector<int32, 16> chess_storage(xc) b_v16 = null_v16int32();
  
  aie::accum<acc80,8> chess_storage(bm0) acc0 = null_v8acc80();
	aie::accum<acc80,8> chess_storage(bm1) acc1 = null_v8acc80();
  aie::accum<acc80,8> chess_storage(bm2) acc2 = null_v8acc80();
	aie::accum<acc80,8> chess_storage(bm3) acc3 = null_v8acc80();
  
  for (unsigned int i=0;i<boundary_i;i++)
  chess_prepare_for_pipelining
	chess_loop_range(boundary_i,boundary_i)
  {
    for (unsigned int j=0; j< boundary_j; j++)
    chess_prepare_for_pipelining
		chess_loop_range(boundary_j,boundary_j)
    { 
      for (unsigned int k=0;k<boundary_k;k++)
      chess_prepare_for_pipelining
		  chess_loop_range(boundary_k,boundary_k)
      { 
        int OUT_jump = OUT_jump1;
        if(j == judge_j && k==judge_k){
          OUT_jump = OUT_jump2;
        }
        acc2 = null_v8acc80();
        acc3 = null_v8acc80();
        for (unsigned int l=0;l<boundary_l;l++)
        chess_prepare_for_pipelining
		    chess_loop_range(boundary_l,boundary_l)
        { 
          int offset = j%8;
          int A_jump = A_jump1;
          int B_jump = B_jumpJ;
          int C_jump = C_jump0;
          
          if(l == judge_l){
            if(k == judge_k){
              if(j == judge_j){
                B_jump = B_jump2;
                A_jump = A_jump3;
                C_jump = C_jump2;
              }else{
                if(offset==7){
                  B_jump = B_jump1;
                }else{
                  B_jump = B_jump0;
                }
                A_jump = A_jump2;
                C_jump = C_jump2;
              }
            }else{
              B_jump = B_jump0;
              A_jump = A_jump2;
              C_jump = C_jump1;
            }
          }
          b_v16 = b_v16.insert(0, aie::load_v<8>(B));
          B -= B_jump;
          for (unsigned int m=0;m<boundary_m;m++)
          chess_prepare_for_pipelining
		      chess_loop_range(boundary_m,boundary_m)
          { 
            //////////// Vector Preload
            a_v16 = a_v16.insert(0, aie::load_v<4>(A));
            A += A_jump0;
            c_v16 = c_v16.insert(0, aie::load_v<8>(C));
            C += C_jumpK;
            a_v16 = a_v16.insert(1, aie::load_v<4>(A));
            A -= A_jump1;

            ///////////// Calculate first 2*4*8
            // m=0
            acc0 = lmac8(acc0, c_v16, 0, 0x76543210, a_v16.extract<8>(0), 0, 0x0);  //A[0][0][0] * C[0][0-7]
            a_v16 = a_v16.insert(2, aie::load_v<4>(A));
            A += A_jump0;
            c_v16 = c_v16.insert(1, aie::load_v<8>(C));
            C += C_jumpK;
            acc1 = lmac8(acc1, c_v16, 0, 0x76543210, a_v16.extract<8>(0), 4, 0x0);  //A[1][0][0] * C[0][0-7]
            a_v16 = a_v16.insert(3, aie::load_v<4>(A));
            A -= A_jump1;

            // m=1
            acc0 = lmac8(acc0, c_v16, 8, 0x76543210, a_v16.extract<8>(0), 1, 0x0);
            c_v16 = c_v16.insert(0, aie::load_v<8>(C));
            C += C_jumpK;
            acc1 = lmac8(acc1, c_v16, 8, 0x76543210, a_v16.extract<8>(0), 5, 0x0);

            // m=2
            acc0 = lmac8(acc0, c_v16, 0, 0x76543210, a_v16.extract<8>(0), 2, 0x0);
            c_v16 = c_v16.insert(1, aie::load_v<8>(C));
            C += C_jumpK;
            acc1 = lmac8(acc1, c_v16, 0, 0x76543210, a_v16.extract<8>(0), 6, 0x0);

            // m=3
            acc0 = lmac8(acc0, c_v16, 8, 0x76543210, a_v16.extract<8>(0), 3, 0x0);
            c_v16 = c_v16.insert(0, aie::load_v<8>(C));
            C += C_jumpK;
            acc1 = lmac8(acc1, c_v16, 8, 0x76543210, a_v16.extract<8>(0), 7, 0x0);

            //////////// Calculate second 2*4*8
            // m=4
            acc0 = lmac8(acc0, c_v16, 0, 0x76543210, a_v16.extract<8>(1), 0, 0x0);
            c_v16 = c_v16.insert(1, aie::load_v<8>(C));
            C += C_jumpK;
            acc1 = lmac8(acc1, c_v16, 0, 0x76543210, a_v16.extract<8>(1), 4, 0x0);

            // m=5
            acc0 = lmac8(acc0, c_v16, 8, 0x76543210, a_v16.extract<8>(1), 1, 0x0);
            c_v16 = c_v16.insert(0, aie::load_v<8>(C));
            C += C_jumpK;
            acc1 = lmac8(acc1, c_v16, 8, 0x76543210, a_v16.extract<8>(1), 5, 0x0);

            // m=6
            acc0 = lmac8(acc0, c_v16, 0, 0x76543210, a_v16.extract<8>(1), 2, 0x0);
            c_v16 = c_v16.insert(1, aie::load_v<8>(C));
            C += C_jumpK;
            acc1 = lmac8(acc1, c_v16, 0, 0x76543210, a_v16.extract<8>(1), 6, 0x0);

            // m=7
            acc0 = lmac8(acc0, c_v16, 8, 0x76543210, a_v16.extract<8>(1), 3, 0x0);
            acc1 = lmac8(acc1, c_v16, 8, 0x76543210, a_v16.extract<8>(1), 7, 0x0);
          }
          //////////// Vector Preload
          a_v16 = a_v16.insert(0, aie::load_v<4>(A));
          A += A_jump0;
          c_v16 = c_v16.insert(0, aie::load_v<8>(C));
          C += C_jumpK;
          a_v16 = a_v16.insert(1, aie::load_v<4>(A));
          A -= A_jump1;


          ///////////// Calculate first 2*4*8
          // m=0
          acc0 = lmac8(acc0, c_v16, 0, 0x76543210, a_v16.extract<8>(0), 0, 0x0);  //A[0][0][0] * C[0][0-7]
          a_v16 = a_v16.insert(2, aie::load_v<4>(A));
          A += A_jump0;
          c_v16 = c_v16.insert(1, aie::load_v<8>(C));
          C += C_jumpK;
          acc1 = lmac8(acc1, c_v16, 0, 0x76543210, a_v16.extract<8>(0), 4, 0x0);  //A[1][0][0] * C[0][0-7]
          a_v16 = a_v16.insert(3, aie::load_v<4>(A));
          A -= A_jump;

          // m=1
          acc0 = lmac8(acc0, c_v16, 8, 0x76543210, a_v16.extract<8>(0), 1, 0x0);
          c_v16 = c_v16.insert(0, aie::load_v<8>(C));
          C += C_jumpK;
          acc1 = lmac8(acc1, c_v16, 8, 0x76543210, a_v16.extract<8>(0), 5, 0x0);

          // m=2
          acc0 = lmac8(acc0, c_v16, 0, 0x76543210, a_v16.extract<8>(0), 2, 0x0);
          c_v16 = c_v16.insert(1, aie::load_v<8>(C));
          C += C_jumpK;
          acc1 = lmac8(acc1, c_v16, 0, 0x76543210, a_v16.extract<8>(0), 6, 0x0);

          // m=3
          acc0 = lmac8(acc0, c_v16, 8, 0x76543210, a_v16.extract<8>(0), 3, 0x0);
          c_v16 = c_v16.insert(0, aie::load_v<8>(C));
          C += C_jumpK;
          acc1 = lmac8(acc1, c_v16, 8, 0x76543210, a_v16.extract<8>(0), 7, 0x0);

          //////////// Calculate second 2*4*8
          // m=4
          acc0 = lmac8(acc0, c_v16, 0, 0x76543210, a_v16.extract<8>(1), 0, 0x0);
          c_v16 = c_v16.insert(1, aie::load_v<8>(C));
          C += C_jumpK;
          acc1 = lmac8(acc1, c_v16, 0, 0x76543210, a_v16.extract<8>(1), 4, 0x0);

          // m=5
          acc0 = lmac8(acc0, c_v16, 8, 0x76543210, a_v16.extract<8>(1), 1, 0x0);
          c_v16 = c_v16.insert(0, aie::load_v<8>(C));
          C += C_jumpK;
          acc1 = lmac8(acc1, c_v16, 8, 0x76543210, a_v16.extract<8>(1), 5, 0x0);

          // m=6
          acc0 = lmac8(acc0, c_v16, 0, 0x76543210, a_v16.extract<8>(1), 2, 0x0);
          c_v16 = c_v16.insert(1, aie::load_v<8>(C));
          C -= C_jump;
          acc1 = lmac8(acc1, c_v16, 0, 0x76543210, a_v16.extract<8>(1), 6, 0x0);

          // m=7
          acc0 = lmac8(acc0, c_v16, 8, 0x76543210, a_v16.extract<8>(1), 3, 0x0);
          acc1 = lmac8(acc1, c_v16, 8, 0x76543210, a_v16.extract<8>(1), 7, 0x0);
          aie::vector<int32, 8> sub_sum0 = srs(acc0, 0);
          aie::vector<int32, 8> sub_sum1 = srs(acc1, 0);
          acc0 = null_v8acc80();
			    acc1 = null_v8acc80();
          chess_separator_scheduler();
          acc2 = lmac8(acc2, b_v16, offset, 0x0, sub_sum0, 0, 0x76543210);  //B[0][0] * subsum[i:0][m:0][k:0-7]
          acc3 = lmac8(acc3, b_v16, offset, 0x0, sub_sum1, 0, 0x76543210);  //B[0][0] * subsum[i:0][m:0][k:0-7]
        }
        chess_separator_scheduler();
        aie::vector<int32, 8> temp0 = srs(acc2, 0);
        aie::store_v(D_OUT, temp0);
        D_OUT += OUT_jump0;
        aie::vector<int32, 8> temp1 = srs(acc3, 0);
        aie::store_v(D_OUT, temp1);
        D_OUT -= OUT_jump;
      }
    }
  }
}