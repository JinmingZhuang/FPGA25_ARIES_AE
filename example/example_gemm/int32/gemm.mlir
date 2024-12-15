module {
  func.func @gemm(%A: memref<2816x8192xi32>, %B: memref<8192x3072xi32>, %C: memref<2816x3072xi32>) {
    affine.for %arg3 = 0 to 2816 {
      affine.for %arg4 = 0 to 3072 {
        affine.for %arg5 = 0 to 8192 {
          %0 = affine.load %A[%arg3, %arg5] : memref<2816x8192xi32>
          %1 = affine.load %B[%arg5, %arg4] : memref<8192x3072xi32>
          %2 = arith.muli %0, %1 : i32
          %3 = affine.load %C[%arg3, %arg4] : memref<2816x3072xi32>
          %4 = arith.addi %3, %2 : i32
          affine.store %4, %C[%arg3, %arg4] : memref<2816x3072xi32>
        } {reduction}
      }
    }
    return
  }
  func.func @top(%A: memref<2816x8192xi32>, %B: memref<8192x3072xi32>, %C: memref<2816x3072xi32>)attributes {top_func}{
    func.call @gemm(%A, %B, %C) : (memref<2816x8192xi32>, memref<8192x3072xi32>, memref<2816x3072xi32>) -> ()
    return
  }
}