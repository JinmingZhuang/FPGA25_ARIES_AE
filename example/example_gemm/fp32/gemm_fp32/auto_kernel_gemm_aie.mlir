module {
  func.func @kernel_gemm0(%arg0: memref<32x32xf32, 2>, %arg1: memref<32x32xf32, 2>) -> memref<32x32xf32, 2> attributes {adf.kernel, edge_kernel} {
    %c8 = arith.constant 8 : index
    %c7 = arith.constant 7 : index
    %c6 = arith.constant 6 : index
    %c5 = arith.constant 5 : index
    %c4 = arith.constant 4 : index
    %c3 = arith.constant 3 : index
    %c2 = arith.constant 2 : index
    %c1 = arith.constant 1 : index
    %c32 = arith.constant 32 : index
    %c0 = arith.constant 0 : index
    %cst = arith.constant dense<0.000000e+00> : vector<8xf32>
    %alloc = memref.alloc() : memref<32x32xf32, 2>
    scf.for %arg2 = %c0 to %c32 step %c1 {
      vector.transfer_write %cst, %alloc[%arg2, %c0] {in_bounds = [true]} : vector<8xf32>, memref<32x32xf32, 2>
      vector.transfer_write %cst, %alloc[%arg2, %c1] {in_bounds = [true]} : vector<8xf32>, memref<32x32xf32, 2>
      vector.transfer_write %cst, %alloc[%arg2, %c2] {in_bounds = [true]} : vector<8xf32>, memref<32x32xf32, 2>
      vector.transfer_write %cst, %alloc[%arg2, %c3] {in_bounds = [true]} : vector<8xf32>, memref<32x32xf32, 2>
      vector.transfer_write %cst, %alloc[%arg2, %c4] {in_bounds = [true]} : vector<8xf32>, memref<32x32xf32, 2>
      vector.transfer_write %cst, %alloc[%arg2, %c5] {in_bounds = [true]} : vector<8xf32>, memref<32x32xf32, 2>
      vector.transfer_write %cst, %alloc[%arg2, %c6] {in_bounds = [true]} : vector<8xf32>, memref<32x32xf32, 2>
      vector.transfer_write %cst, %alloc[%arg2, %c7] {in_bounds = [true]} : vector<8xf32>, memref<32x32xf32, 2>
    }
    scf.for %arg2 = %c0 to %c32 step %c1 {
      scf.for %arg3 = %c0 to %c32 step %c8 {
        %0 = aievec.upd %alloc[%arg2, %arg3] {index = 0 : i8, offset = 0 : i32} : memref<32x32xf32, 2>, vector<8xf32>
        scf.for %arg4 = %c0 to %c32 step %c8 {
          %1 = aievec.upd %arg0[%arg2, %arg4] {index = 0 : i8, offset = 0 : i32} : memref<32x32xf32, 2>, vector<8xf32>
          %2 = aievec.upd %arg1[%arg4, %arg3] {index = 0 : i8, offset = 0 : i32} : memref<32x32xf32, 2>, vector<8xf32>
          %3 = aievec.concat %2, %2 : vector<8xf32>, vector<16xf32>
          %4 = aievec.mac %3, %1, %0 {xoffsets = "0x76543210", xstart = "0", zoffsets = "0x00000000", zstart = "0"} : vector<16xf32>, vector<8xf32>, vector<8xf32>
          %5 = arith.addi %arg4, %c1 : index
          %6 = aievec.upd %arg1[%5, %arg3] {index = 0 : i8, offset = 0 : i32} : memref<32x32xf32, 2>, vector<8xf32>
          %7 = aievec.concat %6, %6 : vector<8xf32>, vector<16xf32>
          %8 = aievec.mac %7, %1, %4 {xoffsets = "0x76543210", xstart = "0", zoffsets = "0x00000000", zstart = "1"} : vector<16xf32>, vector<8xf32>, vector<8xf32>
          %9 = arith.addi %arg4, %c2 : index
          %10 = aievec.upd %arg1[%9, %arg3] {index = 0 : i8, offset = 0 : i32} : memref<32x32xf32, 2>, vector<8xf32>
          %11 = aievec.concat %10, %10 : vector<8xf32>, vector<16xf32>
          %12 = aievec.mac %11, %1, %8 {xoffsets = "0x76543210", xstart = "0", zoffsets = "0x00000000", zstart = "2"} : vector<16xf32>, vector<8xf32>, vector<8xf32>
          %13 = arith.addi %arg4, %c3 : index
          %14 = aievec.upd %arg1[%13, %arg3] {index = 0 : i8, offset = 0 : i32} : memref<32x32xf32, 2>, vector<8xf32>
          %15 = aievec.concat %14, %14 : vector<8xf32>, vector<16xf32>
          %16 = aievec.mac %15, %1, %12 {xoffsets = "0x76543210", xstart = "0", zoffsets = "0x00000000", zstart = "3"} : vector<16xf32>, vector<8xf32>, vector<8xf32>
          %17 = arith.addi %arg4, %c4 : index
          %18 = aievec.upd %arg1[%17, %arg3] {index = 0 : i8, offset = 0 : i32} : memref<32x32xf32, 2>, vector<8xf32>
          %19 = aievec.concat %18, %18 : vector<8xf32>, vector<16xf32>
          %20 = aievec.mac %19, %1, %16 {xoffsets = "0x76543210", xstart = "0", zoffsets = "0x00000000", zstart = "4"} : vector<16xf32>, vector<8xf32>, vector<8xf32>
          %21 = arith.addi %arg4, %c5 : index
          %22 = aievec.upd %arg1[%21, %arg3] {index = 0 : i8, offset = 0 : i32} : memref<32x32xf32, 2>, vector<8xf32>
          %23 = aievec.concat %22, %22 : vector<8xf32>, vector<16xf32>
          %24 = aievec.mac %23, %1, %20 {xoffsets = "0x76543210", xstart = "0", zoffsets = "0x00000000", zstart = "5"} : vector<16xf32>, vector<8xf32>, vector<8xf32>
          %25 = arith.addi %arg4, %c6 : index
          %26 = aievec.upd %arg1[%25, %arg3] {index = 0 : i8, offset = 0 : i32} : memref<32x32xf32, 2>, vector<8xf32>
          %27 = aievec.concat %26, %26 : vector<8xf32>, vector<16xf32>
          %28 = aievec.mac %27, %1, %24 {xoffsets = "0x76543210", xstart = "0", zoffsets = "0x00000000", zstart = "6"} : vector<16xf32>, vector<8xf32>, vector<8xf32>
          %29 = arith.addi %arg4, %c7 : index
          %30 = aievec.upd %arg1[%29, %arg3] {index = 0 : i8, offset = 0 : i32} : memref<32x32xf32, 2>, vector<8xf32>
          %31 = aievec.concat %30, %30 : vector<8xf32>, vector<16xf32>
          %32 = aievec.mac %31, %1, %28 {xoffsets = "0x76543210", xstart = "0", zoffsets = "0x00000000", zstart = "7"} : vector<16xf32>, vector<8xf32>, vector<8xf32>
          vector.transfer_write %32, %alloc[%arg2, %arg3] {in_bounds = [true]} : vector<8xf32>, memref<32x32xf32, 2>
        }
      }
    }
    return %alloc : memref<32x32xf32, 2>
  }
  func.func @kernel_gemm(%arg0: memref<32x32xf32, 2>, %arg1: memref<32x32xf32, 2>, %arg2: memref<32x32xf32, 2>) -> memref<32x32xf32, 2> attributes {adf.kernel} {
    %c7 = arith.constant 7 : index
    %c6 = arith.constant 6 : index
    %c5 = arith.constant 5 : index
    %c4 = arith.constant 4 : index
    %c3 = arith.constant 3 : index
    %c2 = arith.constant 2 : index
    %c8 = arith.constant 8 : index
    %c1 = arith.constant 1 : index
    %c32 = arith.constant 32 : index
    %c0 = arith.constant 0 : index
    %alloc = memref.alloc() : memref<32x32xf32, 2>
    scf.for %arg3 = %c0 to %c32 step %c1 {
      scf.for %arg4 = %c0 to %c32 step %c8 {
        %0 = aievec.upd %arg2[%arg3, %arg4] {index = 0 : i8, offset = 0 : i32} : memref<32x32xf32, 2>, vector<8xf32>
        vector.transfer_write %0, %alloc[%arg3, %arg4] {in_bounds = [true]} : vector<8xf32>, memref<32x32xf32, 2>
        %1 = aievec.upd %alloc[%arg3, %arg4] {index = 0 : i8, offset = 0 : i32} : memref<32x32xf32, 2>, vector<8xf32>
        scf.for %arg5 = %c0 to %c32 step %c8 {
          %2 = aievec.upd %arg0[%arg3, %arg5] {index = 0 : i8, offset = 0 : i32} : memref<32x32xf32, 2>, vector<8xf32>
          %3 = aievec.upd %arg1[%arg5, %arg4] {index = 0 : i8, offset = 0 : i32} : memref<32x32xf32, 2>, vector<8xf32>
          %4 = aievec.concat %3, %3 : vector<8xf32>, vector<16xf32>
          %5 = aievec.mac %4, %2, %1 {xoffsets = "0x76543210", xstart = "0", zoffsets = "0x00000000", zstart = "0"} : vector<16xf32>, vector<8xf32>, vector<8xf32>
          %6 = arith.addi %arg5, %c1 : index
          %7 = aievec.upd %arg1[%6, %arg4] {index = 0 : i8, offset = 0 : i32} : memref<32x32xf32, 2>, vector<8xf32>
          %8 = aievec.concat %7, %7 : vector<8xf32>, vector<16xf32>
          %9 = aievec.mac %8, %2, %5 {xoffsets = "0x76543210", xstart = "0", zoffsets = "0x00000000", zstart = "1"} : vector<16xf32>, vector<8xf32>, vector<8xf32>
          %10 = arith.addi %arg5, %c2 : index
          %11 = aievec.upd %arg1[%10, %arg4] {index = 0 : i8, offset = 0 : i32} : memref<32x32xf32, 2>, vector<8xf32>
          %12 = aievec.concat %11, %11 : vector<8xf32>, vector<16xf32>
          %13 = aievec.mac %12, %2, %9 {xoffsets = "0x76543210", xstart = "0", zoffsets = "0x00000000", zstart = "2"} : vector<16xf32>, vector<8xf32>, vector<8xf32>
          %14 = arith.addi %arg5, %c3 : index
          %15 = aievec.upd %arg1[%14, %arg4] {index = 0 : i8, offset = 0 : i32} : memref<32x32xf32, 2>, vector<8xf32>
          %16 = aievec.concat %15, %15 : vector<8xf32>, vector<16xf32>
          %17 = aievec.mac %16, %2, %13 {xoffsets = "0x76543210", xstart = "0", zoffsets = "0x00000000", zstart = "3"} : vector<16xf32>, vector<8xf32>, vector<8xf32>
          %18 = arith.addi %arg5, %c4 : index
          %19 = aievec.upd %arg1[%18, %arg4] {index = 0 : i8, offset = 0 : i32} : memref<32x32xf32, 2>, vector<8xf32>
          %20 = aievec.concat %19, %19 : vector<8xf32>, vector<16xf32>
          %21 = aievec.mac %20, %2, %17 {xoffsets = "0x76543210", xstart = "0", zoffsets = "0x00000000", zstart = "4"} : vector<16xf32>, vector<8xf32>, vector<8xf32>
          %22 = arith.addi %arg5, %c5 : index
          %23 = aievec.upd %arg1[%22, %arg4] {index = 0 : i8, offset = 0 : i32} : memref<32x32xf32, 2>, vector<8xf32>
          %24 = aievec.concat %23, %23 : vector<8xf32>, vector<16xf32>
          %25 = aievec.mac %24, %2, %21 {xoffsets = "0x76543210", xstart = "0", zoffsets = "0x00000000", zstart = "5"} : vector<16xf32>, vector<8xf32>, vector<8xf32>
          %26 = arith.addi %arg5, %c6 : index
          %27 = aievec.upd %arg1[%26, %arg4] {index = 0 : i8, offset = 0 : i32} : memref<32x32xf32, 2>, vector<8xf32>
          %28 = aievec.concat %27, %27 : vector<8xf32>, vector<16xf32>
          %29 = aievec.mac %28, %2, %25 {xoffsets = "0x76543210", xstart = "0", zoffsets = "0x00000000", zstart = "6"} : vector<16xf32>, vector<8xf32>, vector<8xf32>
          %30 = arith.addi %arg5, %c7 : index
          %31 = aievec.upd %arg1[%30, %arg4] {index = 0 : i8, offset = 0 : i32} : memref<32x32xf32, 2>, vector<8xf32>
          %32 = aievec.concat %31, %31 : vector<8xf32>, vector<16xf32>
          %33 = aievec.mac %32, %2, %29 {xoffsets = "0x76543210", xstart = "0", zoffsets = "0x00000000", zstart = "7"} : vector<16xf32>, vector<8xf32>, vector<8xf32>
          vector.transfer_write %33, %alloc[%arg3, %arg4] {in_bounds = [true]} : vector<8xf32>, memref<32x32xf32, 2>
        }
      }
    }
    return %alloc : memref<32x32xf32, 2>
  }
}

