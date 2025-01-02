module {
  func.func @gemm(%A: memref<2816x8192xf32>, %B: memref<8192x3072xf32>, %C: memref<2816x3072xf32>) {
    affine.for %arg3 = 0 to 2816 {
      affine.for %arg4 = 0 to 3072 {
        affine.for %arg5 = 0 to 8192 {
          %0 = affine.load %A[%arg3, %arg5] : memref<2816x8192xf32>
          %1 = affine.load %B[%arg5, %arg4] : memref<8192x3072xf32>
          %2 = arith.mulf %0, %1 : f32
          %3 = affine.load %C[%arg3, %arg4] : memref<2816x3072xf32>
          %4 = arith.addf %3, %2 : f32
          affine.store %4, %C[%arg3, %arg4] : memref<2816x3072xf32>
        } {reduction}
      }
    }
    return
  }
  func.func @top(%A: memref<2816x8192xf32>, %B: memref<8192x3072xf32>, %C: memref<2816x3072xf32>)attributes {top_func}{
    func.call @gemm(%A, %B, %C) : (memref<2816x8192xf32>, memref<8192x3072xf32>, memref<2816x3072xf32>) -> ()
    return
  }
}