module {
  func.func @gemm(%A: memref<2560x65536xi8>, %B: memref<65536x4096xi8>, %C: memref<2560x4096xi8>) {
    affine.for %arg3 = 0 to 2560 {
      affine.for %arg4 = 0 to 4096 {
        affine.for %arg5 = 0 to 65536 {
          %0 = affine.load %A[%arg3, %arg5] : memref<2560x65536xi8>
          %1 = affine.load %B[%arg5, %arg4] : memref<65536x4096xi8>
          %2 = arith.muli %0, %1 : i8
          %3 = affine.load %C[%arg3, %arg4] : memref<2560x4096xi8>
          %4 = arith.addi %3, %2 : i8
          affine.store %4, %C[%arg3, %arg4] : memref<2560x4096xi8>
        } {reduction}
      }
    }
    return
  }
  func.func @top(%A: memref<2560x65536xi8>, %B: memref<65536x4096xi8>, %C: memref<2560x4096xi8>)attributes {top_func}{
    func.call @gemm(%A, %B, %C) : (memref<2560x65536xi8>, memref<65536x4096xi8>, memref<2560x4096xi8>) -> ()
    return
  }
}