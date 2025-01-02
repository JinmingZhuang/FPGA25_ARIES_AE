// C(i, j, k)+ = A(i, j, l) * B(l, k)
module {
  func.func @ttm(%A: memref<4x1408x8192xi32>, %B: memref<8192x1536xi32>, %C: memref<4x1408x1536xi32>) {
    affine.for %i = 0 to 4 {
      affine.for %j = 0 to 1408 {
        affine.for %k = 0 to 1536 {
          affine.for %l = 0 to 8192 {
            %0 = affine.load %A[%i, %j, %l] : memref<4x1408x8192xi32>
            %1 = affine.load %B[%l, %k] : memref<8192x1536xi32>
            %2 = arith.muli %0, %1 : i32
            %3 = affine.load %C[%i, %j, %k] : memref<4x1408x1536xi32>
            %4 = arith.addi %3, %2 : i32
            affine.store %4, %C[%i, %j, %k] : memref<4x1408x1536xi32>
          } {reduction}
        }
      }
    }
    return
  }
  func.func @top(%A: memref<4x1408x8192xi32>, %B: memref<8192x1536xi32>, %C: memref<4x1408x1536xi32>)attributes {top_func}{
    func.call @ttm(%A, %B, %C) : (memref<4x1408x8192xi32>, memref<8192x1536xi32>, memref<4x1408x1536xi32>) -> ()
    return
  }
}