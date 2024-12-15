module {
  func.func @gemm(%A: memref<2816x32768xi16>, %B: memref<32768x4096xi16>, %C: memref<2816x4096xi16>) {
    affine.for %arg3 = 0 to 2816 {
      affine.for %arg4 = 0 to 4096 {
        affine.for %arg5 = 0 to 32768 {
          %0 = affine.load %A[%arg3, %arg5] : memref<2816x32768xi16>
          %1 = affine.load %B[%arg5, %arg4] : memref<32768x4096xi16>
          %2 = arith.muli %0, %1 : i16
          %3 = affine.load %C[%arg3, %arg4] : memref<2816x4096xi16>
          %4 = arith.addi %3, %2 : i16
          affine.store %4, %C[%arg3, %arg4] : memref<2816x4096xi16>
        } {reduction}
      }
    }
    return
  }
  func.func @top(%A: memref<2816x32768xi16>, %B: memref<32768x4096xi16>, %C: memref<2816x4096xi16>)attributes {top_func}{
    func.call @gemm(%A, %B, %C) : (memref<2816x32768xi16>, memref<32768x4096xi16>, memref<2816x4096xi16>) -> ()
    return
  }
}