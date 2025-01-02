// D(i, j)+ = A(i, k, l) * B(k, j) * C(l, j)
// i = 64, j = 6144, k = 768, l = 2048
module {
  func.func @mttkrp(%A: memref<64x768x2048xi32>, %B: memref<768x6144xi32>, %C: memref<2048x6144xi32>, %D: memref<64x6144xi32>) {
    affine.for %i = 0 to 64 {
      affine.for %j = 0 to 6144 {
        affine.for %k = 0 to 768 {
          affine.for %l = 0 to 2048 {
            %0 = affine.load %A[%i, %k, %l] : memref<64x768x2048xi32>
            %1 = affine.load %B[%k, %j] : memref<768x6144xi32>
            %2 = affine.load %C[%l, %j] : memref<2048x6144xi32>
            %3 = arith.muli %0, %1 : i32
            %4 = arith.muli %3, %2 : i32
            %5 = affine.load %D[%i, %j] : memref<64x6144xi32>
            %6 = arith.addi %5, %4 : i32
            affine.store %6, %D[%i, %j] : memref<64x6144xi32>
          } {reduction}
        }{reduction}
      }
    }
    return
  }
  func.func @top(%A: memref<64x768x2048xi32>, %B: memref<768x6144xi32>, %C: memref<2048x6144xi32>, %D: memref<64x6144xi32>)attributes {top_func}{
    func.call @mttkrp(%A, %B, %C, %D) : (memref<64x768x2048xi32>, memref<768x6144xi32>, memref<2048x6144xi32>, memref<64x6144xi32>) -> ()
    return
  }
}