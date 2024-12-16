#map = affine_map<(d0) -> (d0 * 128 + 127)>
#map1 = affine_map<(d0) -> (d0 * 128)>
module {
  func.func @kernel_gemm0(%arg0: memref<32x64xi8, 2>, %arg1: memref<64x64xi8, 2>) -> memref<32x64xi8, 2> attributes {adf.kernel, edge_kernel} {
    %c0_i8 = arith.constant 0 : i8
    %alloc = memref.alloc() : memref<32x64xi8, 2>
    affine.for %arg2 = 0 to 32 {
      affine.for %arg3 = 0 to 64 {
        affine.store %c0_i8, %alloc[%arg2, %arg3] : memref<32x64xi8, 2>
      }
    }
    affine.for %arg2 = 0 to 32 {
      affine.for %arg3 = 0 to 64 {
        affine.for %arg4 = 0 to 64 {
          %0 = affine.load %arg0[%arg2, %arg4] : memref<32x64xi8, 2>
          %1 = affine.load %arg1[%arg4, %arg3] : memref<64x64xi8, 2>
          %2 = arith.muli %0, %1 : i8
          %3 = affine.load %alloc[%arg2, %arg3] : memref<32x64xi8, 2>
          %4 = arith.addi %3, %2 : i8
          affine.store %4, %alloc[%arg2, %arg3] : memref<32x64xi8, 2>
        }
      }
    }
    return %alloc : memref<32x64xi8, 2>
  }
  func.func @kernel_gemm(%arg0: memref<32x64xi8, 2>, %arg1: memref<64x64xi8, 2>, %arg2: memref<32x64xi8, 2>) -> memref<32x64xi8, 2> attributes {adf.kernel} {
    %alloc = memref.alloc() : memref<32x64xi8, 2>
    affine.for %arg3 = 0 to 32 {
      affine.for %arg4 = 0 to 64 {
        %0 = affine.load %arg2[%arg3, %arg4] : memref<32x64xi8, 2>
        affine.store %0, %alloc[%arg3, %arg4] : memref<32x64xi8, 2>
        affine.for %arg5 = 0 to 64 {
          %1 = affine.load %arg0[%arg3, %arg5] : memref<32x64xi8, 2>
          %2 = affine.load %arg1[%arg5, %arg4] : memref<64x64xi8, 2>
          %3 = arith.muli %1, %2 : i8
          %4 = affine.load %alloc[%arg3, %arg4] : memref<32x64xi8, 2>
          %5 = arith.addi %4, %3 : i8
          affine.store %5, %alloc[%arg3, %arg4] : memref<32x64xi8, 2>
        }
      }
    }
    return %alloc : memref<32x64xi8, 2>
  }
  func.func @adf_cell0(%arg0: !adf.plio<In, 128>, %arg1: !adf.plio<In, 128>, %arg2: !adf.plio<In, 128>, %arg3: !adf.plio<In, 128>, %arg4: !adf.plio<In, 128>, %arg5: !adf.plio<In, 128>, %arg6: !adf.plio<In, 128>, %arg7: !adf.plio<In, 128>, %arg8: !adf.plio<Out, 128>, %arg9: !adf.plio<In, 128>, %arg10: !adf.plio<In, 128>, %arg11: !adf.plio<In, 128>, %arg12: !adf.plio<In, 128>, %arg13: !adf.plio<Out, 128>, %arg14: !adf.plio<In, 128>, %arg15: !adf.plio<In, 128>, %arg16: !adf.plio<In, 128>, %arg17: !adf.plio<In, 128>, %arg18: !adf.plio<Out, 128>, %arg19: !adf.plio<In, 128>, %arg20: !adf.plio<In, 128>, %arg21: !adf.plio<In, 128>, %arg22: !adf.plio<In, 128>, %arg23: !adf.plio<Out, 128>, %arg24: !adf.plio<In, 128>, %arg25: !adf.plio<In, 128>, %arg26: !adf.plio<In, 128>, %arg27: !adf.plio<In, 128>, %arg28: !adf.plio<Out, 128>, %arg29: !adf.plio<In, 128>, %arg30: !adf.plio<In, 128>, %arg31: !adf.plio<In, 128>, %arg32: !adf.plio<In, 128>, %arg33: !adf.plio<Out, 128>, %arg34: !adf.plio<In, 128>, %arg35: !adf.plio<In, 128>, %arg36: !adf.plio<In, 128>, %arg37: !adf.plio<In, 128>, %arg38: !adf.plio<Out, 128>, %arg39: !adf.plio<In, 128>, %arg40: !adf.plio<In, 128>, %arg41: !adf.plio<In, 128>, %arg42: !adf.plio<In, 128>, %arg43: !adf.plio<Out, 128>, %arg44: !adf.plio<In, 128>, %arg45: !adf.plio<In, 128>, %arg46: !adf.plio<In, 128>, %arg47: !adf.plio<In, 128>, %arg48: !adf.plio<Out, 128>, %arg49: !adf.plio<Out, 128>, %arg50: !adf.plio<Out, 128>, %arg51: !adf.plio<Out, 128>, %arg52: !adf.plio<Out, 128>, %arg53: !adf.plio<Out, 128>, %arg54: !adf.plio<Out, 128>, %arg55: !adf.plio<Out, 128>, %arg56: !adf.plio<In, 128>, %arg57: !adf.plio<In, 128>, %arg58: !adf.plio<In, 128>, %arg59: !adf.plio<In, 128>, %arg60: !adf.plio<Out, 128>, %arg61: !adf.plio<Out, 128>, %arg62: !adf.plio<Out, 128>, %arg63: !adf.plio<Out, 128>, %arg64: !adf.plio<Out, 128>, %arg65: !adf.plio<Out, 128>, %arg66: !adf.plio<Out, 128>, %arg67: !adf.plio<Out, 128>, %arg68: !adf.plio<In, 128>, %arg69: !adf.plio<In, 128>, %arg70: !adf.plio<In, 128>, %arg71: !adf.plio<In, 128>, %arg72: !adf.plio<Out, 128>, %arg73: !adf.plio<Out, 128>, %arg74: !adf.plio<Out, 128>, %arg75: !adf.plio<Out, 128>, %arg76: !adf.plio<Out, 128>, %arg77: !adf.plio<Out, 128>, %arg78: !adf.plio<Out, 128>, %arg79: !adf.plio<Out, 128>, %arg80: !adf.plio<In, 128>, %arg81: !adf.plio<In, 128>, %arg82: !adf.plio<In, 128>, %arg83: !adf.plio<In, 128>, %arg84: !adf.plio<Out, 128>, %arg85: !adf.plio<Out, 128>, %arg86: !adf.plio<Out, 128>, %arg87: !adf.plio<Out, 128>, %arg88: !adf.plio<Out, 128>, %arg89: !adf.plio<Out, 128>, %arg90: !adf.plio<Out, 128>, %arg91: !adf.plio<Out, 128>, %arg92: !adf.plio<In, 128>, %arg93: !adf.plio<In, 128>, %arg94: !adf.plio<In, 128>, %arg95: !adf.plio<In, 128>, %arg96: !adf.plio<Out, 128>, %arg97: !adf.plio<Out, 128>, %arg98: !adf.plio<Out, 128>, %arg99: !adf.plio<Out, 128>, %arg100: !adf.plio<Out, 128>, %arg101: !adf.plio<Out, 128>, %arg102: !adf.plio<Out, 128>, %arg103: !adf.plio<Out, 128>, %arg104: !adf.plio<In, 128>, %arg105: !adf.plio<In, 128>, %arg106: !adf.plio<In, 128>, %arg107: !adf.plio<In, 128>, %arg108: !adf.plio<Out, 128>, %arg109: !adf.plio<Out, 128>, %arg110: !adf.plio<Out, 128>, %arg111: !adf.plio<Out, 128>, %arg112: !adf.plio<Out, 128>, %arg113: !adf.plio<Out, 128>, %arg114: !adf.plio<Out, 128>, %arg115: !adf.plio<Out, 128>, %arg116: !adf.plio<In, 128>, %arg117: !adf.plio<In, 128>, %arg118: !adf.plio<In, 128>, %arg119: !adf.plio<In, 128>, %arg120: !adf.plio<Out, 128>, %arg121: !adf.plio<Out, 128>, %arg122: !adf.plio<Out, 128>, %arg123: !adf.plio<Out, 128>, %arg124: !adf.plio<Out, 128>, %arg125: !adf.plio<Out, 128>, %arg126: !adf.plio<Out, 128>, %arg127: !adf.plio<Out, 128>, %arg128: !adf.plio<In, 128>, %arg129: !adf.plio<In, 128>, %arg130: !adf.plio<In, 128>, %arg131: !adf.plio<In, 128>, %arg132: !adf.plio<Out, 128>, %arg133: !adf.plio<Out, 128>, %arg134: !adf.plio<Out, 128>, %arg135: !adf.plio<Out, 128>, %arg136: !adf.plio<Out, 128>, %arg137: !adf.plio<Out, 128>, %arg138: !adf.plio<Out, 128>, %arg139: !adf.plio<Out, 128>, %arg140: !adf.plio<In, 128>, %arg141: !adf.plio<In, 128>, %arg142: !adf.plio<In, 128>, %arg143: !adf.plio<In, 128>, %arg144: !adf.plio<Out, 128>, %arg145: !adf.plio<Out, 128>, %arg146: !adf.plio<Out, 128>, %arg147: !adf.plio<Out, 128>, %arg148: !adf.plio<Out, 128>, %arg149: !adf.plio<Out, 128>, %arg150: !adf.plio<Out, 128>, %arg151: !adf.plio<Out, 128>) attributes {adf.cell, tripCount = [4 : index, 8 : index, 10 : index]} {
    %c45 = arith.constant 45 : index
    %c44 = arith.constant 44 : index
    %c43 = arith.constant 43 : index
    %c42 = arith.constant 42 : index
    %c41 = arith.constant 41 : index
    %c40 = arith.constant 40 : index
    %c39 = arith.constant 39 : index
    %c38 = arith.constant 38 : index
    %c37 = arith.constant 37 : index
    %c36 = arith.constant 36 : index
    %c35 = arith.constant 35 : index
    %c34 = arith.constant 34 : index
    %c33 = arith.constant 33 : index
    %c32 = arith.constant 32 : index
    %c31 = arith.constant 31 : index
    %c30 = arith.constant 30 : index
    %c29 = arith.constant 29 : index
    %c28 = arith.constant 28 : index
    %c27 = arith.constant 27 : index
    %c26 = arith.constant 26 : index
    %c25 = arith.constant 25 : index
    %c24 = arith.constant 24 : index
    %c23 = arith.constant 23 : index
    %c22 = arith.constant 22 : index
    %c21 = arith.constant 21 : index
    %c20 = arith.constant 20 : index
    %c19 = arith.constant 19 : index
    %c18 = arith.constant 18 : index
    %c17 = arith.constant 17 : index
    %c16 = arith.constant 16 : index
    %c15 = arith.constant 15 : index
    %c14 = arith.constant 14 : index
    %c13 = arith.constant 13 : index
    %c12 = arith.constant 12 : index
    %c11 = arith.constant 11 : index
    %c10 = arith.constant 10 : index
    %c3 = arith.constant 3 : index
    %c9 = arith.constant 9 : index
    %c2 = arith.constant 2 : index
    %c12288 = arith.constant 12288 : index
    %c4096 = arith.constant 4096 : index
    %c8 = arith.constant 8 : index
    %c7 = arith.constant 7 : index
    %c24576 = arith.constant 24576 : index
    %c16384 = arith.constant 16384 : index
    %c6 = arith.constant 6 : index
    %c4 = arith.constant 4 : index
    %c8192 = arith.constant 8192 : index
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c5 = arith.constant 5 : index
    adf.config.plio(%arg8, 250) {"col, chl" = [8 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg13, 250) {"col, chl" = [8 : index, 2 : index]} : <Out, 128>
    adf.config.plio(%arg18, 250) {"col, chl" = [8 : index, 0 : index]} : <Out, 128>
    adf.config.plio(%arg23, 250) {"col, chl" = [7 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg28, 250) {"col, chl" = [7 : index, 2 : index]} : <Out, 128>
    adf.config.plio(%arg33, 250) {"col, chl" = [7 : index, 0 : index]} : <Out, 128>
    adf.config.plio(%arg38, 250) {"col, chl" = [9 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg0, 250) {"col, chl" = [6 : index, 4 : index]} : <In, 128>
    adf.config.plio(%arg2, 250) {"col, chl" = [6 : index, 2 : index]} : <In, 128>
    adf.config.plio(%arg4, 250) {"col, chl" = [7 : index, 4 : index]} : <In, 128>
    adf.config.plio(%arg6, 250) {"col, chl" = [8 : index, 4 : index]} : <In, 128>
    adf.config.plio(%arg43, 250) {"col, chl" = [9 : index, 2 : index]} : <Out, 128>
    adf.config.plio(%arg48, 250) {"col, chl" = [12 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg49, 250) {"col, chl" = [12 : index, 2 : index]} : <Out, 128>
    adf.config.plio(%arg50, 250) {"col, chl" = [12 : index, 0 : index]} : <Out, 128>
    adf.config.plio(%arg51, 250) {"col, chl" = [11 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg52, 250) {"col, chl" = [11 : index, 2 : index]} : <Out, 128>
    adf.config.plio(%arg53, 250) {"col, chl" = [11 : index, 0 : index]} : <Out, 128>
    adf.config.plio(%arg54, 250) {"col, chl" = [13 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg44, 250) {"col, chl" = [9 : index, 4 : index]} : <In, 128>
    adf.config.plio(%arg45, 250) {"col, chl" = [10 : index, 4 : index]} : <In, 128>
    adf.config.plio(%arg46, 250) {"col, chl" = [11 : index, 4 : index]} : <In, 128>
    adf.config.plio(%arg47, 250) {"col, chl" = [12 : index, 4 : index]} : <In, 128>
    adf.config.plio(%arg55, 250) {"col, chl" = [13 : index, 2 : index]} : <Out, 128>
    adf.config.plio(%arg60, 250) {"col, chl" = [16 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg61, 250) {"col, chl" = [16 : index, 2 : index]} : <Out, 128>
    adf.config.plio(%arg62, 250) {"col, chl" = [16 : index, 0 : index]} : <Out, 128>
    adf.config.plio(%arg63, 250) {"col, chl" = [15 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg64, 250) {"col, chl" = [15 : index, 2 : index]} : <Out, 128>
    adf.config.plio(%arg65, 250) {"col, chl" = [15 : index, 0 : index]} : <Out, 128>
    adf.config.plio(%arg66, 250) {"col, chl" = [17 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg56, 250) {"col, chl" = [13 : index, 4 : index]} : <In, 128>
    adf.config.plio(%arg57, 250) {"col, chl" = [14 : index, 4 : index]} : <In, 128>
    adf.config.plio(%arg58, 250) {"col, chl" = [15 : index, 4 : index]} : <In, 128>
    adf.config.plio(%arg59, 250) {"col, chl" = [16 : index, 4 : index]} : <In, 128>
    adf.config.plio(%arg67, 250) {"col, chl" = [17 : index, 2 : index]} : <Out, 128>
    adf.config.plio(%arg72, 250) {"col, chl" = [20 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg73, 250) {"col, chl" = [20 : index, 2 : index]} : <Out, 128>
    adf.config.plio(%arg74, 250) {"col, chl" = [20 : index, 0 : index]} : <Out, 128>
    adf.config.plio(%arg75, 250) {"col, chl" = [19 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg76, 250) {"col, chl" = [19 : index, 2 : index]} : <Out, 128>
    adf.config.plio(%arg77, 250) {"col, chl" = [19 : index, 0 : index]} : <Out, 128>
    adf.config.plio(%arg78, 250) {"col, chl" = [21 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg68, 250) {"col, chl" = [17 : index, 4 : index]} : <In, 128>
    adf.config.plio(%arg69, 250) {"col, chl" = [18 : index, 4 : index]} : <In, 128>
    adf.config.plio(%arg70, 250) {"col, chl" = [19 : index, 4 : index]} : <In, 128>
    adf.config.plio(%arg71, 250) {"col, chl" = [20 : index, 4 : index]} : <In, 128>
    adf.config.plio(%arg79, 250) {"col, chl" = [21 : index, 2 : index]} : <Out, 128>
    adf.config.plio(%arg84, 250) {"col, chl" = [24 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg85, 250) {"col, chl" = [24 : index, 2 : index]} : <Out, 128>
    adf.config.plio(%arg86, 250) {"col, chl" = [24 : index, 0 : index]} : <Out, 128>
    adf.config.plio(%arg87, 250) {"col, chl" = [23 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg88, 250) {"col, chl" = [23 : index, 2 : index]} : <Out, 128>
    adf.config.plio(%arg89, 250) {"col, chl" = [23 : index, 0 : index]} : <Out, 128>
    adf.config.plio(%arg90, 250) {"col, chl" = [25 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg80, 250) {"col, chl" = [21 : index, 4 : index]} : <In, 128>
    adf.config.plio(%arg81, 250) {"col, chl" = [22 : index, 4 : index]} : <In, 128>
    adf.config.plio(%arg82, 250) {"col, chl" = [23 : index, 4 : index]} : <In, 128>
    adf.config.plio(%arg83, 250) {"col, chl" = [24 : index, 4 : index]} : <In, 128>
    adf.config.plio(%arg91, 250) {"col, chl" = [25 : index, 2 : index]} : <Out, 128>
    adf.config.plio(%arg96, 250) {"col, chl" = [28 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg97, 250) {"col, chl" = [28 : index, 2 : index]} : <Out, 128>
    adf.config.plio(%arg98, 250) {"col, chl" = [28 : index, 0 : index]} : <Out, 128>
    adf.config.plio(%arg99, 250) {"col, chl" = [27 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg100, 250) {"col, chl" = [27 : index, 2 : index]} : <Out, 128>
    adf.config.plio(%arg101, 250) {"col, chl" = [27 : index, 0 : index]} : <Out, 128>
    adf.config.plio(%arg102, 250) {"col, chl" = [29 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg92, 250) {"col, chl" = [25 : index, 4 : index]} : <In, 128>
    adf.config.plio(%arg93, 250) {"col, chl" = [26 : index, 4 : index]} : <In, 128>
    adf.config.plio(%arg94, 250) {"col, chl" = [27 : index, 4 : index]} : <In, 128>
    adf.config.plio(%arg95, 250) {"col, chl" = [28 : index, 4 : index]} : <In, 128>
    adf.config.plio(%arg103, 250) {"col, chl" = [29 : index, 2 : index]} : <Out, 128>
    adf.config.plio(%arg108, 250) {"col, chl" = [32 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg109, 250) {"col, chl" = [32 : index, 2 : index]} : <Out, 128>
    adf.config.plio(%arg110, 250) {"col, chl" = [32 : index, 0 : index]} : <Out, 128>
    adf.config.plio(%arg111, 250) {"col, chl" = [31 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg112, 250) {"col, chl" = [31 : index, 2 : index]} : <Out, 128>
    adf.config.plio(%arg113, 250) {"col, chl" = [31 : index, 0 : index]} : <Out, 128>
    adf.config.plio(%arg114, 250) {"col, chl" = [33 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg104, 250) {"col, chl" = [29 : index, 4 : index]} : <In, 128>
    adf.config.plio(%arg105, 250) {"col, chl" = [30 : index, 4 : index]} : <In, 128>
    adf.config.plio(%arg106, 250) {"col, chl" = [31 : index, 4 : index]} : <In, 128>
    adf.config.plio(%arg107, 250) {"col, chl" = [32 : index, 4 : index]} : <In, 128>
    adf.config.plio(%arg115, 250) {"col, chl" = [33 : index, 2 : index]} : <Out, 128>
    adf.config.plio(%arg120, 250) {"col, chl" = [36 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg121, 250) {"col, chl" = [36 : index, 2 : index]} : <Out, 128>
    adf.config.plio(%arg122, 250) {"col, chl" = [36 : index, 0 : index]} : <Out, 128>
    adf.config.plio(%arg123, 250) {"col, chl" = [35 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg124, 250) {"col, chl" = [35 : index, 2 : index]} : <Out, 128>
    adf.config.plio(%arg125, 250) {"col, chl" = [35 : index, 0 : index]} : <Out, 128>
    adf.config.plio(%arg126, 250) {"col, chl" = [37 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg116, 250) {"col, chl" = [33 : index, 4 : index]} : <In, 128>
    adf.config.plio(%arg117, 250) {"col, chl" = [34 : index, 4 : index]} : <In, 128>
    adf.config.plio(%arg118, 250) {"col, chl" = [35 : index, 4 : index]} : <In, 128>
    adf.config.plio(%arg119, 250) {"col, chl" = [36 : index, 4 : index]} : <In, 128>
    adf.config.plio(%arg127, 250) {"col, chl" = [37 : index, 2 : index]} : <Out, 128>
    adf.config.plio(%arg132, 250) {"col, chl" = [40 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg133, 250) {"col, chl" = [40 : index, 2 : index]} : <Out, 128>
    adf.config.plio(%arg134, 250) {"col, chl" = [40 : index, 0 : index]} : <Out, 128>
    adf.config.plio(%arg135, 250) {"col, chl" = [39 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg136, 250) {"col, chl" = [39 : index, 2 : index]} : <Out, 128>
    adf.config.plio(%arg137, 250) {"col, chl" = [39 : index, 0 : index]} : <Out, 128>
    adf.config.plio(%arg138, 250) {"col, chl" = [41 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg128, 250) {"col, chl" = [37 : index, 4 : index]} : <In, 128>
    adf.config.plio(%arg129, 250) {"col, chl" = [38 : index, 4 : index]} : <In, 128>
    adf.config.plio(%arg130, 250) {"col, chl" = [39 : index, 4 : index]} : <In, 128>
    adf.config.plio(%arg131, 250) {"col, chl" = [40 : index, 4 : index]} : <In, 128>
    adf.config.plio(%arg139, 250) {"col, chl" = [41 : index, 2 : index]} : <Out, 128>
    adf.config.plio(%arg1, 250) {"col, chl" = [23 : index, 2 : index]} : <In, 128>
    adf.config.plio(%arg3, 250) {"col, chl" = [24 : index, 2 : index]} : <In, 128>
    adf.config.plio(%arg5, 250) {"col, chl" = [25 : index, 2 : index]} : <In, 128>
    adf.config.plio(%arg7, 250) {"col, chl" = [26 : index, 2 : index]} : <In, 128>
    adf.config.plio(%arg144, 250) {"col, chl" = [44 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg9, 250) {"col, chl" = [23 : index, 0 : index]} : <In, 128>
    adf.config.plio(%arg10, 250) {"col, chl" = [24 : index, 0 : index]} : <In, 128>
    adf.config.plio(%arg11, 250) {"col, chl" = [25 : index, 0 : index]} : <In, 128>
    adf.config.plio(%arg12, 250) {"col, chl" = [26 : index, 0 : index]} : <In, 128>
    adf.config.plio(%arg145, 250) {"col, chl" = [44 : index, 2 : index]} : <Out, 128>
    adf.config.plio(%arg14, 250) {"col, chl" = [22 : index, 2 : index]} : <In, 128>
    adf.config.plio(%arg15, 250) {"col, chl" = [22 : index, 0 : index]} : <In, 128>
    adf.config.plio(%arg16, 250) {"col, chl" = [27 : index, 2 : index]} : <In, 128>
    adf.config.plio(%arg17, 250) {"col, chl" = [27 : index, 0 : index]} : <In, 128>
    adf.config.plio(%arg146, 250) {"col, chl" = [44 : index, 0 : index]} : <Out, 128>
    adf.config.plio(%arg19, 250) {"col, chl" = [21 : index, 2 : index]} : <In, 128>
    adf.config.plio(%arg20, 250) {"col, chl" = [21 : index, 0 : index]} : <In, 128>
    adf.config.plio(%arg21, 250) {"col, chl" = [28 : index, 2 : index]} : <In, 128>
    adf.config.plio(%arg22, 250) {"col, chl" = [28 : index, 0 : index]} : <In, 128>
    adf.config.plio(%arg147, 250) {"col, chl" = [43 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg24, 250) {"col, chl" = [20 : index, 2 : index]} : <In, 128>
    adf.config.plio(%arg25, 250) {"col, chl" = [20 : index, 0 : index]} : <In, 128>
    adf.config.plio(%arg26, 250) {"col, chl" = [29 : index, 2 : index]} : <In, 128>
    adf.config.plio(%arg27, 250) {"col, chl" = [29 : index, 0 : index]} : <In, 128>
    adf.config.plio(%arg148, 250) {"col, chl" = [43 : index, 2 : index]} : <Out, 128>
    adf.config.plio(%arg29, 250) {"col, chl" = [19 : index, 2 : index]} : <In, 128>
    adf.config.plio(%arg30, 250) {"col, chl" = [19 : index, 0 : index]} : <In, 128>
    adf.config.plio(%arg31, 250) {"col, chl" = [30 : index, 2 : index]} : <In, 128>
    adf.config.plio(%arg32, 250) {"col, chl" = [30 : index, 0 : index]} : <In, 128>
    adf.config.plio(%arg149, 250) {"col, chl" = [43 : index, 0 : index]} : <Out, 128>
    adf.config.plio(%arg34, 250) {"col, chl" = [18 : index, 2 : index]} : <In, 128>
    adf.config.plio(%arg35, 250) {"col, chl" = [18 : index, 0 : index]} : <In, 128>
    adf.config.plio(%arg36, 250) {"col, chl" = [31 : index, 2 : index]} : <In, 128>
    adf.config.plio(%arg37, 250) {"col, chl" = [31 : index, 0 : index]} : <In, 128>
    adf.config.plio(%arg150, 250) {"col, chl" = [42 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg140, 250) {"col, chl" = [41 : index, 4 : index]} : <In, 128>
    adf.config.plio(%arg39, 250) {"col, chl" = [17 : index, 2 : index]} : <In, 128>
    adf.config.plio(%arg141, 250) {"col, chl" = [42 : index, 4 : index]} : <In, 128>
    adf.config.plio(%arg40, 250) {"col, chl" = [17 : index, 0 : index]} : <In, 128>
    adf.config.plio(%arg142, 250) {"col, chl" = [43 : index, 4 : index]} : <In, 128>
    adf.config.plio(%arg41, 250) {"col, chl" = [32 : index, 2 : index]} : <In, 128>
    adf.config.plio(%arg143, 250) {"col, chl" = [44 : index, 4 : index]} : <In, 128>
    adf.config.plio(%arg42, 250) {"col, chl" = [32 : index, 0 : index]} : <In, 128>
    adf.config.plio(%arg151, 250) {"col, chl" = [42 : index, 2 : index]} : <Out, 128>
    %0 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg0, %0) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %1 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg1, %1) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %2 = call @kernel_gemm0(%0, %1) {adf.kernel, "col, row" = [5 : index, 0 : index], ivs = [0 : index, 0 : index, 0 : index], kernel = 0 : index, kernel_gemm0 = 0 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%2, %c5, %c0, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%0, %c4, %c0, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1, %c5, %c1, %c0, %c8192) : (memref<64x64xi8, 2>, index, index, index, index)
    %3 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg2, %3) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %4 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg3, %4) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %5 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%2, %5) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %6 = call @kernel_gemm(%3, %4, %5) {adf.kernel, "col, row" = [6 : index, 0 : index], ivs = [1 : index, 0 : index, 0 : index], kernel_gemm = 1 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%6, %c6, %c0, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%3, %c5, %c0, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%4, %c6, %c1, %c0, %c8192) : (memref<64x64xi8, 2>, index, index, index, index)
    %7 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg4, %7) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %8 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg5, %8) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %9 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%6, %9) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %10 = call @kernel_gemm(%7, %8, %9) {adf.kernel, "col, row" = [7 : index, 0 : index], ivs = [2 : index, 0 : index, 0 : index], kernel_gemm = 2 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%10, %c7, %c0, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%7, %c6, %c0, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%8, %c7, %c1, %c0, %c8192) : (memref<64x64xi8, 2>, index, index, index, index)
    %11 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg6, %11) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %12 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg7, %12) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %13 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%10, %13) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %14 = call @kernel_gemm(%11, %12, %13) {adf.kernel, "col, row" = [8 : index, 0 : index], ivs = [3 : index, 0 : index, 0 : index], kernel_gemm = 3 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%14, %c8, %c0, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%11, %c7, %c0, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%12, %c8, %c1, %c0, %c8192) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%14, %arg8) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %15 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg0, %15) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %16 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg9, %16) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %17 = call @kernel_gemm0(%15, %16) {adf.kernel, "col, row" = [5 : index, 1 : index], ivs = [0 : index, 1 : index, 0 : index], kernel = 0 : index, kernel_gemm0 = 4 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%17, %c6, %c1, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%15, %c5, %c2, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%16, %c5, %c0, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %18 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg2, %18) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %19 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg10, %19) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %20 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%17, %20) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %21 = call @kernel_gemm(%18, %19, %20) {adf.kernel, "col, row" = [6 : index, 1 : index], ivs = [1 : index, 1 : index, 0 : index], kernel_gemm = 5 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%21, %c7, %c1, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%18, %c6, %c2, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%19, %c6, %c0, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %22 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg4, %22) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %23 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg11, %23) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %24 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%21, %24) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %25 = call @kernel_gemm(%22, %23, %24) {adf.kernel, "col, row" = [7 : index, 1 : index], ivs = [2 : index, 1 : index, 0 : index], kernel_gemm = 6 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%25, %c8, %c1, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%22, %c7, %c2, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%23, %c7, %c0, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %26 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg6, %26) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %27 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg12, %27) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %28 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%25, %28) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %29 = call @kernel_gemm(%26, %27, %28) {adf.kernel, "col, row" = [8 : index, 1 : index], ivs = [3 : index, 1 : index, 0 : index], kernel_gemm = 7 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%29, %c9, %c1, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%26, %c8, %c2, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%27, %c8, %c0, %c16384, %c24576) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%29, %arg13) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %30 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg0, %30) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %31 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg14, %31) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %32 = call @kernel_gemm0(%30, %31) {adf.kernel, "col, row" = [5 : index, 2 : index], ivs = [0 : index, 2 : index, 0 : index], kernel = 0 : index, kernel_gemm0 = 8 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%32, %c5, %c2, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%30, %c5, %c3, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%31, %c5, %c1, %c16384, %c24576) : (memref<64x64xi8, 2>, index, index, index, index)
    %33 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg2, %33) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %34 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg15, %34) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %35 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%32, %35) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %36 = call @kernel_gemm(%33, %34, %35) {adf.kernel, "col, row" = [6 : index, 2 : index], ivs = [1 : index, 2 : index, 0 : index], kernel_gemm = 9 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%36, %c6, %c2, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%33, %c6, %c3, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%34, %c6, %c1, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %37 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg4, %37) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %38 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg16, %38) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %39 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%36, %39) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %40 = call @kernel_gemm(%37, %38, %39) {adf.kernel, "col, row" = [7 : index, 2 : index], ivs = [2 : index, 2 : index, 0 : index], kernel_gemm = 10 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%40, %c7, %c2, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%37, %c7, %c3, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%38, %c7, %c1, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %41 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg6, %41) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %42 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg17, %42) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %43 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%40, %43) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %44 = call @kernel_gemm(%41, %42, %43) {adf.kernel, "col, row" = [8 : index, 2 : index], ivs = [3 : index, 2 : index, 0 : index], kernel_gemm = 11 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%44, %c8, %c2, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%41, %c8, %c3, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%42, %c8, %c1, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%44, %arg18) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %45 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg0, %45) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %46 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg19, %46) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %47 = call @kernel_gemm0(%45, %46) {adf.kernel, "col, row" = [5 : index, 3 : index], ivs = [0 : index, 3 : index, 0 : index], kernel = 0 : index, kernel_gemm0 = 12 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%47, %c6, %c3, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%45, %c5, %c4, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%46, %c5, %c2, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %48 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg2, %48) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %49 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg20, %49) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %50 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%47, %50) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %51 = call @kernel_gemm(%48, %49, %50) {adf.kernel, "col, row" = [6 : index, 3 : index], ivs = [1 : index, 3 : index, 0 : index], kernel_gemm = 13 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%51, %c7, %c3, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%48, %c6, %c4, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%49, %c6, %c2, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %52 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg4, %52) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %53 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg21, %53) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %54 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%51, %54) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %55 = call @kernel_gemm(%52, %53, %54) {adf.kernel, "col, row" = [7 : index, 3 : index], ivs = [2 : index, 3 : index, 0 : index], kernel_gemm = 14 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%55, %c8, %c3, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%52, %c7, %c4, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%53, %c7, %c2, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %56 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg6, %56) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %57 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg22, %57) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %58 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%55, %58) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %59 = call @kernel_gemm(%56, %57, %58) {adf.kernel, "col, row" = [8 : index, 3 : index], ivs = [3 : index, 3 : index, 0 : index], kernel_gemm = 15 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%59, %c9, %c3, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%56, %c8, %c4, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%57, %c8, %c2, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%59, %arg23) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %60 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg0, %60) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %61 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg24, %61) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %62 = call @kernel_gemm0(%60, %61) {adf.kernel, "col, row" = [5 : index, 4 : index], ivs = [0 : index, 4 : index, 0 : index], kernel = 0 : index, kernel_gemm0 = 16 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%62, %c5, %c4, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%60, %c5, %c5, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%61, %c5, %c3, %c16384, %c24576) : (memref<64x64xi8, 2>, index, index, index, index)
    %63 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg2, %63) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %64 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg25, %64) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %65 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%62, %65) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %66 = call @kernel_gemm(%63, %64, %65) {adf.kernel, "col, row" = [6 : index, 4 : index], ivs = [1 : index, 4 : index, 0 : index], kernel_gemm = 17 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%66, %c6, %c4, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%63, %c6, %c5, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%64, %c6, %c3, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %67 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg4, %67) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %68 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg26, %68) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %69 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%66, %69) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %70 = call @kernel_gemm(%67, %68, %69) {adf.kernel, "col, row" = [7 : index, 4 : index], ivs = [2 : index, 4 : index, 0 : index], kernel_gemm = 18 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%70, %c7, %c4, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%67, %c7, %c5, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%68, %c7, %c3, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %71 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg6, %71) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %72 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg27, %72) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %73 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%70, %73) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %74 = call @kernel_gemm(%71, %72, %73) {adf.kernel, "col, row" = [8 : index, 4 : index], ivs = [3 : index, 4 : index, 0 : index], kernel_gemm = 19 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%74, %c8, %c4, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%71, %c8, %c5, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%72, %c8, %c3, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%74, %arg28) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %75 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg0, %75) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %76 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg29, %76) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %77 = call @kernel_gemm0(%75, %76) {adf.kernel, "col, row" = [5 : index, 5 : index], ivs = [0 : index, 5 : index, 0 : index], kernel = 0 : index, kernel_gemm0 = 20 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%77, %c6, %c5, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%75, %c5, %c6, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%76, %c5, %c4, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %78 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg2, %78) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %79 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg30, %79) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %80 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%77, %80) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %81 = call @kernel_gemm(%78, %79, %80) {adf.kernel, "col, row" = [6 : index, 5 : index], ivs = [1 : index, 5 : index, 0 : index], kernel_gemm = 21 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%81, %c7, %c5, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%78, %c6, %c6, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%79, %c6, %c4, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %82 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg4, %82) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %83 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg31, %83) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %84 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%81, %84) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %85 = call @kernel_gemm(%82, %83, %84) {adf.kernel, "col, row" = [7 : index, 5 : index], ivs = [2 : index, 5 : index, 0 : index], kernel_gemm = 22 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%85, %c8, %c5, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%82, %c7, %c6, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%83, %c7, %c4, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %86 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg6, %86) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %87 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg32, %87) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %88 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%85, %88) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %89 = call @kernel_gemm(%86, %87, %88) {adf.kernel, "col, row" = [8 : index, 5 : index], ivs = [3 : index, 5 : index, 0 : index], kernel_gemm = 23 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%89, %c9, %c5, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%86, %c8, %c6, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%87, %c8, %c4, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%89, %arg33) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %90 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg0, %90) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %91 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg34, %91) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %92 = call @kernel_gemm0(%90, %91) {adf.kernel, "col, row" = [5 : index, 6 : index], ivs = [0 : index, 6 : index, 0 : index], kernel = 0 : index, kernel_gemm0 = 24 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%92, %c5, %c6, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%90, %c5, %c7, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%91, %c5, %c5, %c16384, %c24576) : (memref<64x64xi8, 2>, index, index, index, index)
    %93 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg2, %93) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %94 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg35, %94) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %95 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%92, %95) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %96 = call @kernel_gemm(%93, %94, %95) {adf.kernel, "col, row" = [6 : index, 6 : index], ivs = [1 : index, 6 : index, 0 : index], kernel_gemm = 25 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%96, %c6, %c6, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%93, %c6, %c7, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%94, %c6, %c5, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %97 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg4, %97) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %98 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg36, %98) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %99 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%96, %99) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %100 = call @kernel_gemm(%97, %98, %99) {adf.kernel, "col, row" = [7 : index, 6 : index], ivs = [2 : index, 6 : index, 0 : index], kernel_gemm = 26 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%100, %c7, %c6, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%97, %c7, %c7, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%98, %c7, %c5, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %101 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg6, %101) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %102 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg37, %102) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %103 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%100, %103) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %104 = call @kernel_gemm(%101, %102, %103) {adf.kernel, "col, row" = [8 : index, 6 : index], ivs = [3 : index, 6 : index, 0 : index], kernel_gemm = 27 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%104, %c8, %c6, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%101, %c8, %c7, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%102, %c8, %c5, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%104, %arg38) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %105 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg0, %105) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %106 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg39, %106) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %107 = call @kernel_gemm0(%105, %106) {adf.kernel, "col, row" = [5 : index, 7 : index], ivs = [0 : index, 7 : index, 0 : index], kernel = 0 : index, kernel_gemm0 = 28 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%107, %c6, %c7, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%105, %c5, %c7, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%106, %c5, %c6, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %108 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg2, %108) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %109 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg40, %109) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %110 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%107, %110) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %111 = call @kernel_gemm(%108, %109, %110) {adf.kernel, "col, row" = [6 : index, 7 : index], ivs = [1 : index, 7 : index, 0 : index], kernel_gemm = 29 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%111, %c7, %c7, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%108, %c6, %c7, %c4096, %c12288) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%109, %c6, %c6, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %112 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg4, %112) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %113 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg41, %113) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %114 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%111, %114) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %115 = call @kernel_gemm(%112, %113, %114) {adf.kernel, "col, row" = [7 : index, 7 : index], ivs = [2 : index, 7 : index, 0 : index], kernel_gemm = 30 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%115, %c8, %c7, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%112, %c7, %c7, %c4096, %c12288) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%113, %c7, %c6, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %116 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg6, %116) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %117 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg42, %117) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %118 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%115, %118) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %119 = call @kernel_gemm(%116, %117, %118) {adf.kernel, "col, row" = [8 : index, 7 : index], ivs = [3 : index, 7 : index, 0 : index], kernel_gemm = 31 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%119, %c9, %c7, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%116, %c8, %c7, %c4096, %c12288) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%117, %c8, %c6, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%119, %arg43) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %120 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg44, %120) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %121 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg1, %121) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %122 = call @kernel_gemm0(%120, %121) {adf.kernel, "col, row" = [9 : index, 0 : index], ivs = [0 : index, 0 : index, 1 : index], kernel = 0 : index, kernel_gemm0 = 32 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%122, %c9, %c0, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%120, %c8, %c0, %c4096, %c12288) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%121, %c9, %c1, %c16384, %c24576) : (memref<64x64xi8, 2>, index, index, index, index)
    %123 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg45, %123) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %124 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg3, %124) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %125 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%122, %125) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %126 = call @kernel_gemm(%123, %124, %125) {adf.kernel, "col, row" = [10 : index, 0 : index], ivs = [1 : index, 0 : index, 1 : index], kernel_gemm = 33 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%126, %c10, %c0, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%123, %c9, %c0, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%124, %c10, %c1, %c0, %c8192) : (memref<64x64xi8, 2>, index, index, index, index)
    %127 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg46, %127) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %128 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg5, %128) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %129 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%126, %129) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %130 = call @kernel_gemm(%127, %128, %129) {adf.kernel, "col, row" = [11 : index, 0 : index], ivs = [2 : index, 0 : index, 1 : index], kernel_gemm = 34 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%130, %c11, %c0, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%127, %c10, %c0, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%128, %c11, %c1, %c0, %c8192) : (memref<64x64xi8, 2>, index, index, index, index)
    %131 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg47, %131) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %132 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg7, %132) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %133 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%130, %133) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %134 = call @kernel_gemm(%131, %132, %133) {adf.kernel, "col, row" = [12 : index, 0 : index], ivs = [3 : index, 0 : index, 1 : index], kernel_gemm = 35 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%134, %c12, %c0, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%131, %c11, %c0, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%132, %c12, %c1, %c0, %c8192) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%134, %arg48) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %135 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg44, %135) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %136 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg9, %136) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %137 = call @kernel_gemm0(%135, %136) {adf.kernel, "col, row" = [9 : index, 1 : index], ivs = [0 : index, 1 : index, 1 : index], kernel = 0 : index, kernel_gemm0 = 36 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%137, %c10, %c1, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%135, %c9, %c2, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%136, %c9, %c0, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %138 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg45, %138) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %139 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg10, %139) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %140 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%137, %140) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %141 = call @kernel_gemm(%138, %139, %140) {adf.kernel, "col, row" = [10 : index, 1 : index], ivs = [1 : index, 1 : index, 1 : index], kernel_gemm = 37 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%141, %c11, %c1, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%138, %c10, %c2, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%139, %c10, %c0, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %142 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg46, %142) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %143 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg11, %143) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %144 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%141, %144) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %145 = call @kernel_gemm(%142, %143, %144) {adf.kernel, "col, row" = [11 : index, 1 : index], ivs = [2 : index, 1 : index, 1 : index], kernel_gemm = 38 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%145, %c12, %c1, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%142, %c11, %c2, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%143, %c11, %c0, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %146 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg47, %146) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %147 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg12, %147) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %148 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%145, %148) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %149 = call @kernel_gemm(%146, %147, %148) {adf.kernel, "col, row" = [12 : index, 1 : index], ivs = [3 : index, 1 : index, 1 : index], kernel_gemm = 39 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%149, %c13, %c1, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%146, %c12, %c2, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%147, %c12, %c0, %c16384, %c24576) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%149, %arg49) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %150 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg44, %150) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %151 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg14, %151) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %152 = call @kernel_gemm0(%150, %151) {adf.kernel, "col, row" = [9 : index, 2 : index], ivs = [0 : index, 2 : index, 1 : index], kernel = 0 : index, kernel_gemm0 = 40 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%152, %c9, %c2, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%150, %c9, %c3, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%151, %c9, %c1, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %153 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg45, %153) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %154 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg15, %154) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %155 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%152, %155) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %156 = call @kernel_gemm(%153, %154, %155) {adf.kernel, "col, row" = [10 : index, 2 : index], ivs = [1 : index, 2 : index, 1 : index], kernel_gemm = 41 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%156, %c10, %c2, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%153, %c10, %c3, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%154, %c10, %c1, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %157 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg46, %157) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %158 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg16, %158) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %159 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%156, %159) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %160 = call @kernel_gemm(%157, %158, %159) {adf.kernel, "col, row" = [11 : index, 2 : index], ivs = [2 : index, 2 : index, 1 : index], kernel_gemm = 42 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%160, %c11, %c2, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%157, %c11, %c3, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%158, %c11, %c1, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %161 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg47, %161) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %162 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg17, %162) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %163 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%160, %163) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %164 = call @kernel_gemm(%161, %162, %163) {adf.kernel, "col, row" = [12 : index, 2 : index], ivs = [3 : index, 2 : index, 1 : index], kernel_gemm = 43 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%164, %c12, %c2, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%161, %c12, %c3, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%162, %c12, %c1, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%164, %arg50) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %165 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg44, %165) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %166 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg19, %166) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %167 = call @kernel_gemm0(%165, %166) {adf.kernel, "col, row" = [9 : index, 3 : index], ivs = [0 : index, 3 : index, 1 : index], kernel = 0 : index, kernel_gemm0 = 44 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%167, %c10, %c3, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%165, %c9, %c4, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%166, %c9, %c2, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %168 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg45, %168) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %169 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg20, %169) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %170 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%167, %170) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %171 = call @kernel_gemm(%168, %169, %170) {adf.kernel, "col, row" = [10 : index, 3 : index], ivs = [1 : index, 3 : index, 1 : index], kernel_gemm = 45 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%171, %c11, %c3, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%168, %c10, %c4, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%169, %c10, %c2, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %172 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg46, %172) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %173 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg21, %173) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %174 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%171, %174) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %175 = call @kernel_gemm(%172, %173, %174) {adf.kernel, "col, row" = [11 : index, 3 : index], ivs = [2 : index, 3 : index, 1 : index], kernel_gemm = 46 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%175, %c12, %c3, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%172, %c11, %c4, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%173, %c11, %c2, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %176 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg47, %176) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %177 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg22, %177) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %178 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%175, %178) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %179 = call @kernel_gemm(%176, %177, %178) {adf.kernel, "col, row" = [12 : index, 3 : index], ivs = [3 : index, 3 : index, 1 : index], kernel_gemm = 47 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%179, %c13, %c3, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%176, %c12, %c4, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%177, %c12, %c2, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%179, %arg51) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %180 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg44, %180) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %181 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg24, %181) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %182 = call @kernel_gemm0(%180, %181) {adf.kernel, "col, row" = [9 : index, 4 : index], ivs = [0 : index, 4 : index, 1 : index], kernel = 0 : index, kernel_gemm0 = 48 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%182, %c9, %c4, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%180, %c9, %c5, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%181, %c9, %c3, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %183 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg45, %183) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %184 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg25, %184) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %185 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%182, %185) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %186 = call @kernel_gemm(%183, %184, %185) {adf.kernel, "col, row" = [10 : index, 4 : index], ivs = [1 : index, 4 : index, 1 : index], kernel_gemm = 49 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%186, %c10, %c4, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%183, %c10, %c5, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%184, %c10, %c3, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %187 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg46, %187) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %188 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg26, %188) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %189 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%186, %189) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %190 = call @kernel_gemm(%187, %188, %189) {adf.kernel, "col, row" = [11 : index, 4 : index], ivs = [2 : index, 4 : index, 1 : index], kernel_gemm = 50 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%190, %c11, %c4, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%187, %c11, %c5, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%188, %c11, %c3, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %191 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg47, %191) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %192 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg27, %192) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %193 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%190, %193) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %194 = call @kernel_gemm(%191, %192, %193) {adf.kernel, "col, row" = [12 : index, 4 : index], ivs = [3 : index, 4 : index, 1 : index], kernel_gemm = 51 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%194, %c12, %c4, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%191, %c12, %c5, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%192, %c12, %c3, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%194, %arg52) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %195 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg44, %195) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %196 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg29, %196) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %197 = call @kernel_gemm0(%195, %196) {adf.kernel, "col, row" = [9 : index, 5 : index], ivs = [0 : index, 5 : index, 1 : index], kernel = 0 : index, kernel_gemm0 = 52 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%197, %c10, %c5, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%195, %c9, %c6, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%196, %c9, %c4, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %198 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg45, %198) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %199 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg30, %199) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %200 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%197, %200) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %201 = call @kernel_gemm(%198, %199, %200) {adf.kernel, "col, row" = [10 : index, 5 : index], ivs = [1 : index, 5 : index, 1 : index], kernel_gemm = 53 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%201, %c11, %c5, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%198, %c10, %c6, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%199, %c10, %c4, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %202 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg46, %202) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %203 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg31, %203) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %204 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%201, %204) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %205 = call @kernel_gemm(%202, %203, %204) {adf.kernel, "col, row" = [11 : index, 5 : index], ivs = [2 : index, 5 : index, 1 : index], kernel_gemm = 54 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%205, %c12, %c5, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%202, %c11, %c6, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%203, %c11, %c4, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %206 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg47, %206) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %207 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg32, %207) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %208 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%205, %208) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %209 = call @kernel_gemm(%206, %207, %208) {adf.kernel, "col, row" = [12 : index, 5 : index], ivs = [3 : index, 5 : index, 1 : index], kernel_gemm = 55 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%209, %c13, %c5, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%206, %c12, %c6, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%207, %c12, %c4, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%209, %arg53) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %210 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg44, %210) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %211 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg34, %211) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %212 = call @kernel_gemm0(%210, %211) {adf.kernel, "col, row" = [9 : index, 6 : index], ivs = [0 : index, 6 : index, 1 : index], kernel = 0 : index, kernel_gemm0 = 56 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%212, %c9, %c6, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%210, %c9, %c7, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%211, %c9, %c5, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %213 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg45, %213) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %214 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg35, %214) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %215 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%212, %215) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %216 = call @kernel_gemm(%213, %214, %215) {adf.kernel, "col, row" = [10 : index, 6 : index], ivs = [1 : index, 6 : index, 1 : index], kernel_gemm = 57 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%216, %c10, %c6, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%213, %c10, %c7, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%214, %c10, %c5, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %217 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg46, %217) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %218 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg36, %218) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %219 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%216, %219) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %220 = call @kernel_gemm(%217, %218, %219) {adf.kernel, "col, row" = [11 : index, 6 : index], ivs = [2 : index, 6 : index, 1 : index], kernel_gemm = 58 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%220, %c11, %c6, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%217, %c11, %c7, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%218, %c11, %c5, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %221 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg47, %221) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %222 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg37, %222) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %223 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%220, %223) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %224 = call @kernel_gemm(%221, %222, %223) {adf.kernel, "col, row" = [12 : index, 6 : index], ivs = [3 : index, 6 : index, 1 : index], kernel_gemm = 59 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%224, %c12, %c6, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%221, %c12, %c7, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%222, %c12, %c5, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%224, %arg54) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %225 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg44, %225) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %226 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg39, %226) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %227 = call @kernel_gemm0(%225, %226) {adf.kernel, "col, row" = [9 : index, 7 : index], ivs = [0 : index, 7 : index, 1 : index], kernel = 0 : index, kernel_gemm0 = 60 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%227, %c10, %c7, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%225, %c9, %c7, %c4096, %c12288) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%226, %c9, %c6, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %228 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg45, %228) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %229 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg40, %229) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %230 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%227, %230) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %231 = call @kernel_gemm(%228, %229, %230) {adf.kernel, "col, row" = [10 : index, 7 : index], ivs = [1 : index, 7 : index, 1 : index], kernel_gemm = 61 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%231, %c11, %c7, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%228, %c10, %c7, %c4096, %c12288) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%229, %c10, %c6, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %232 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg46, %232) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %233 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg41, %233) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %234 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%231, %234) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %235 = call @kernel_gemm(%232, %233, %234) {adf.kernel, "col, row" = [11 : index, 7 : index], ivs = [2 : index, 7 : index, 1 : index], kernel_gemm = 62 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%235, %c12, %c7, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%232, %c11, %c7, %c4096, %c12288) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%233, %c11, %c6, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %236 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg47, %236) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %237 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg42, %237) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %238 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%235, %238) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %239 = call @kernel_gemm(%236, %237, %238) {adf.kernel, "col, row" = [12 : index, 7 : index], ivs = [3 : index, 7 : index, 1 : index], kernel_gemm = 63 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%239, %c13, %c7, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%236, %c12, %c7, %c4096, %c12288) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%237, %c12, %c6, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%239, %arg55) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %240 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg56, %240) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %241 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg1, %241) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %242 = call @kernel_gemm0(%240, %241) {adf.kernel, "col, row" = [13 : index, 0 : index], ivs = [0 : index, 0 : index, 2 : index], kernel = 0 : index, kernel_gemm0 = 64 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%242, %c13, %c0, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%240, %c12, %c0, %c4096, %c12288) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%241, %c13, %c1, %c16384, %c24576) : (memref<64x64xi8, 2>, index, index, index, index)
    %243 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg57, %243) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %244 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg3, %244) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %245 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%242, %245) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %246 = call @kernel_gemm(%243, %244, %245) {adf.kernel, "col, row" = [14 : index, 0 : index], ivs = [1 : index, 0 : index, 2 : index], kernel_gemm = 65 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%246, %c14, %c0, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%243, %c13, %c0, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%244, %c14, %c1, %c0, %c8192) : (memref<64x64xi8, 2>, index, index, index, index)
    %247 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg58, %247) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %248 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg5, %248) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %249 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%246, %249) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %250 = call @kernel_gemm(%247, %248, %249) {adf.kernel, "col, row" = [15 : index, 0 : index], ivs = [2 : index, 0 : index, 2 : index], kernel_gemm = 66 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%250, %c15, %c0, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%247, %c14, %c0, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%248, %c15, %c1, %c0, %c8192) : (memref<64x64xi8, 2>, index, index, index, index)
    %251 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg59, %251) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %252 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg7, %252) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %253 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%250, %253) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %254 = call @kernel_gemm(%251, %252, %253) {adf.kernel, "col, row" = [16 : index, 0 : index], ivs = [3 : index, 0 : index, 2 : index], kernel_gemm = 67 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%254, %c16, %c0, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%251, %c15, %c0, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%252, %c16, %c1, %c0, %c8192) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%254, %arg60) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %255 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg56, %255) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %256 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg9, %256) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %257 = call @kernel_gemm0(%255, %256) {adf.kernel, "col, row" = [13 : index, 1 : index], ivs = [0 : index, 1 : index, 2 : index], kernel = 0 : index, kernel_gemm0 = 68 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%257, %c14, %c1, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%255, %c13, %c2, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%256, %c13, %c0, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %258 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg57, %258) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %259 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg10, %259) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %260 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%257, %260) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %261 = call @kernel_gemm(%258, %259, %260) {adf.kernel, "col, row" = [14 : index, 1 : index], ivs = [1 : index, 1 : index, 2 : index], kernel_gemm = 69 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%261, %c15, %c1, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%258, %c14, %c2, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%259, %c14, %c0, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %262 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg58, %262) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %263 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg11, %263) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %264 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%261, %264) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %265 = call @kernel_gemm(%262, %263, %264) {adf.kernel, "col, row" = [15 : index, 1 : index], ivs = [2 : index, 1 : index, 2 : index], kernel_gemm = 70 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%265, %c16, %c1, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%262, %c15, %c2, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%263, %c15, %c0, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %266 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg59, %266) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %267 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg12, %267) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %268 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%265, %268) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %269 = call @kernel_gemm(%266, %267, %268) {adf.kernel, "col, row" = [16 : index, 1 : index], ivs = [3 : index, 1 : index, 2 : index], kernel_gemm = 71 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%269, %c17, %c1, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%266, %c16, %c2, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%267, %c16, %c0, %c16384, %c24576) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%269, %arg61) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %270 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg56, %270) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %271 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg14, %271) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %272 = call @kernel_gemm0(%270, %271) {adf.kernel, "col, row" = [13 : index, 2 : index], ivs = [0 : index, 2 : index, 2 : index], kernel = 0 : index, kernel_gemm0 = 72 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%272, %c13, %c2, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%270, %c13, %c3, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%271, %c13, %c1, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %273 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg57, %273) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %274 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg15, %274) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %275 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%272, %275) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %276 = call @kernel_gemm(%273, %274, %275) {adf.kernel, "col, row" = [14 : index, 2 : index], ivs = [1 : index, 2 : index, 2 : index], kernel_gemm = 73 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%276, %c14, %c2, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%273, %c14, %c3, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%274, %c14, %c1, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %277 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg58, %277) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %278 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg16, %278) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %279 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%276, %279) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %280 = call @kernel_gemm(%277, %278, %279) {adf.kernel, "col, row" = [15 : index, 2 : index], ivs = [2 : index, 2 : index, 2 : index], kernel_gemm = 74 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%280, %c15, %c2, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%277, %c15, %c3, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%278, %c15, %c1, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %281 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg59, %281) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %282 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg17, %282) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %283 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%280, %283) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %284 = call @kernel_gemm(%281, %282, %283) {adf.kernel, "col, row" = [16 : index, 2 : index], ivs = [3 : index, 2 : index, 2 : index], kernel_gemm = 75 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%284, %c16, %c2, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%281, %c16, %c3, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%282, %c16, %c1, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%284, %arg62) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %285 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg56, %285) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %286 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg19, %286) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %287 = call @kernel_gemm0(%285, %286) {adf.kernel, "col, row" = [13 : index, 3 : index], ivs = [0 : index, 3 : index, 2 : index], kernel = 0 : index, kernel_gemm0 = 76 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%287, %c14, %c3, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%285, %c13, %c4, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%286, %c13, %c2, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %288 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg57, %288) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %289 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg20, %289) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %290 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%287, %290) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %291 = call @kernel_gemm(%288, %289, %290) {adf.kernel, "col, row" = [14 : index, 3 : index], ivs = [1 : index, 3 : index, 2 : index], kernel_gemm = 77 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%291, %c15, %c3, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%288, %c14, %c4, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%289, %c14, %c2, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %292 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg58, %292) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %293 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg21, %293) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %294 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%291, %294) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %295 = call @kernel_gemm(%292, %293, %294) {adf.kernel, "col, row" = [15 : index, 3 : index], ivs = [2 : index, 3 : index, 2 : index], kernel_gemm = 78 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%295, %c16, %c3, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%292, %c15, %c4, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%293, %c15, %c2, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %296 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg59, %296) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %297 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg22, %297) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %298 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%295, %298) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %299 = call @kernel_gemm(%296, %297, %298) {adf.kernel, "col, row" = [16 : index, 3 : index], ivs = [3 : index, 3 : index, 2 : index], kernel_gemm = 79 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%299, %c17, %c3, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%296, %c16, %c4, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%297, %c16, %c2, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%299, %arg63) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %300 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg56, %300) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %301 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg24, %301) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %302 = call @kernel_gemm0(%300, %301) {adf.kernel, "col, row" = [13 : index, 4 : index], ivs = [0 : index, 4 : index, 2 : index], kernel = 0 : index, kernel_gemm0 = 80 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%302, %c13, %c4, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%300, %c13, %c5, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%301, %c13, %c3, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %303 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg57, %303) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %304 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg25, %304) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %305 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%302, %305) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %306 = call @kernel_gemm(%303, %304, %305) {adf.kernel, "col, row" = [14 : index, 4 : index], ivs = [1 : index, 4 : index, 2 : index], kernel_gemm = 81 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%306, %c14, %c4, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%303, %c14, %c5, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%304, %c14, %c3, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %307 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg58, %307) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %308 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg26, %308) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %309 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%306, %309) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %310 = call @kernel_gemm(%307, %308, %309) {adf.kernel, "col, row" = [15 : index, 4 : index], ivs = [2 : index, 4 : index, 2 : index], kernel_gemm = 82 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%310, %c15, %c4, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%307, %c15, %c5, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%308, %c15, %c3, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %311 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg59, %311) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %312 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg27, %312) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %313 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%310, %313) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %314 = call @kernel_gemm(%311, %312, %313) {adf.kernel, "col, row" = [16 : index, 4 : index], ivs = [3 : index, 4 : index, 2 : index], kernel_gemm = 83 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%314, %c16, %c4, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%311, %c16, %c5, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%312, %c16, %c3, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%314, %arg64) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %315 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg56, %315) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %316 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg29, %316) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %317 = call @kernel_gemm0(%315, %316) {adf.kernel, "col, row" = [13 : index, 5 : index], ivs = [0 : index, 5 : index, 2 : index], kernel = 0 : index, kernel_gemm0 = 84 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%317, %c14, %c5, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%315, %c13, %c6, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%316, %c13, %c4, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %318 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg57, %318) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %319 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg30, %319) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %320 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%317, %320) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %321 = call @kernel_gemm(%318, %319, %320) {adf.kernel, "col, row" = [14 : index, 5 : index], ivs = [1 : index, 5 : index, 2 : index], kernel_gemm = 85 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%321, %c15, %c5, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%318, %c14, %c6, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%319, %c14, %c4, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %322 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg58, %322) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %323 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg31, %323) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %324 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%321, %324) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %325 = call @kernel_gemm(%322, %323, %324) {adf.kernel, "col, row" = [15 : index, 5 : index], ivs = [2 : index, 5 : index, 2 : index], kernel_gemm = 86 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%325, %c16, %c5, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%322, %c15, %c6, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%323, %c15, %c4, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %326 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg59, %326) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %327 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg32, %327) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %328 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%325, %328) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %329 = call @kernel_gemm(%326, %327, %328) {adf.kernel, "col, row" = [16 : index, 5 : index], ivs = [3 : index, 5 : index, 2 : index], kernel_gemm = 87 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%329, %c17, %c5, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%326, %c16, %c6, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%327, %c16, %c4, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%329, %arg65) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %330 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg56, %330) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %331 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg34, %331) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %332 = call @kernel_gemm0(%330, %331) {adf.kernel, "col, row" = [13 : index, 6 : index], ivs = [0 : index, 6 : index, 2 : index], kernel = 0 : index, kernel_gemm0 = 88 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%332, %c13, %c6, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%330, %c13, %c7, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%331, %c13, %c5, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %333 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg57, %333) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %334 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg35, %334) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %335 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%332, %335) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %336 = call @kernel_gemm(%333, %334, %335) {adf.kernel, "col, row" = [14 : index, 6 : index], ivs = [1 : index, 6 : index, 2 : index], kernel_gemm = 89 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%336, %c14, %c6, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%333, %c14, %c7, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%334, %c14, %c5, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %337 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg58, %337) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %338 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg36, %338) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %339 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%336, %339) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %340 = call @kernel_gemm(%337, %338, %339) {adf.kernel, "col, row" = [15 : index, 6 : index], ivs = [2 : index, 6 : index, 2 : index], kernel_gemm = 90 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%340, %c15, %c6, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%337, %c15, %c7, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%338, %c15, %c5, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %341 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg59, %341) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %342 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg37, %342) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %343 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%340, %343) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %344 = call @kernel_gemm(%341, %342, %343) {adf.kernel, "col, row" = [16 : index, 6 : index], ivs = [3 : index, 6 : index, 2 : index], kernel_gemm = 91 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%344, %c16, %c6, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%341, %c16, %c7, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%342, %c16, %c5, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%344, %arg66) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %345 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg56, %345) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %346 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg39, %346) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %347 = call @kernel_gemm0(%345, %346) {adf.kernel, "col, row" = [13 : index, 7 : index], ivs = [0 : index, 7 : index, 2 : index], kernel = 0 : index, kernel_gemm0 = 92 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%347, %c14, %c7, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%345, %c13, %c7, %c4096, %c12288) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%346, %c13, %c6, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %348 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg57, %348) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %349 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg40, %349) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %350 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%347, %350) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %351 = call @kernel_gemm(%348, %349, %350) {adf.kernel, "col, row" = [14 : index, 7 : index], ivs = [1 : index, 7 : index, 2 : index], kernel_gemm = 93 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%351, %c15, %c7, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%348, %c14, %c7, %c4096, %c12288) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%349, %c14, %c6, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %352 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg58, %352) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %353 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg41, %353) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %354 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%351, %354) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %355 = call @kernel_gemm(%352, %353, %354) {adf.kernel, "col, row" = [15 : index, 7 : index], ivs = [2 : index, 7 : index, 2 : index], kernel_gemm = 94 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%355, %c16, %c7, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%352, %c15, %c7, %c4096, %c12288) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%353, %c15, %c6, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %356 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg59, %356) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %357 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg42, %357) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %358 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%355, %358) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %359 = call @kernel_gemm(%356, %357, %358) {adf.kernel, "col, row" = [16 : index, 7 : index], ivs = [3 : index, 7 : index, 2 : index], kernel_gemm = 95 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%359, %c17, %c7, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%356, %c16, %c7, %c4096, %c12288) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%357, %c16, %c6, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%359, %arg67) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %360 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg68, %360) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %361 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg1, %361) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %362 = call @kernel_gemm0(%360, %361) {adf.kernel, "col, row" = [17 : index, 0 : index], ivs = [0 : index, 0 : index, 3 : index], kernel = 0 : index, kernel_gemm0 = 96 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%362, %c17, %c0, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%360, %c16, %c0, %c4096, %c12288) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%361, %c17, %c1, %c16384, %c24576) : (memref<64x64xi8, 2>, index, index, index, index)
    %363 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg69, %363) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %364 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg3, %364) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %365 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%362, %365) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %366 = call @kernel_gemm(%363, %364, %365) {adf.kernel, "col, row" = [18 : index, 0 : index], ivs = [1 : index, 0 : index, 3 : index], kernel_gemm = 97 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%366, %c18, %c0, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%363, %c17, %c0, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%364, %c18, %c1, %c0, %c8192) : (memref<64x64xi8, 2>, index, index, index, index)
    %367 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg70, %367) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %368 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg5, %368) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %369 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%366, %369) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %370 = call @kernel_gemm(%367, %368, %369) {adf.kernel, "col, row" = [19 : index, 0 : index], ivs = [2 : index, 0 : index, 3 : index], kernel_gemm = 98 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%370, %c19, %c0, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%367, %c18, %c0, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%368, %c19, %c1, %c0, %c8192) : (memref<64x64xi8, 2>, index, index, index, index)
    %371 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg71, %371) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %372 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg7, %372) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %373 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%370, %373) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %374 = call @kernel_gemm(%371, %372, %373) {adf.kernel, "col, row" = [20 : index, 0 : index], ivs = [3 : index, 0 : index, 3 : index], kernel_gemm = 99 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%374, %c20, %c0, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%371, %c19, %c0, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%372, %c20, %c1, %c0, %c8192) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%374, %arg72) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %375 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg68, %375) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %376 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg9, %376) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %377 = call @kernel_gemm0(%375, %376) {adf.kernel, "col, row" = [17 : index, 1 : index], ivs = [0 : index, 1 : index, 3 : index], kernel = 0 : index, kernel_gemm0 = 100 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%377, %c18, %c1, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%375, %c17, %c2, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%376, %c17, %c0, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %378 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg69, %378) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %379 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg10, %379) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %380 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%377, %380) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %381 = call @kernel_gemm(%378, %379, %380) {adf.kernel, "col, row" = [18 : index, 1 : index], ivs = [1 : index, 1 : index, 3 : index], kernel_gemm = 101 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%381, %c19, %c1, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%378, %c18, %c2, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%379, %c18, %c0, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %382 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg70, %382) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %383 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg11, %383) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %384 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%381, %384) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %385 = call @kernel_gemm(%382, %383, %384) {adf.kernel, "col, row" = [19 : index, 1 : index], ivs = [2 : index, 1 : index, 3 : index], kernel_gemm = 102 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%385, %c20, %c1, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%382, %c19, %c2, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%383, %c19, %c0, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %386 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg71, %386) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %387 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg12, %387) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %388 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%385, %388) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %389 = call @kernel_gemm(%386, %387, %388) {adf.kernel, "col, row" = [20 : index, 1 : index], ivs = [3 : index, 1 : index, 3 : index], kernel_gemm = 103 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%389, %c21, %c1, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%386, %c20, %c2, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%387, %c20, %c0, %c16384, %c24576) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%389, %arg73) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %390 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg68, %390) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %391 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg14, %391) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %392 = call @kernel_gemm0(%390, %391) {adf.kernel, "col, row" = [17 : index, 2 : index], ivs = [0 : index, 2 : index, 3 : index], kernel = 0 : index, kernel_gemm0 = 104 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%392, %c17, %c2, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%390, %c17, %c3, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%391, %c17, %c1, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %393 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg69, %393) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %394 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg15, %394) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %395 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%392, %395) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %396 = call @kernel_gemm(%393, %394, %395) {adf.kernel, "col, row" = [18 : index, 2 : index], ivs = [1 : index, 2 : index, 3 : index], kernel_gemm = 105 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%396, %c18, %c2, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%393, %c18, %c3, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%394, %c18, %c1, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %397 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg70, %397) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %398 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg16, %398) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %399 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%396, %399) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %400 = call @kernel_gemm(%397, %398, %399) {adf.kernel, "col, row" = [19 : index, 2 : index], ivs = [2 : index, 2 : index, 3 : index], kernel_gemm = 106 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%400, %c19, %c2, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%397, %c19, %c3, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%398, %c19, %c1, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %401 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg71, %401) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %402 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg17, %402) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %403 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%400, %403) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %404 = call @kernel_gemm(%401, %402, %403) {adf.kernel, "col, row" = [20 : index, 2 : index], ivs = [3 : index, 2 : index, 3 : index], kernel_gemm = 107 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%404, %c20, %c2, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%401, %c20, %c3, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%402, %c20, %c1, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%404, %arg74) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %405 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg68, %405) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %406 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg19, %406) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %407 = call @kernel_gemm0(%405, %406) {adf.kernel, "col, row" = [17 : index, 3 : index], ivs = [0 : index, 3 : index, 3 : index], kernel = 0 : index, kernel_gemm0 = 108 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%407, %c18, %c3, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%405, %c17, %c4, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%406, %c17, %c2, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %408 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg69, %408) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %409 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg20, %409) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %410 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%407, %410) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %411 = call @kernel_gemm(%408, %409, %410) {adf.kernel, "col, row" = [18 : index, 3 : index], ivs = [1 : index, 3 : index, 3 : index], kernel_gemm = 109 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%411, %c19, %c3, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%408, %c18, %c4, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%409, %c18, %c2, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %412 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg70, %412) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %413 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg21, %413) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %414 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%411, %414) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %415 = call @kernel_gemm(%412, %413, %414) {adf.kernel, "col, row" = [19 : index, 3 : index], ivs = [2 : index, 3 : index, 3 : index], kernel_gemm = 110 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%415, %c20, %c3, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%412, %c19, %c4, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%413, %c19, %c2, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %416 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg71, %416) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %417 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg22, %417) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %418 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%415, %418) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %419 = call @kernel_gemm(%416, %417, %418) {adf.kernel, "col, row" = [20 : index, 3 : index], ivs = [3 : index, 3 : index, 3 : index], kernel_gemm = 111 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%419, %c21, %c3, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%416, %c20, %c4, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%417, %c20, %c2, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%419, %arg75) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %420 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg68, %420) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %421 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg24, %421) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %422 = call @kernel_gemm0(%420, %421) {adf.kernel, "col, row" = [17 : index, 4 : index], ivs = [0 : index, 4 : index, 3 : index], kernel = 0 : index, kernel_gemm0 = 112 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%422, %c17, %c4, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%420, %c17, %c5, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%421, %c17, %c3, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %423 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg69, %423) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %424 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg25, %424) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %425 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%422, %425) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %426 = call @kernel_gemm(%423, %424, %425) {adf.kernel, "col, row" = [18 : index, 4 : index], ivs = [1 : index, 4 : index, 3 : index], kernel_gemm = 113 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%426, %c18, %c4, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%423, %c18, %c5, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%424, %c18, %c3, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %427 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg70, %427) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %428 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg26, %428) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %429 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%426, %429) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %430 = call @kernel_gemm(%427, %428, %429) {adf.kernel, "col, row" = [19 : index, 4 : index], ivs = [2 : index, 4 : index, 3 : index], kernel_gemm = 114 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%430, %c19, %c4, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%427, %c19, %c5, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%428, %c19, %c3, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %431 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg71, %431) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %432 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg27, %432) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %433 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%430, %433) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %434 = call @kernel_gemm(%431, %432, %433) {adf.kernel, "col, row" = [20 : index, 4 : index], ivs = [3 : index, 4 : index, 3 : index], kernel_gemm = 115 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%434, %c20, %c4, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%431, %c20, %c5, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%432, %c20, %c3, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%434, %arg76) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %435 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg68, %435) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %436 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg29, %436) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %437 = call @kernel_gemm0(%435, %436) {adf.kernel, "col, row" = [17 : index, 5 : index], ivs = [0 : index, 5 : index, 3 : index], kernel = 0 : index, kernel_gemm0 = 116 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%437, %c18, %c5, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%435, %c17, %c6, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%436, %c17, %c4, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %438 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg69, %438) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %439 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg30, %439) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %440 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%437, %440) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %441 = call @kernel_gemm(%438, %439, %440) {adf.kernel, "col, row" = [18 : index, 5 : index], ivs = [1 : index, 5 : index, 3 : index], kernel_gemm = 117 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%441, %c19, %c5, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%438, %c18, %c6, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%439, %c18, %c4, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %442 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg70, %442) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %443 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg31, %443) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %444 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%441, %444) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %445 = call @kernel_gemm(%442, %443, %444) {adf.kernel, "col, row" = [19 : index, 5 : index], ivs = [2 : index, 5 : index, 3 : index], kernel_gemm = 118 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%445, %c20, %c5, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%442, %c19, %c6, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%443, %c19, %c4, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %446 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg71, %446) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %447 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg32, %447) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %448 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%445, %448) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %449 = call @kernel_gemm(%446, %447, %448) {adf.kernel, "col, row" = [20 : index, 5 : index], ivs = [3 : index, 5 : index, 3 : index], kernel_gemm = 119 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%449, %c21, %c5, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%446, %c20, %c6, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%447, %c20, %c4, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%449, %arg77) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %450 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg68, %450) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %451 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg34, %451) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %452 = call @kernel_gemm0(%450, %451) {adf.kernel, "col, row" = [17 : index, 6 : index], ivs = [0 : index, 6 : index, 3 : index], kernel = 0 : index, kernel_gemm0 = 120 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%452, %c17, %c6, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%450, %c17, %c7, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%451, %c17, %c5, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %453 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg69, %453) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %454 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg35, %454) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %455 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%452, %455) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %456 = call @kernel_gemm(%453, %454, %455) {adf.kernel, "col, row" = [18 : index, 6 : index], ivs = [1 : index, 6 : index, 3 : index], kernel_gemm = 121 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%456, %c18, %c6, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%453, %c18, %c7, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%454, %c18, %c5, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %457 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg70, %457) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %458 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg36, %458) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %459 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%456, %459) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %460 = call @kernel_gemm(%457, %458, %459) {adf.kernel, "col, row" = [19 : index, 6 : index], ivs = [2 : index, 6 : index, 3 : index], kernel_gemm = 122 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%460, %c19, %c6, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%457, %c19, %c7, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%458, %c19, %c5, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %461 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg71, %461) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %462 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg37, %462) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %463 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%460, %463) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %464 = call @kernel_gemm(%461, %462, %463) {adf.kernel, "col, row" = [20 : index, 6 : index], ivs = [3 : index, 6 : index, 3 : index], kernel_gemm = 123 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%464, %c20, %c6, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%461, %c20, %c7, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%462, %c20, %c5, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%464, %arg78) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %465 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg68, %465) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %466 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg39, %466) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %467 = call @kernel_gemm0(%465, %466) {adf.kernel, "col, row" = [17 : index, 7 : index], ivs = [0 : index, 7 : index, 3 : index], kernel = 0 : index, kernel_gemm0 = 124 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%467, %c18, %c7, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%465, %c17, %c7, %c4096, %c12288) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%466, %c17, %c6, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %468 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg69, %468) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %469 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg40, %469) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %470 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%467, %470) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %471 = call @kernel_gemm(%468, %469, %470) {adf.kernel, "col, row" = [18 : index, 7 : index], ivs = [1 : index, 7 : index, 3 : index], kernel_gemm = 125 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%471, %c19, %c7, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%468, %c18, %c7, %c4096, %c12288) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%469, %c18, %c6, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %472 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg70, %472) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %473 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg41, %473) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %474 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%471, %474) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %475 = call @kernel_gemm(%472, %473, %474) {adf.kernel, "col, row" = [19 : index, 7 : index], ivs = [2 : index, 7 : index, 3 : index], kernel_gemm = 126 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%475, %c20, %c7, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%472, %c19, %c7, %c4096, %c12288) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%473, %c19, %c6, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %476 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg71, %476) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %477 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg42, %477) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %478 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%475, %478) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %479 = call @kernel_gemm(%476, %477, %478) {adf.kernel, "col, row" = [20 : index, 7 : index], ivs = [3 : index, 7 : index, 3 : index], kernel_gemm = 127 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%479, %c21, %c7, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%476, %c20, %c7, %c4096, %c12288) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%477, %c20, %c6, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%479, %arg79) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %480 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg80, %480) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %481 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg1, %481) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %482 = call @kernel_gemm0(%480, %481) {adf.kernel, "col, row" = [21 : index, 0 : index], ivs = [0 : index, 0 : index, 4 : index], kernel = 0 : index, kernel_gemm0 = 128 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%482, %c21, %c0, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%480, %c20, %c0, %c4096, %c12288) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%481, %c21, %c1, %c16384, %c24576) : (memref<64x64xi8, 2>, index, index, index, index)
    %483 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg81, %483) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %484 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg3, %484) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %485 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%482, %485) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %486 = call @kernel_gemm(%483, %484, %485) {adf.kernel, "col, row" = [22 : index, 0 : index], ivs = [1 : index, 0 : index, 4 : index], kernel_gemm = 129 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%486, %c22, %c0, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%483, %c21, %c0, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%484, %c22, %c1, %c0, %c8192) : (memref<64x64xi8, 2>, index, index, index, index)
    %487 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg82, %487) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %488 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg5, %488) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %489 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%486, %489) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %490 = call @kernel_gemm(%487, %488, %489) {adf.kernel, "col, row" = [23 : index, 0 : index], ivs = [2 : index, 0 : index, 4 : index], kernel_gemm = 130 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%490, %c23, %c0, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%487, %c22, %c0, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%488, %c23, %c1, %c0, %c8192) : (memref<64x64xi8, 2>, index, index, index, index)
    %491 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg83, %491) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %492 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg7, %492) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %493 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%490, %493) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %494 = call @kernel_gemm(%491, %492, %493) {adf.kernel, "col, row" = [24 : index, 0 : index], ivs = [3 : index, 0 : index, 4 : index], kernel_gemm = 131 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%494, %c24, %c0, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%491, %c23, %c0, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%492, %c24, %c1, %c0, %c8192) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%494, %arg84) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %495 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg80, %495) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %496 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg9, %496) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %497 = call @kernel_gemm0(%495, %496) {adf.kernel, "col, row" = [21 : index, 1 : index], ivs = [0 : index, 1 : index, 4 : index], kernel = 0 : index, kernel_gemm0 = 132 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%497, %c22, %c1, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%495, %c21, %c2, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%496, %c21, %c0, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %498 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg81, %498) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %499 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg10, %499) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %500 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%497, %500) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %501 = call @kernel_gemm(%498, %499, %500) {adf.kernel, "col, row" = [22 : index, 1 : index], ivs = [1 : index, 1 : index, 4 : index], kernel_gemm = 133 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%501, %c23, %c1, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%498, %c22, %c2, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%499, %c22, %c0, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %502 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg82, %502) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %503 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg11, %503) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %504 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%501, %504) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %505 = call @kernel_gemm(%502, %503, %504) {adf.kernel, "col, row" = [23 : index, 1 : index], ivs = [2 : index, 1 : index, 4 : index], kernel_gemm = 134 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%505, %c24, %c1, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%502, %c23, %c2, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%503, %c23, %c0, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %506 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg83, %506) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %507 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg12, %507) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %508 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%505, %508) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %509 = call @kernel_gemm(%506, %507, %508) {adf.kernel, "col, row" = [24 : index, 1 : index], ivs = [3 : index, 1 : index, 4 : index], kernel_gemm = 135 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%509, %c25, %c1, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%506, %c24, %c2, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%507, %c24, %c0, %c16384, %c24576) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%509, %arg85) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %510 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg80, %510) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %511 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg14, %511) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %512 = call @kernel_gemm0(%510, %511) {adf.kernel, "col, row" = [21 : index, 2 : index], ivs = [0 : index, 2 : index, 4 : index], kernel = 0 : index, kernel_gemm0 = 136 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%512, %c21, %c2, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%510, %c21, %c3, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%511, %c21, %c1, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %513 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg81, %513) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %514 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg15, %514) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %515 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%512, %515) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %516 = call @kernel_gemm(%513, %514, %515) {adf.kernel, "col, row" = [22 : index, 2 : index], ivs = [1 : index, 2 : index, 4 : index], kernel_gemm = 137 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%516, %c22, %c2, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%513, %c22, %c3, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%514, %c22, %c1, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %517 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg82, %517) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %518 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg16, %518) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %519 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%516, %519) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %520 = call @kernel_gemm(%517, %518, %519) {adf.kernel, "col, row" = [23 : index, 2 : index], ivs = [2 : index, 2 : index, 4 : index], kernel_gemm = 138 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%520, %c23, %c2, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%517, %c23, %c3, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%518, %c23, %c1, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %521 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg83, %521) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %522 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg17, %522) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %523 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%520, %523) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %524 = call @kernel_gemm(%521, %522, %523) {adf.kernel, "col, row" = [24 : index, 2 : index], ivs = [3 : index, 2 : index, 4 : index], kernel_gemm = 139 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%524, %c24, %c2, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%521, %c24, %c3, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%522, %c24, %c1, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%524, %arg86) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %525 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg80, %525) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %526 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg19, %526) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %527 = call @kernel_gemm0(%525, %526) {adf.kernel, "col, row" = [21 : index, 3 : index], ivs = [0 : index, 3 : index, 4 : index], kernel = 0 : index, kernel_gemm0 = 140 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%527, %c22, %c3, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%525, %c21, %c4, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%526, %c21, %c2, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %528 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg81, %528) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %529 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg20, %529) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %530 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%527, %530) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %531 = call @kernel_gemm(%528, %529, %530) {adf.kernel, "col, row" = [22 : index, 3 : index], ivs = [1 : index, 3 : index, 4 : index], kernel_gemm = 141 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%531, %c23, %c3, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%528, %c22, %c4, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%529, %c22, %c2, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %532 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg82, %532) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %533 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg21, %533) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %534 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%531, %534) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %535 = call @kernel_gemm(%532, %533, %534) {adf.kernel, "col, row" = [23 : index, 3 : index], ivs = [2 : index, 3 : index, 4 : index], kernel_gemm = 142 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%535, %c24, %c3, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%532, %c23, %c4, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%533, %c23, %c2, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %536 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg83, %536) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %537 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg22, %537) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %538 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%535, %538) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %539 = call @kernel_gemm(%536, %537, %538) {adf.kernel, "col, row" = [24 : index, 3 : index], ivs = [3 : index, 3 : index, 4 : index], kernel_gemm = 143 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%539, %c25, %c3, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%536, %c24, %c4, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%537, %c24, %c2, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%539, %arg87) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %540 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg80, %540) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %541 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg24, %541) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %542 = call @kernel_gemm0(%540, %541) {adf.kernel, "col, row" = [21 : index, 4 : index], ivs = [0 : index, 4 : index, 4 : index], kernel = 0 : index, kernel_gemm0 = 144 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%542, %c21, %c4, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%540, %c21, %c5, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%541, %c21, %c3, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %543 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg81, %543) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %544 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg25, %544) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %545 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%542, %545) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %546 = call @kernel_gemm(%543, %544, %545) {adf.kernel, "col, row" = [22 : index, 4 : index], ivs = [1 : index, 4 : index, 4 : index], kernel_gemm = 145 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%546, %c22, %c4, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%543, %c22, %c5, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%544, %c22, %c3, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %547 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg82, %547) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %548 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg26, %548) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %549 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%546, %549) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %550 = call @kernel_gemm(%547, %548, %549) {adf.kernel, "col, row" = [23 : index, 4 : index], ivs = [2 : index, 4 : index, 4 : index], kernel_gemm = 146 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%550, %c23, %c4, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%547, %c23, %c5, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%548, %c23, %c3, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %551 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg83, %551) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %552 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg27, %552) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %553 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%550, %553) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %554 = call @kernel_gemm(%551, %552, %553) {adf.kernel, "col, row" = [24 : index, 4 : index], ivs = [3 : index, 4 : index, 4 : index], kernel_gemm = 147 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%554, %c24, %c4, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%551, %c24, %c5, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%552, %c24, %c3, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%554, %arg88) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %555 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg80, %555) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %556 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg29, %556) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %557 = call @kernel_gemm0(%555, %556) {adf.kernel, "col, row" = [21 : index, 5 : index], ivs = [0 : index, 5 : index, 4 : index], kernel = 0 : index, kernel_gemm0 = 148 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%557, %c22, %c5, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%555, %c21, %c6, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%556, %c21, %c4, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %558 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg81, %558) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %559 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg30, %559) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %560 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%557, %560) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %561 = call @kernel_gemm(%558, %559, %560) {adf.kernel, "col, row" = [22 : index, 5 : index], ivs = [1 : index, 5 : index, 4 : index], kernel_gemm = 149 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%561, %c23, %c5, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%558, %c22, %c6, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%559, %c22, %c4, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %562 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg82, %562) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %563 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg31, %563) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %564 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%561, %564) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %565 = call @kernel_gemm(%562, %563, %564) {adf.kernel, "col, row" = [23 : index, 5 : index], ivs = [2 : index, 5 : index, 4 : index], kernel_gemm = 150 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%565, %c24, %c5, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%562, %c23, %c6, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%563, %c23, %c4, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %566 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg83, %566) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %567 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg32, %567) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %568 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%565, %568) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %569 = call @kernel_gemm(%566, %567, %568) {adf.kernel, "col, row" = [24 : index, 5 : index], ivs = [3 : index, 5 : index, 4 : index], kernel_gemm = 151 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%569, %c25, %c5, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%566, %c24, %c6, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%567, %c24, %c4, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%569, %arg89) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %570 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg80, %570) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %571 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg34, %571) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %572 = call @kernel_gemm0(%570, %571) {adf.kernel, "col, row" = [21 : index, 6 : index], ivs = [0 : index, 6 : index, 4 : index], kernel = 0 : index, kernel_gemm0 = 152 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%572, %c21, %c6, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%570, %c21, %c7, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%571, %c21, %c5, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %573 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg81, %573) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %574 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg35, %574) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %575 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%572, %575) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %576 = call @kernel_gemm(%573, %574, %575) {adf.kernel, "col, row" = [22 : index, 6 : index], ivs = [1 : index, 6 : index, 4 : index], kernel_gemm = 153 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%576, %c22, %c6, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%573, %c22, %c7, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%574, %c22, %c5, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %577 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg82, %577) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %578 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg36, %578) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %579 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%576, %579) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %580 = call @kernel_gemm(%577, %578, %579) {adf.kernel, "col, row" = [23 : index, 6 : index], ivs = [2 : index, 6 : index, 4 : index], kernel_gemm = 154 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%580, %c23, %c6, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%577, %c23, %c7, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%578, %c23, %c5, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %581 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg83, %581) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %582 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg37, %582) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %583 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%580, %583) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %584 = call @kernel_gemm(%581, %582, %583) {adf.kernel, "col, row" = [24 : index, 6 : index], ivs = [3 : index, 6 : index, 4 : index], kernel_gemm = 155 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%584, %c24, %c6, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%581, %c24, %c7, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%582, %c24, %c5, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%584, %arg90) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %585 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg80, %585) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %586 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg39, %586) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %587 = call @kernel_gemm0(%585, %586) {adf.kernel, "col, row" = [21 : index, 7 : index], ivs = [0 : index, 7 : index, 4 : index], kernel = 0 : index, kernel_gemm0 = 156 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%587, %c22, %c7, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%585, %c21, %c7, %c4096, %c12288) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%586, %c21, %c6, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %588 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg81, %588) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %589 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg40, %589) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %590 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%587, %590) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %591 = call @kernel_gemm(%588, %589, %590) {adf.kernel, "col, row" = [22 : index, 7 : index], ivs = [1 : index, 7 : index, 4 : index], kernel_gemm = 157 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%591, %c23, %c7, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%588, %c22, %c7, %c4096, %c12288) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%589, %c22, %c6, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %592 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg82, %592) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %593 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg41, %593) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %594 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%591, %594) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %595 = call @kernel_gemm(%592, %593, %594) {adf.kernel, "col, row" = [23 : index, 7 : index], ivs = [2 : index, 7 : index, 4 : index], kernel_gemm = 158 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%595, %c24, %c7, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%592, %c23, %c7, %c4096, %c12288) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%593, %c23, %c6, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %596 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg83, %596) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %597 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg42, %597) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %598 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%595, %598) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %599 = call @kernel_gemm(%596, %597, %598) {adf.kernel, "col, row" = [24 : index, 7 : index], ivs = [3 : index, 7 : index, 4 : index], kernel_gemm = 159 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%599, %c25, %c7, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%596, %c24, %c7, %c4096, %c12288) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%597, %c24, %c6, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%599, %arg91) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %600 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg92, %600) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %601 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg1, %601) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %602 = call @kernel_gemm0(%600, %601) {adf.kernel, "col, row" = [25 : index, 0 : index], ivs = [0 : index, 0 : index, 5 : index], kernel = 0 : index, kernel_gemm0 = 160 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%602, %c25, %c0, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%600, %c24, %c0, %c4096, %c12288) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%601, %c25, %c1, %c16384, %c24576) : (memref<64x64xi8, 2>, index, index, index, index)
    %603 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg93, %603) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %604 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg3, %604) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %605 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%602, %605) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %606 = call @kernel_gemm(%603, %604, %605) {adf.kernel, "col, row" = [26 : index, 0 : index], ivs = [1 : index, 0 : index, 5 : index], kernel_gemm = 161 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%606, %c26, %c0, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%603, %c25, %c0, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%604, %c26, %c1, %c0, %c8192) : (memref<64x64xi8, 2>, index, index, index, index)
    %607 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg94, %607) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %608 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg5, %608) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %609 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%606, %609) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %610 = call @kernel_gemm(%607, %608, %609) {adf.kernel, "col, row" = [27 : index, 0 : index], ivs = [2 : index, 0 : index, 5 : index], kernel_gemm = 162 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%610, %c27, %c0, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%607, %c26, %c0, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%608, %c27, %c1, %c0, %c8192) : (memref<64x64xi8, 2>, index, index, index, index)
    %611 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg95, %611) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %612 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg7, %612) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %613 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%610, %613) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %614 = call @kernel_gemm(%611, %612, %613) {adf.kernel, "col, row" = [28 : index, 0 : index], ivs = [3 : index, 0 : index, 5 : index], kernel_gemm = 163 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%614, %c28, %c0, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%611, %c27, %c0, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%612, %c28, %c1, %c0, %c8192) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%614, %arg96) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %615 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg92, %615) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %616 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg9, %616) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %617 = call @kernel_gemm0(%615, %616) {adf.kernel, "col, row" = [25 : index, 1 : index], ivs = [0 : index, 1 : index, 5 : index], kernel = 0 : index, kernel_gemm0 = 164 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%617, %c26, %c1, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%615, %c25, %c2, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%616, %c25, %c0, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %618 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg93, %618) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %619 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg10, %619) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %620 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%617, %620) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %621 = call @kernel_gemm(%618, %619, %620) {adf.kernel, "col, row" = [26 : index, 1 : index], ivs = [1 : index, 1 : index, 5 : index], kernel_gemm = 165 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%621, %c27, %c1, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%618, %c26, %c2, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%619, %c26, %c0, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %622 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg94, %622) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %623 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg11, %623) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %624 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%621, %624) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %625 = call @kernel_gemm(%622, %623, %624) {adf.kernel, "col, row" = [27 : index, 1 : index], ivs = [2 : index, 1 : index, 5 : index], kernel_gemm = 166 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%625, %c28, %c1, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%622, %c27, %c2, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%623, %c27, %c0, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %626 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg95, %626) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %627 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg12, %627) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %628 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%625, %628) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %629 = call @kernel_gemm(%626, %627, %628) {adf.kernel, "col, row" = [28 : index, 1 : index], ivs = [3 : index, 1 : index, 5 : index], kernel_gemm = 167 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%629, %c29, %c1, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%626, %c28, %c2, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%627, %c28, %c0, %c16384, %c24576) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%629, %arg97) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %630 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg92, %630) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %631 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg14, %631) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %632 = call @kernel_gemm0(%630, %631) {adf.kernel, "col, row" = [25 : index, 2 : index], ivs = [0 : index, 2 : index, 5 : index], kernel = 0 : index, kernel_gemm0 = 168 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%632, %c25, %c2, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%630, %c25, %c3, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%631, %c25, %c1, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %633 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg93, %633) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %634 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg15, %634) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %635 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%632, %635) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %636 = call @kernel_gemm(%633, %634, %635) {adf.kernel, "col, row" = [26 : index, 2 : index], ivs = [1 : index, 2 : index, 5 : index], kernel_gemm = 169 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%636, %c26, %c2, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%633, %c26, %c3, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%634, %c26, %c1, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %637 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg94, %637) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %638 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg16, %638) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %639 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%636, %639) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %640 = call @kernel_gemm(%637, %638, %639) {adf.kernel, "col, row" = [27 : index, 2 : index], ivs = [2 : index, 2 : index, 5 : index], kernel_gemm = 170 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%640, %c27, %c2, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%637, %c27, %c3, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%638, %c27, %c1, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %641 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg95, %641) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %642 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg17, %642) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %643 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%640, %643) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %644 = call @kernel_gemm(%641, %642, %643) {adf.kernel, "col, row" = [28 : index, 2 : index], ivs = [3 : index, 2 : index, 5 : index], kernel_gemm = 171 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%644, %c28, %c2, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%641, %c28, %c3, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%642, %c28, %c1, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%644, %arg98) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %645 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg92, %645) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %646 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg19, %646) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %647 = call @kernel_gemm0(%645, %646) {adf.kernel, "col, row" = [25 : index, 3 : index], ivs = [0 : index, 3 : index, 5 : index], kernel = 0 : index, kernel_gemm0 = 172 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%647, %c26, %c3, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%645, %c25, %c4, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%646, %c25, %c2, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %648 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg93, %648) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %649 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg20, %649) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %650 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%647, %650) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %651 = call @kernel_gemm(%648, %649, %650) {adf.kernel, "col, row" = [26 : index, 3 : index], ivs = [1 : index, 3 : index, 5 : index], kernel_gemm = 173 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%651, %c27, %c3, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%648, %c26, %c4, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%649, %c26, %c2, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %652 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg94, %652) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %653 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg21, %653) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %654 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%651, %654) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %655 = call @kernel_gemm(%652, %653, %654) {adf.kernel, "col, row" = [27 : index, 3 : index], ivs = [2 : index, 3 : index, 5 : index], kernel_gemm = 174 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%655, %c28, %c3, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%652, %c27, %c4, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%653, %c27, %c2, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %656 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg95, %656) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %657 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg22, %657) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %658 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%655, %658) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %659 = call @kernel_gemm(%656, %657, %658) {adf.kernel, "col, row" = [28 : index, 3 : index], ivs = [3 : index, 3 : index, 5 : index], kernel_gemm = 175 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%659, %c29, %c3, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%656, %c28, %c4, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%657, %c28, %c2, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%659, %arg99) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %660 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg92, %660) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %661 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg24, %661) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %662 = call @kernel_gemm0(%660, %661) {adf.kernel, "col, row" = [25 : index, 4 : index], ivs = [0 : index, 4 : index, 5 : index], kernel = 0 : index, kernel_gemm0 = 176 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%662, %c25, %c4, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%660, %c25, %c5, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%661, %c25, %c3, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %663 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg93, %663) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %664 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg25, %664) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %665 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%662, %665) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %666 = call @kernel_gemm(%663, %664, %665) {adf.kernel, "col, row" = [26 : index, 4 : index], ivs = [1 : index, 4 : index, 5 : index], kernel_gemm = 177 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%666, %c26, %c4, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%663, %c26, %c5, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%664, %c26, %c3, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %667 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg94, %667) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %668 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg26, %668) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %669 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%666, %669) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %670 = call @kernel_gemm(%667, %668, %669) {adf.kernel, "col, row" = [27 : index, 4 : index], ivs = [2 : index, 4 : index, 5 : index], kernel_gemm = 178 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%670, %c27, %c4, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%667, %c27, %c5, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%668, %c27, %c3, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %671 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg95, %671) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %672 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg27, %672) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %673 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%670, %673) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %674 = call @kernel_gemm(%671, %672, %673) {adf.kernel, "col, row" = [28 : index, 4 : index], ivs = [3 : index, 4 : index, 5 : index], kernel_gemm = 179 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%674, %c28, %c4, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%671, %c28, %c5, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%672, %c28, %c3, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%674, %arg100) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %675 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg92, %675) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %676 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg29, %676) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %677 = call @kernel_gemm0(%675, %676) {adf.kernel, "col, row" = [25 : index, 5 : index], ivs = [0 : index, 5 : index, 5 : index], kernel = 0 : index, kernel_gemm0 = 180 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%677, %c26, %c5, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%675, %c25, %c6, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%676, %c25, %c4, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %678 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg93, %678) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %679 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg30, %679) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %680 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%677, %680) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %681 = call @kernel_gemm(%678, %679, %680) {adf.kernel, "col, row" = [26 : index, 5 : index], ivs = [1 : index, 5 : index, 5 : index], kernel_gemm = 181 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%681, %c27, %c5, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%678, %c26, %c6, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%679, %c26, %c4, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %682 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg94, %682) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %683 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg31, %683) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %684 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%681, %684) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %685 = call @kernel_gemm(%682, %683, %684) {adf.kernel, "col, row" = [27 : index, 5 : index], ivs = [2 : index, 5 : index, 5 : index], kernel_gemm = 182 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%685, %c28, %c5, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%682, %c27, %c6, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%683, %c27, %c4, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %686 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg95, %686) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %687 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg32, %687) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %688 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%685, %688) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %689 = call @kernel_gemm(%686, %687, %688) {adf.kernel, "col, row" = [28 : index, 5 : index], ivs = [3 : index, 5 : index, 5 : index], kernel_gemm = 183 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%689, %c29, %c5, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%686, %c28, %c6, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%687, %c28, %c4, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%689, %arg101) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %690 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg92, %690) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %691 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg34, %691) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %692 = call @kernel_gemm0(%690, %691) {adf.kernel, "col, row" = [25 : index, 6 : index], ivs = [0 : index, 6 : index, 5 : index], kernel = 0 : index, kernel_gemm0 = 184 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%692, %c25, %c6, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%690, %c25, %c7, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%691, %c25, %c5, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %693 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg93, %693) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %694 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg35, %694) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %695 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%692, %695) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %696 = call @kernel_gemm(%693, %694, %695) {adf.kernel, "col, row" = [26 : index, 6 : index], ivs = [1 : index, 6 : index, 5 : index], kernel_gemm = 185 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%696, %c26, %c6, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%693, %c26, %c7, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%694, %c26, %c5, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %697 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg94, %697) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %698 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg36, %698) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %699 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%696, %699) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %700 = call @kernel_gemm(%697, %698, %699) {adf.kernel, "col, row" = [27 : index, 6 : index], ivs = [2 : index, 6 : index, 5 : index], kernel_gemm = 186 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%700, %c27, %c6, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%697, %c27, %c7, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%698, %c27, %c5, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %701 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg95, %701) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %702 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg37, %702) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %703 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%700, %703) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %704 = call @kernel_gemm(%701, %702, %703) {adf.kernel, "col, row" = [28 : index, 6 : index], ivs = [3 : index, 6 : index, 5 : index], kernel_gemm = 187 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%704, %c28, %c6, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%701, %c28, %c7, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%702, %c28, %c5, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%704, %arg102) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %705 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg92, %705) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %706 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg39, %706) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %707 = call @kernel_gemm0(%705, %706) {adf.kernel, "col, row" = [25 : index, 7 : index], ivs = [0 : index, 7 : index, 5 : index], kernel = 0 : index, kernel_gemm0 = 188 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%707, %c26, %c7, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%705, %c25, %c7, %c4096, %c12288) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%706, %c25, %c6, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %708 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg93, %708) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %709 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg40, %709) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %710 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%707, %710) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %711 = call @kernel_gemm(%708, %709, %710) {adf.kernel, "col, row" = [26 : index, 7 : index], ivs = [1 : index, 7 : index, 5 : index], kernel_gemm = 189 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%711, %c27, %c7, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%708, %c26, %c7, %c4096, %c12288) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%709, %c26, %c6, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %712 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg94, %712) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %713 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg41, %713) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %714 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%711, %714) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %715 = call @kernel_gemm(%712, %713, %714) {adf.kernel, "col, row" = [27 : index, 7 : index], ivs = [2 : index, 7 : index, 5 : index], kernel_gemm = 190 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%715, %c28, %c7, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%712, %c27, %c7, %c4096, %c12288) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%713, %c27, %c6, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %716 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg95, %716) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %717 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg42, %717) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %718 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%715, %718) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %719 = call @kernel_gemm(%716, %717, %718) {adf.kernel, "col, row" = [28 : index, 7 : index], ivs = [3 : index, 7 : index, 5 : index], kernel_gemm = 191 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%719, %c29, %c7, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%716, %c28, %c7, %c4096, %c12288) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%717, %c28, %c6, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%719, %arg103) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %720 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg104, %720) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %721 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg1, %721) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %722 = call @kernel_gemm0(%720, %721) {adf.kernel, "col, row" = [29 : index, 0 : index], ivs = [0 : index, 0 : index, 6 : index], kernel = 0 : index, kernel_gemm0 = 192 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%722, %c29, %c0, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%720, %c28, %c0, %c4096, %c12288) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%721, %c29, %c1, %c16384, %c24576) : (memref<64x64xi8, 2>, index, index, index, index)
    %723 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg105, %723) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %724 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg3, %724) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %725 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%722, %725) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %726 = call @kernel_gemm(%723, %724, %725) {adf.kernel, "col, row" = [30 : index, 0 : index], ivs = [1 : index, 0 : index, 6 : index], kernel_gemm = 193 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%726, %c30, %c0, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%723, %c29, %c0, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%724, %c30, %c1, %c0, %c8192) : (memref<64x64xi8, 2>, index, index, index, index)
    %727 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg106, %727) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %728 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg5, %728) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %729 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%726, %729) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %730 = call @kernel_gemm(%727, %728, %729) {adf.kernel, "col, row" = [31 : index, 0 : index], ivs = [2 : index, 0 : index, 6 : index], kernel_gemm = 194 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%730, %c31, %c0, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%727, %c30, %c0, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%728, %c31, %c1, %c0, %c8192) : (memref<64x64xi8, 2>, index, index, index, index)
    %731 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg107, %731) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %732 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg7, %732) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %733 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%730, %733) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %734 = call @kernel_gemm(%731, %732, %733) {adf.kernel, "col, row" = [32 : index, 0 : index], ivs = [3 : index, 0 : index, 6 : index], kernel_gemm = 195 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%734, %c32, %c0, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%731, %c31, %c0, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%732, %c32, %c1, %c0, %c8192) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%734, %arg108) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %735 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg104, %735) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %736 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg9, %736) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %737 = call @kernel_gemm0(%735, %736) {adf.kernel, "col, row" = [29 : index, 1 : index], ivs = [0 : index, 1 : index, 6 : index], kernel = 0 : index, kernel_gemm0 = 196 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%737, %c30, %c1, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%735, %c29, %c2, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%736, %c29, %c0, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %738 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg105, %738) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %739 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg10, %739) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %740 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%737, %740) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %741 = call @kernel_gemm(%738, %739, %740) {adf.kernel, "col, row" = [30 : index, 1 : index], ivs = [1 : index, 1 : index, 6 : index], kernel_gemm = 197 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%741, %c31, %c1, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%738, %c30, %c2, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%739, %c30, %c0, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %742 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg106, %742) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %743 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg11, %743) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %744 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%741, %744) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %745 = call @kernel_gemm(%742, %743, %744) {adf.kernel, "col, row" = [31 : index, 1 : index], ivs = [2 : index, 1 : index, 6 : index], kernel_gemm = 198 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%745, %c32, %c1, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%742, %c31, %c2, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%743, %c31, %c0, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %746 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg107, %746) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %747 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg12, %747) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %748 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%745, %748) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %749 = call @kernel_gemm(%746, %747, %748) {adf.kernel, "col, row" = [32 : index, 1 : index], ivs = [3 : index, 1 : index, 6 : index], kernel_gemm = 199 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%749, %c33, %c1, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%746, %c32, %c2, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%747, %c32, %c0, %c16384, %c24576) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%749, %arg109) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %750 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg104, %750) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %751 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg14, %751) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %752 = call @kernel_gemm0(%750, %751) {adf.kernel, "col, row" = [29 : index, 2 : index], ivs = [0 : index, 2 : index, 6 : index], kernel = 0 : index, kernel_gemm0 = 200 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%752, %c29, %c2, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%750, %c29, %c3, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%751, %c29, %c1, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %753 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg105, %753) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %754 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg15, %754) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %755 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%752, %755) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %756 = call @kernel_gemm(%753, %754, %755) {adf.kernel, "col, row" = [30 : index, 2 : index], ivs = [1 : index, 2 : index, 6 : index], kernel_gemm = 201 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%756, %c30, %c2, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%753, %c30, %c3, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%754, %c30, %c1, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %757 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg106, %757) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %758 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg16, %758) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %759 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%756, %759) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %760 = call @kernel_gemm(%757, %758, %759) {adf.kernel, "col, row" = [31 : index, 2 : index], ivs = [2 : index, 2 : index, 6 : index], kernel_gemm = 202 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%760, %c31, %c2, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%757, %c31, %c3, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%758, %c31, %c1, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %761 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg107, %761) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %762 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg17, %762) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %763 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%760, %763) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %764 = call @kernel_gemm(%761, %762, %763) {adf.kernel, "col, row" = [32 : index, 2 : index], ivs = [3 : index, 2 : index, 6 : index], kernel_gemm = 203 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%764, %c32, %c2, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%761, %c32, %c3, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%762, %c32, %c1, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%764, %arg110) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %765 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg104, %765) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %766 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg19, %766) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %767 = call @kernel_gemm0(%765, %766) {adf.kernel, "col, row" = [29 : index, 3 : index], ivs = [0 : index, 3 : index, 6 : index], kernel = 0 : index, kernel_gemm0 = 204 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%767, %c30, %c3, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%765, %c29, %c4, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%766, %c29, %c2, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %768 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg105, %768) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %769 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg20, %769) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %770 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%767, %770) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %771 = call @kernel_gemm(%768, %769, %770) {adf.kernel, "col, row" = [30 : index, 3 : index], ivs = [1 : index, 3 : index, 6 : index], kernel_gemm = 205 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%771, %c31, %c3, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%768, %c30, %c4, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%769, %c30, %c2, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %772 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg106, %772) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %773 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg21, %773) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %774 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%771, %774) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %775 = call @kernel_gemm(%772, %773, %774) {adf.kernel, "col, row" = [31 : index, 3 : index], ivs = [2 : index, 3 : index, 6 : index], kernel_gemm = 206 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%775, %c32, %c3, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%772, %c31, %c4, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%773, %c31, %c2, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %776 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg107, %776) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %777 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg22, %777) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %778 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%775, %778) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %779 = call @kernel_gemm(%776, %777, %778) {adf.kernel, "col, row" = [32 : index, 3 : index], ivs = [3 : index, 3 : index, 6 : index], kernel_gemm = 207 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%779, %c33, %c3, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%776, %c32, %c4, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%777, %c32, %c2, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%779, %arg111) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %780 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg104, %780) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %781 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg24, %781) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %782 = call @kernel_gemm0(%780, %781) {adf.kernel, "col, row" = [29 : index, 4 : index], ivs = [0 : index, 4 : index, 6 : index], kernel = 0 : index, kernel_gemm0 = 208 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%782, %c29, %c4, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%780, %c29, %c5, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%781, %c29, %c3, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %783 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg105, %783) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %784 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg25, %784) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %785 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%782, %785) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %786 = call @kernel_gemm(%783, %784, %785) {adf.kernel, "col, row" = [30 : index, 4 : index], ivs = [1 : index, 4 : index, 6 : index], kernel_gemm = 209 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%786, %c30, %c4, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%783, %c30, %c5, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%784, %c30, %c3, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %787 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg106, %787) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %788 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg26, %788) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %789 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%786, %789) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %790 = call @kernel_gemm(%787, %788, %789) {adf.kernel, "col, row" = [31 : index, 4 : index], ivs = [2 : index, 4 : index, 6 : index], kernel_gemm = 210 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%790, %c31, %c4, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%787, %c31, %c5, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%788, %c31, %c3, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %791 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg107, %791) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %792 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg27, %792) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %793 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%790, %793) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %794 = call @kernel_gemm(%791, %792, %793) {adf.kernel, "col, row" = [32 : index, 4 : index], ivs = [3 : index, 4 : index, 6 : index], kernel_gemm = 211 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%794, %c32, %c4, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%791, %c32, %c5, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%792, %c32, %c3, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%794, %arg112) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %795 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg104, %795) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %796 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg29, %796) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %797 = call @kernel_gemm0(%795, %796) {adf.kernel, "col, row" = [29 : index, 5 : index], ivs = [0 : index, 5 : index, 6 : index], kernel = 0 : index, kernel_gemm0 = 212 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%797, %c30, %c5, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%795, %c29, %c6, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%796, %c29, %c4, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %798 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg105, %798) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %799 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg30, %799) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %800 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%797, %800) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %801 = call @kernel_gemm(%798, %799, %800) {adf.kernel, "col, row" = [30 : index, 5 : index], ivs = [1 : index, 5 : index, 6 : index], kernel_gemm = 213 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%801, %c31, %c5, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%798, %c30, %c6, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%799, %c30, %c4, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %802 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg106, %802) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %803 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg31, %803) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %804 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%801, %804) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %805 = call @kernel_gemm(%802, %803, %804) {adf.kernel, "col, row" = [31 : index, 5 : index], ivs = [2 : index, 5 : index, 6 : index], kernel_gemm = 214 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%805, %c32, %c5, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%802, %c31, %c6, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%803, %c31, %c4, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %806 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg107, %806) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %807 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg32, %807) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %808 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%805, %808) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %809 = call @kernel_gemm(%806, %807, %808) {adf.kernel, "col, row" = [32 : index, 5 : index], ivs = [3 : index, 5 : index, 6 : index], kernel_gemm = 215 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%809, %c33, %c5, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%806, %c32, %c6, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%807, %c32, %c4, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%809, %arg113) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %810 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg104, %810) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %811 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg34, %811) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %812 = call @kernel_gemm0(%810, %811) {adf.kernel, "col, row" = [29 : index, 6 : index], ivs = [0 : index, 6 : index, 6 : index], kernel = 0 : index, kernel_gemm0 = 216 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%812, %c29, %c6, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%810, %c29, %c7, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%811, %c29, %c5, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %813 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg105, %813) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %814 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg35, %814) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %815 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%812, %815) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %816 = call @kernel_gemm(%813, %814, %815) {adf.kernel, "col, row" = [30 : index, 6 : index], ivs = [1 : index, 6 : index, 6 : index], kernel_gemm = 217 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%816, %c30, %c6, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%813, %c30, %c7, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%814, %c30, %c5, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %817 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg106, %817) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %818 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg36, %818) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %819 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%816, %819) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %820 = call @kernel_gemm(%817, %818, %819) {adf.kernel, "col, row" = [31 : index, 6 : index], ivs = [2 : index, 6 : index, 6 : index], kernel_gemm = 218 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%820, %c31, %c6, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%817, %c31, %c7, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%818, %c31, %c5, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %821 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg107, %821) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %822 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg37, %822) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %823 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%820, %823) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %824 = call @kernel_gemm(%821, %822, %823) {adf.kernel, "col, row" = [32 : index, 6 : index], ivs = [3 : index, 6 : index, 6 : index], kernel_gemm = 219 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%824, %c32, %c6, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%821, %c32, %c7, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%822, %c32, %c5, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%824, %arg114) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %825 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg104, %825) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %826 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg39, %826) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %827 = call @kernel_gemm0(%825, %826) {adf.kernel, "col, row" = [29 : index, 7 : index], ivs = [0 : index, 7 : index, 6 : index], kernel = 0 : index, kernel_gemm0 = 220 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%827, %c30, %c7, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%825, %c29, %c7, %c4096, %c12288) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%826, %c29, %c6, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %828 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg105, %828) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %829 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg40, %829) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %830 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%827, %830) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %831 = call @kernel_gemm(%828, %829, %830) {adf.kernel, "col, row" = [30 : index, 7 : index], ivs = [1 : index, 7 : index, 6 : index], kernel_gemm = 221 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%831, %c31, %c7, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%828, %c30, %c7, %c4096, %c12288) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%829, %c30, %c6, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %832 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg106, %832) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %833 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg41, %833) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %834 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%831, %834) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %835 = call @kernel_gemm(%832, %833, %834) {adf.kernel, "col, row" = [31 : index, 7 : index], ivs = [2 : index, 7 : index, 6 : index], kernel_gemm = 222 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%835, %c32, %c7, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%832, %c31, %c7, %c4096, %c12288) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%833, %c31, %c6, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %836 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg107, %836) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %837 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg42, %837) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %838 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%835, %838) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %839 = call @kernel_gemm(%836, %837, %838) {adf.kernel, "col, row" = [32 : index, 7 : index], ivs = [3 : index, 7 : index, 6 : index], kernel_gemm = 223 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%839, %c33, %c7, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%836, %c32, %c7, %c4096, %c12288) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%837, %c32, %c6, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%839, %arg115) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %840 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg116, %840) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %841 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg1, %841) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %842 = call @kernel_gemm0(%840, %841) {adf.kernel, "col, row" = [33 : index, 0 : index], ivs = [0 : index, 0 : index, 7 : index], kernel = 0 : index, kernel_gemm0 = 224 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%842, %c33, %c0, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%840, %c32, %c0, %c4096, %c12288) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%841, %c33, %c1, %c16384, %c24576) : (memref<64x64xi8, 2>, index, index, index, index)
    %843 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg117, %843) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %844 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg3, %844) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %845 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%842, %845) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %846 = call @kernel_gemm(%843, %844, %845) {adf.kernel, "col, row" = [34 : index, 0 : index], ivs = [1 : index, 0 : index, 7 : index], kernel_gemm = 225 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%846, %c34, %c0, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%843, %c33, %c0, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%844, %c34, %c1, %c0, %c8192) : (memref<64x64xi8, 2>, index, index, index, index)
    %847 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg118, %847) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %848 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg5, %848) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %849 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%846, %849) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %850 = call @kernel_gemm(%847, %848, %849) {adf.kernel, "col, row" = [35 : index, 0 : index], ivs = [2 : index, 0 : index, 7 : index], kernel_gemm = 226 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%850, %c35, %c0, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%847, %c34, %c0, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%848, %c35, %c1, %c0, %c8192) : (memref<64x64xi8, 2>, index, index, index, index)
    %851 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg119, %851) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %852 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg7, %852) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %853 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%850, %853) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %854 = call @kernel_gemm(%851, %852, %853) {adf.kernel, "col, row" = [36 : index, 0 : index], ivs = [3 : index, 0 : index, 7 : index], kernel_gemm = 227 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%854, %c36, %c0, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%851, %c35, %c0, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%852, %c36, %c1, %c0, %c8192) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%854, %arg120) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %855 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg116, %855) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %856 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg9, %856) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %857 = call @kernel_gemm0(%855, %856) {adf.kernel, "col, row" = [33 : index, 1 : index], ivs = [0 : index, 1 : index, 7 : index], kernel = 0 : index, kernel_gemm0 = 228 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%857, %c34, %c1, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%855, %c33, %c2, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%856, %c33, %c0, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %858 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg117, %858) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %859 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg10, %859) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %860 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%857, %860) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %861 = call @kernel_gemm(%858, %859, %860) {adf.kernel, "col, row" = [34 : index, 1 : index], ivs = [1 : index, 1 : index, 7 : index], kernel_gemm = 229 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%861, %c35, %c1, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%858, %c34, %c2, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%859, %c34, %c0, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %862 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg118, %862) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %863 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg11, %863) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %864 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%861, %864) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %865 = call @kernel_gemm(%862, %863, %864) {adf.kernel, "col, row" = [35 : index, 1 : index], ivs = [2 : index, 1 : index, 7 : index], kernel_gemm = 230 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%865, %c36, %c1, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%862, %c35, %c2, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%863, %c35, %c0, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %866 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg119, %866) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %867 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg12, %867) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %868 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%865, %868) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %869 = call @kernel_gemm(%866, %867, %868) {adf.kernel, "col, row" = [36 : index, 1 : index], ivs = [3 : index, 1 : index, 7 : index], kernel_gemm = 231 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%869, %c37, %c1, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%866, %c36, %c2, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%867, %c36, %c0, %c16384, %c24576) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%869, %arg121) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %870 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg116, %870) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %871 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg14, %871) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %872 = call @kernel_gemm0(%870, %871) {adf.kernel, "col, row" = [33 : index, 2 : index], ivs = [0 : index, 2 : index, 7 : index], kernel = 0 : index, kernel_gemm0 = 232 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%872, %c33, %c2, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%870, %c33, %c3, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%871, %c33, %c1, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %873 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg117, %873) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %874 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg15, %874) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %875 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%872, %875) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %876 = call @kernel_gemm(%873, %874, %875) {adf.kernel, "col, row" = [34 : index, 2 : index], ivs = [1 : index, 2 : index, 7 : index], kernel_gemm = 233 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%876, %c34, %c2, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%873, %c34, %c3, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%874, %c34, %c1, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %877 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg118, %877) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %878 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg16, %878) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %879 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%876, %879) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %880 = call @kernel_gemm(%877, %878, %879) {adf.kernel, "col, row" = [35 : index, 2 : index], ivs = [2 : index, 2 : index, 7 : index], kernel_gemm = 234 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%880, %c35, %c2, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%877, %c35, %c3, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%878, %c35, %c1, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %881 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg119, %881) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %882 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg17, %882) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %883 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%880, %883) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %884 = call @kernel_gemm(%881, %882, %883) {adf.kernel, "col, row" = [36 : index, 2 : index], ivs = [3 : index, 2 : index, 7 : index], kernel_gemm = 235 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%884, %c36, %c2, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%881, %c36, %c3, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%882, %c36, %c1, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%884, %arg122) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %885 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg116, %885) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %886 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg19, %886) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %887 = call @kernel_gemm0(%885, %886) {adf.kernel, "col, row" = [33 : index, 3 : index], ivs = [0 : index, 3 : index, 7 : index], kernel = 0 : index, kernel_gemm0 = 236 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%887, %c34, %c3, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%885, %c33, %c4, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%886, %c33, %c2, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %888 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg117, %888) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %889 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg20, %889) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %890 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%887, %890) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %891 = call @kernel_gemm(%888, %889, %890) {adf.kernel, "col, row" = [34 : index, 3 : index], ivs = [1 : index, 3 : index, 7 : index], kernel_gemm = 237 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%891, %c35, %c3, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%888, %c34, %c4, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%889, %c34, %c2, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %892 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg118, %892) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %893 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg21, %893) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %894 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%891, %894) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %895 = call @kernel_gemm(%892, %893, %894) {adf.kernel, "col, row" = [35 : index, 3 : index], ivs = [2 : index, 3 : index, 7 : index], kernel_gemm = 238 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%895, %c36, %c3, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%892, %c35, %c4, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%893, %c35, %c2, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %896 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg119, %896) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %897 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg22, %897) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %898 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%895, %898) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %899 = call @kernel_gemm(%896, %897, %898) {adf.kernel, "col, row" = [36 : index, 3 : index], ivs = [3 : index, 3 : index, 7 : index], kernel_gemm = 239 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%899, %c37, %c3, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%896, %c36, %c4, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%897, %c36, %c2, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%899, %arg123) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %900 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg116, %900) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %901 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg24, %901) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %902 = call @kernel_gemm0(%900, %901) {adf.kernel, "col, row" = [33 : index, 4 : index], ivs = [0 : index, 4 : index, 7 : index], kernel = 0 : index, kernel_gemm0 = 240 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%902, %c33, %c4, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%900, %c33, %c5, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%901, %c33, %c3, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %903 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg117, %903) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %904 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg25, %904) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %905 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%902, %905) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %906 = call @kernel_gemm(%903, %904, %905) {adf.kernel, "col, row" = [34 : index, 4 : index], ivs = [1 : index, 4 : index, 7 : index], kernel_gemm = 241 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%906, %c34, %c4, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%903, %c34, %c5, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%904, %c34, %c3, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %907 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg118, %907) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %908 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg26, %908) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %909 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%906, %909) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %910 = call @kernel_gemm(%907, %908, %909) {adf.kernel, "col, row" = [35 : index, 4 : index], ivs = [2 : index, 4 : index, 7 : index], kernel_gemm = 242 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%910, %c35, %c4, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%907, %c35, %c5, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%908, %c35, %c3, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %911 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg119, %911) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %912 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg27, %912) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %913 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%910, %913) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %914 = call @kernel_gemm(%911, %912, %913) {adf.kernel, "col, row" = [36 : index, 4 : index], ivs = [3 : index, 4 : index, 7 : index], kernel_gemm = 243 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%914, %c36, %c4, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%911, %c36, %c5, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%912, %c36, %c3, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%914, %arg124) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %915 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg116, %915) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %916 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg29, %916) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %917 = call @kernel_gemm0(%915, %916) {adf.kernel, "col, row" = [33 : index, 5 : index], ivs = [0 : index, 5 : index, 7 : index], kernel = 0 : index, kernel_gemm0 = 244 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%917, %c34, %c5, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%915, %c33, %c6, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%916, %c33, %c4, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %918 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg117, %918) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %919 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg30, %919) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %920 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%917, %920) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %921 = call @kernel_gemm(%918, %919, %920) {adf.kernel, "col, row" = [34 : index, 5 : index], ivs = [1 : index, 5 : index, 7 : index], kernel_gemm = 245 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%921, %c35, %c5, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%918, %c34, %c6, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%919, %c34, %c4, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %922 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg118, %922) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %923 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg31, %923) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %924 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%921, %924) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %925 = call @kernel_gemm(%922, %923, %924) {adf.kernel, "col, row" = [35 : index, 5 : index], ivs = [2 : index, 5 : index, 7 : index], kernel_gemm = 246 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%925, %c36, %c5, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%922, %c35, %c6, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%923, %c35, %c4, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %926 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg119, %926) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %927 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg32, %927) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %928 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%925, %928) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %929 = call @kernel_gemm(%926, %927, %928) {adf.kernel, "col, row" = [36 : index, 5 : index], ivs = [3 : index, 5 : index, 7 : index], kernel_gemm = 247 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%929, %c37, %c5, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%926, %c36, %c6, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%927, %c36, %c4, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%929, %arg125) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %930 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg116, %930) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %931 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg34, %931) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %932 = call @kernel_gemm0(%930, %931) {adf.kernel, "col, row" = [33 : index, 6 : index], ivs = [0 : index, 6 : index, 7 : index], kernel = 0 : index, kernel_gemm0 = 248 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%932, %c33, %c6, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%930, %c33, %c7, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%931, %c33, %c5, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %933 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg117, %933) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %934 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg35, %934) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %935 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%932, %935) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %936 = call @kernel_gemm(%933, %934, %935) {adf.kernel, "col, row" = [34 : index, 6 : index], ivs = [1 : index, 6 : index, 7 : index], kernel_gemm = 249 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%936, %c34, %c6, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%933, %c34, %c7, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%934, %c34, %c5, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %937 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg118, %937) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %938 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg36, %938) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %939 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%936, %939) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %940 = call @kernel_gemm(%937, %938, %939) {adf.kernel, "col, row" = [35 : index, 6 : index], ivs = [2 : index, 6 : index, 7 : index], kernel_gemm = 250 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%940, %c35, %c6, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%937, %c35, %c7, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%938, %c35, %c5, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %941 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg119, %941) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %942 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg37, %942) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %943 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%940, %943) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %944 = call @kernel_gemm(%941, %942, %943) {adf.kernel, "col, row" = [36 : index, 6 : index], ivs = [3 : index, 6 : index, 7 : index], kernel_gemm = 251 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%944, %c36, %c6, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%941, %c36, %c7, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%942, %c36, %c5, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%944, %arg126) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %945 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg116, %945) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %946 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg39, %946) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %947 = call @kernel_gemm0(%945, %946) {adf.kernel, "col, row" = [33 : index, 7 : index], ivs = [0 : index, 7 : index, 7 : index], kernel = 0 : index, kernel_gemm0 = 252 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%947, %c34, %c7, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%945, %c33, %c7, %c4096, %c12288) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%946, %c33, %c6, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %948 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg117, %948) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %949 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg40, %949) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %950 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%947, %950) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %951 = call @kernel_gemm(%948, %949, %950) {adf.kernel, "col, row" = [34 : index, 7 : index], ivs = [1 : index, 7 : index, 7 : index], kernel_gemm = 253 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%951, %c35, %c7, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%948, %c34, %c7, %c4096, %c12288) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%949, %c34, %c6, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %952 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg118, %952) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %953 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg41, %953) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %954 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%951, %954) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %955 = call @kernel_gemm(%952, %953, %954) {adf.kernel, "col, row" = [35 : index, 7 : index], ivs = [2 : index, 7 : index, 7 : index], kernel_gemm = 254 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%955, %c36, %c7, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%952, %c35, %c7, %c4096, %c12288) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%953, %c35, %c6, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %956 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg119, %956) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %957 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg42, %957) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %958 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%955, %958) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %959 = call @kernel_gemm(%956, %957, %958) {adf.kernel, "col, row" = [36 : index, 7 : index], ivs = [3 : index, 7 : index, 7 : index], kernel_gemm = 255 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%959, %c37, %c7, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%956, %c36, %c7, %c4096, %c12288) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%957, %c36, %c6, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%959, %arg127) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %960 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg128, %960) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %961 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg1, %961) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %962 = call @kernel_gemm0(%960, %961) {adf.kernel, "col, row" = [37 : index, 0 : index], ivs = [0 : index, 0 : index, 8 : index], kernel = 0 : index, kernel_gemm0 = 256 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%962, %c37, %c0, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%960, %c36, %c0, %c4096, %c12288) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%961, %c37, %c1, %c16384, %c24576) : (memref<64x64xi8, 2>, index, index, index, index)
    %963 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg129, %963) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %964 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg3, %964) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %965 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%962, %965) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %966 = call @kernel_gemm(%963, %964, %965) {adf.kernel, "col, row" = [38 : index, 0 : index], ivs = [1 : index, 0 : index, 8 : index], kernel_gemm = 257 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%966, %c38, %c0, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%963, %c37, %c0, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%964, %c38, %c1, %c0, %c8192) : (memref<64x64xi8, 2>, index, index, index, index)
    %967 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg130, %967) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %968 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg5, %968) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %969 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%966, %969) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %970 = call @kernel_gemm(%967, %968, %969) {adf.kernel, "col, row" = [39 : index, 0 : index], ivs = [2 : index, 0 : index, 8 : index], kernel_gemm = 258 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%970, %c39, %c0, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%967, %c38, %c0, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%968, %c39, %c1, %c0, %c8192) : (memref<64x64xi8, 2>, index, index, index, index)
    %971 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg131, %971) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %972 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg7, %972) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %973 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%970, %973) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %974 = call @kernel_gemm(%971, %972, %973) {adf.kernel, "col, row" = [40 : index, 0 : index], ivs = [3 : index, 0 : index, 8 : index], kernel_gemm = 259 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%974, %c40, %c0, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%971, %c39, %c0, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%972, %c40, %c1, %c0, %c8192) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%974, %arg132) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %975 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg128, %975) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %976 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg9, %976) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %977 = call @kernel_gemm0(%975, %976) {adf.kernel, "col, row" = [37 : index, 1 : index], ivs = [0 : index, 1 : index, 8 : index], kernel = 0 : index, kernel_gemm0 = 260 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%977, %c38, %c1, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%975, %c37, %c2, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%976, %c37, %c0, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %978 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg129, %978) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %979 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg10, %979) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %980 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%977, %980) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %981 = call @kernel_gemm(%978, %979, %980) {adf.kernel, "col, row" = [38 : index, 1 : index], ivs = [1 : index, 1 : index, 8 : index], kernel_gemm = 261 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%981, %c39, %c1, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%978, %c38, %c2, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%979, %c38, %c0, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %982 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg130, %982) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %983 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg11, %983) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %984 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%981, %984) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %985 = call @kernel_gemm(%982, %983, %984) {adf.kernel, "col, row" = [39 : index, 1 : index], ivs = [2 : index, 1 : index, 8 : index], kernel_gemm = 262 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%985, %c40, %c1, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%982, %c39, %c2, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%983, %c39, %c0, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %986 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg131, %986) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %987 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg12, %987) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %988 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%985, %988) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %989 = call @kernel_gemm(%986, %987, %988) {adf.kernel, "col, row" = [40 : index, 1 : index], ivs = [3 : index, 1 : index, 8 : index], kernel_gemm = 263 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%989, %c41, %c1, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%986, %c40, %c2, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%987, %c40, %c0, %c16384, %c24576) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%989, %arg133) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %990 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg128, %990) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %991 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg14, %991) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %992 = call @kernel_gemm0(%990, %991) {adf.kernel, "col, row" = [37 : index, 2 : index], ivs = [0 : index, 2 : index, 8 : index], kernel = 0 : index, kernel_gemm0 = 264 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%992, %c37, %c2, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%990, %c37, %c3, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%991, %c37, %c1, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %993 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg129, %993) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %994 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg15, %994) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %995 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%992, %995) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %996 = call @kernel_gemm(%993, %994, %995) {adf.kernel, "col, row" = [38 : index, 2 : index], ivs = [1 : index, 2 : index, 8 : index], kernel_gemm = 265 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%996, %c38, %c2, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%993, %c38, %c3, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%994, %c38, %c1, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %997 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg130, %997) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %998 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg16, %998) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %999 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%996, %999) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %1000 = call @kernel_gemm(%997, %998, %999) {adf.kernel, "col, row" = [39 : index, 2 : index], ivs = [2 : index, 2 : index, 8 : index], kernel_gemm = 266 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%1000, %c39, %c2, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%997, %c39, %c3, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%998, %c39, %c1, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %1001 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg131, %1001) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %1002 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg17, %1002) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %1003 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%1000, %1003) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %1004 = call @kernel_gemm(%1001, %1002, %1003) {adf.kernel, "col, row" = [40 : index, 2 : index], ivs = [3 : index, 2 : index, 8 : index], kernel_gemm = 267 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%1004, %c40, %c2, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1001, %c40, %c3, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1002, %c40, %c1, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%1004, %arg134) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %1005 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg128, %1005) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %1006 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg19, %1006) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %1007 = call @kernel_gemm0(%1005, %1006) {adf.kernel, "col, row" = [37 : index, 3 : index], ivs = [0 : index, 3 : index, 8 : index], kernel = 0 : index, kernel_gemm0 = 268 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%1007, %c38, %c3, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1005, %c37, %c4, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1006, %c37, %c2, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %1008 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg129, %1008) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %1009 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg20, %1009) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %1010 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%1007, %1010) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %1011 = call @kernel_gemm(%1008, %1009, %1010) {adf.kernel, "col, row" = [38 : index, 3 : index], ivs = [1 : index, 3 : index, 8 : index], kernel_gemm = 269 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%1011, %c39, %c3, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1008, %c38, %c4, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1009, %c38, %c2, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %1012 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg130, %1012) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %1013 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg21, %1013) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %1014 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%1011, %1014) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %1015 = call @kernel_gemm(%1012, %1013, %1014) {adf.kernel, "col, row" = [39 : index, 3 : index], ivs = [2 : index, 3 : index, 8 : index], kernel_gemm = 270 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%1015, %c40, %c3, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1012, %c39, %c4, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1013, %c39, %c2, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %1016 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg131, %1016) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %1017 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg22, %1017) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %1018 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%1015, %1018) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %1019 = call @kernel_gemm(%1016, %1017, %1018) {adf.kernel, "col, row" = [40 : index, 3 : index], ivs = [3 : index, 3 : index, 8 : index], kernel_gemm = 271 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%1019, %c41, %c3, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1016, %c40, %c4, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1017, %c40, %c2, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%1019, %arg135) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %1020 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg128, %1020) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %1021 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg24, %1021) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %1022 = call @kernel_gemm0(%1020, %1021) {adf.kernel, "col, row" = [37 : index, 4 : index], ivs = [0 : index, 4 : index, 8 : index], kernel = 0 : index, kernel_gemm0 = 272 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%1022, %c37, %c4, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1020, %c37, %c5, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1021, %c37, %c3, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %1023 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg129, %1023) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %1024 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg25, %1024) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %1025 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%1022, %1025) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %1026 = call @kernel_gemm(%1023, %1024, %1025) {adf.kernel, "col, row" = [38 : index, 4 : index], ivs = [1 : index, 4 : index, 8 : index], kernel_gemm = 273 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%1026, %c38, %c4, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1023, %c38, %c5, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1024, %c38, %c3, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %1027 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg130, %1027) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %1028 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg26, %1028) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %1029 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%1026, %1029) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %1030 = call @kernel_gemm(%1027, %1028, %1029) {adf.kernel, "col, row" = [39 : index, 4 : index], ivs = [2 : index, 4 : index, 8 : index], kernel_gemm = 274 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%1030, %c39, %c4, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1027, %c39, %c5, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1028, %c39, %c3, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %1031 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg131, %1031) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %1032 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg27, %1032) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %1033 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%1030, %1033) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %1034 = call @kernel_gemm(%1031, %1032, %1033) {adf.kernel, "col, row" = [40 : index, 4 : index], ivs = [3 : index, 4 : index, 8 : index], kernel_gemm = 275 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%1034, %c40, %c4, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1031, %c40, %c5, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1032, %c40, %c3, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%1034, %arg136) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %1035 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg128, %1035) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %1036 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg29, %1036) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %1037 = call @kernel_gemm0(%1035, %1036) {adf.kernel, "col, row" = [37 : index, 5 : index], ivs = [0 : index, 5 : index, 8 : index], kernel = 0 : index, kernel_gemm0 = 276 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%1037, %c38, %c5, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1035, %c37, %c6, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1036, %c37, %c4, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %1038 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg129, %1038) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %1039 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg30, %1039) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %1040 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%1037, %1040) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %1041 = call @kernel_gemm(%1038, %1039, %1040) {adf.kernel, "col, row" = [38 : index, 5 : index], ivs = [1 : index, 5 : index, 8 : index], kernel_gemm = 277 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%1041, %c39, %c5, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1038, %c38, %c6, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1039, %c38, %c4, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %1042 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg130, %1042) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %1043 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg31, %1043) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %1044 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%1041, %1044) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %1045 = call @kernel_gemm(%1042, %1043, %1044) {adf.kernel, "col, row" = [39 : index, 5 : index], ivs = [2 : index, 5 : index, 8 : index], kernel_gemm = 278 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%1045, %c40, %c5, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1042, %c39, %c6, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1043, %c39, %c4, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %1046 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg131, %1046) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %1047 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg32, %1047) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %1048 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%1045, %1048) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %1049 = call @kernel_gemm(%1046, %1047, %1048) {adf.kernel, "col, row" = [40 : index, 5 : index], ivs = [3 : index, 5 : index, 8 : index], kernel_gemm = 279 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%1049, %c41, %c5, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1046, %c40, %c6, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1047, %c40, %c4, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%1049, %arg137) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %1050 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg128, %1050) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %1051 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg34, %1051) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %1052 = call @kernel_gemm0(%1050, %1051) {adf.kernel, "col, row" = [37 : index, 6 : index], ivs = [0 : index, 6 : index, 8 : index], kernel = 0 : index, kernel_gemm0 = 280 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%1052, %c37, %c6, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1050, %c37, %c7, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1051, %c37, %c5, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %1053 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg129, %1053) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %1054 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg35, %1054) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %1055 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%1052, %1055) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %1056 = call @kernel_gemm(%1053, %1054, %1055) {adf.kernel, "col, row" = [38 : index, 6 : index], ivs = [1 : index, 6 : index, 8 : index], kernel_gemm = 281 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%1056, %c38, %c6, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1053, %c38, %c7, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1054, %c38, %c5, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %1057 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg130, %1057) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %1058 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg36, %1058) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %1059 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%1056, %1059) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %1060 = call @kernel_gemm(%1057, %1058, %1059) {adf.kernel, "col, row" = [39 : index, 6 : index], ivs = [2 : index, 6 : index, 8 : index], kernel_gemm = 282 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%1060, %c39, %c6, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1057, %c39, %c7, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1058, %c39, %c5, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %1061 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg131, %1061) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %1062 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg37, %1062) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %1063 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%1060, %1063) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %1064 = call @kernel_gemm(%1061, %1062, %1063) {adf.kernel, "col, row" = [40 : index, 6 : index], ivs = [3 : index, 6 : index, 8 : index], kernel_gemm = 283 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%1064, %c40, %c6, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1061, %c40, %c7, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1062, %c40, %c5, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%1064, %arg138) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %1065 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg128, %1065) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %1066 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg39, %1066) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %1067 = call @kernel_gemm0(%1065, %1066) {adf.kernel, "col, row" = [37 : index, 7 : index], ivs = [0 : index, 7 : index, 8 : index], kernel = 0 : index, kernel_gemm0 = 284 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%1067, %c38, %c7, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1065, %c37, %c7, %c4096, %c12288) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1066, %c37, %c6, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %1068 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg129, %1068) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %1069 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg40, %1069) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %1070 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%1067, %1070) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %1071 = call @kernel_gemm(%1068, %1069, %1070) {adf.kernel, "col, row" = [38 : index, 7 : index], ivs = [1 : index, 7 : index, 8 : index], kernel_gemm = 285 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%1071, %c39, %c7, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1068, %c38, %c7, %c4096, %c12288) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1069, %c38, %c6, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %1072 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg130, %1072) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %1073 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg41, %1073) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %1074 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%1071, %1074) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %1075 = call @kernel_gemm(%1072, %1073, %1074) {adf.kernel, "col, row" = [39 : index, 7 : index], ivs = [2 : index, 7 : index, 8 : index], kernel_gemm = 286 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%1075, %c40, %c7, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1072, %c39, %c7, %c4096, %c12288) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1073, %c39, %c6, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %1076 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg131, %1076) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %1077 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg42, %1077) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %1078 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%1075, %1078) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %1079 = call @kernel_gemm(%1076, %1077, %1078) {adf.kernel, "col, row" = [40 : index, 7 : index], ivs = [3 : index, 7 : index, 8 : index], kernel_gemm = 287 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%1079, %c41, %c7, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1076, %c40, %c7, %c4096, %c12288) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1077, %c40, %c6, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%1079, %arg139) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %1080 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg140, %1080) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %1081 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg1, %1081) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %1082 = call @kernel_gemm0(%1080, %1081) {adf.kernel, "col, row" = [41 : index, 0 : index], ivs = [0 : index, 0 : index, 9 : index], kernel = 0 : index, kernel_gemm0 = 288 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%1082, %c41, %c0, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1080, %c40, %c0, %c4096, %c12288) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1081, %c41, %c1, %c16384, %c24576) : (memref<64x64xi8, 2>, index, index, index, index)
    %1083 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg141, %1083) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %1084 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg3, %1084) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %1085 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%1082, %1085) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %1086 = call @kernel_gemm(%1083, %1084, %1085) {adf.kernel, "col, row" = [42 : index, 0 : index], ivs = [1 : index, 0 : index, 9 : index], kernel_gemm = 289 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%1086, %c42, %c0, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1083, %c41, %c0, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1084, %c42, %c1, %c0, %c8192) : (memref<64x64xi8, 2>, index, index, index, index)
    %1087 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg142, %1087) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %1088 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg5, %1088) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %1089 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%1086, %1089) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %1090 = call @kernel_gemm(%1087, %1088, %1089) {adf.kernel, "col, row" = [43 : index, 0 : index], ivs = [2 : index, 0 : index, 9 : index], kernel_gemm = 290 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%1090, %c43, %c0, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1087, %c42, %c0, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1088, %c43, %c1, %c0, %c8192) : (memref<64x64xi8, 2>, index, index, index, index)
    %1091 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg143, %1091) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %1092 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg7, %1092) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %1093 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%1090, %1093) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %1094 = call @kernel_gemm(%1091, %1092, %1093) {adf.kernel, "col, row" = [44 : index, 0 : index], ivs = [3 : index, 0 : index, 9 : index], kernel_gemm = 291 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%1094, %c44, %c0, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1091, %c43, %c0, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1092, %c44, %c1, %c0, %c8192) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%1094, %arg144) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %1095 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg140, %1095) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %1096 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg9, %1096) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %1097 = call @kernel_gemm0(%1095, %1096) {adf.kernel, "col, row" = [41 : index, 1 : index], ivs = [0 : index, 1 : index, 9 : index], kernel = 0 : index, kernel_gemm0 = 292 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%1097, %c42, %c1, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1095, %c41, %c2, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1096, %c41, %c0, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %1098 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg141, %1098) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %1099 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg10, %1099) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %1100 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%1097, %1100) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %1101 = call @kernel_gemm(%1098, %1099, %1100) {adf.kernel, "col, row" = [42 : index, 1 : index], ivs = [1 : index, 1 : index, 9 : index], kernel_gemm = 293 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%1101, %c43, %c1, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1098, %c42, %c2, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1099, %c42, %c0, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %1102 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg142, %1102) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %1103 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg11, %1103) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %1104 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%1101, %1104) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %1105 = call @kernel_gemm(%1102, %1103, %1104) {adf.kernel, "col, row" = [43 : index, 1 : index], ivs = [2 : index, 1 : index, 9 : index], kernel_gemm = 294 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%1105, %c44, %c1, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1102, %c43, %c2, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1103, %c43, %c0, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %1106 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg143, %1106) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %1107 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg12, %1107) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %1108 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%1105, %1108) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %1109 = call @kernel_gemm(%1106, %1107, %1108) {adf.kernel, "col, row" = [44 : index, 1 : index], ivs = [3 : index, 1 : index, 9 : index], kernel_gemm = 295 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%1109, %c45, %c1, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1106, %c44, %c2, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1107, %c44, %c0, %c16384, %c24576) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%1109, %arg145) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %1110 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg140, %1110) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %1111 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg14, %1111) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %1112 = call @kernel_gemm0(%1110, %1111) {adf.kernel, "col, row" = [41 : index, 2 : index], ivs = [0 : index, 2 : index, 9 : index], kernel = 0 : index, kernel_gemm0 = 296 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%1112, %c41, %c2, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1110, %c41, %c3, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1111, %c41, %c1, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %1113 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg141, %1113) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %1114 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg15, %1114) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %1115 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%1112, %1115) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %1116 = call @kernel_gemm(%1113, %1114, %1115) {adf.kernel, "col, row" = [42 : index, 2 : index], ivs = [1 : index, 2 : index, 9 : index], kernel_gemm = 297 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%1116, %c42, %c2, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1113, %c42, %c3, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1114, %c42, %c1, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %1117 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg142, %1117) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %1118 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg16, %1118) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %1119 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%1116, %1119) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %1120 = call @kernel_gemm(%1117, %1118, %1119) {adf.kernel, "col, row" = [43 : index, 2 : index], ivs = [2 : index, 2 : index, 9 : index], kernel_gemm = 298 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%1120, %c43, %c2, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1117, %c43, %c3, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1118, %c43, %c1, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %1121 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg143, %1121) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %1122 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg17, %1122) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %1123 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%1120, %1123) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %1124 = call @kernel_gemm(%1121, %1122, %1123) {adf.kernel, "col, row" = [44 : index, 2 : index], ivs = [3 : index, 2 : index, 9 : index], kernel_gemm = 299 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%1124, %c44, %c2, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1121, %c44, %c3, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1122, %c44, %c1, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%1124, %arg146) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %1125 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg140, %1125) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %1126 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg19, %1126) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %1127 = call @kernel_gemm0(%1125, %1126) {adf.kernel, "col, row" = [41 : index, 3 : index], ivs = [0 : index, 3 : index, 9 : index], kernel = 0 : index, kernel_gemm0 = 300 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%1127, %c42, %c3, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1125, %c41, %c4, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1126, %c41, %c2, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %1128 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg141, %1128) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %1129 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg20, %1129) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %1130 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%1127, %1130) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %1131 = call @kernel_gemm(%1128, %1129, %1130) {adf.kernel, "col, row" = [42 : index, 3 : index], ivs = [1 : index, 3 : index, 9 : index], kernel_gemm = 301 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%1131, %c43, %c3, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1128, %c42, %c4, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1129, %c42, %c2, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %1132 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg142, %1132) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %1133 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg21, %1133) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %1134 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%1131, %1134) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %1135 = call @kernel_gemm(%1132, %1133, %1134) {adf.kernel, "col, row" = [43 : index, 3 : index], ivs = [2 : index, 3 : index, 9 : index], kernel_gemm = 302 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%1135, %c44, %c3, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1132, %c43, %c4, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1133, %c43, %c2, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %1136 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg143, %1136) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %1137 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg22, %1137) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %1138 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%1135, %1138) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %1139 = call @kernel_gemm(%1136, %1137, %1138) {adf.kernel, "col, row" = [44 : index, 3 : index], ivs = [3 : index, 3 : index, 9 : index], kernel_gemm = 303 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%1139, %c45, %c3, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1136, %c44, %c4, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1137, %c44, %c2, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%1139, %arg147) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %1140 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg140, %1140) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %1141 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg24, %1141) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %1142 = call @kernel_gemm0(%1140, %1141) {adf.kernel, "col, row" = [41 : index, 4 : index], ivs = [0 : index, 4 : index, 9 : index], kernel = 0 : index, kernel_gemm0 = 304 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%1142, %c41, %c4, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1140, %c41, %c5, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1141, %c41, %c3, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %1143 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg141, %1143) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %1144 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg25, %1144) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %1145 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%1142, %1145) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %1146 = call @kernel_gemm(%1143, %1144, %1145) {adf.kernel, "col, row" = [42 : index, 4 : index], ivs = [1 : index, 4 : index, 9 : index], kernel_gemm = 305 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%1146, %c42, %c4, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1143, %c42, %c5, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1144, %c42, %c3, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %1147 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg142, %1147) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %1148 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg26, %1148) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %1149 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%1146, %1149) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %1150 = call @kernel_gemm(%1147, %1148, %1149) {adf.kernel, "col, row" = [43 : index, 4 : index], ivs = [2 : index, 4 : index, 9 : index], kernel_gemm = 306 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%1150, %c43, %c4, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1147, %c43, %c5, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1148, %c43, %c3, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %1151 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg143, %1151) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %1152 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg27, %1152) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %1153 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%1150, %1153) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %1154 = call @kernel_gemm(%1151, %1152, %1153) {adf.kernel, "col, row" = [44 : index, 4 : index], ivs = [3 : index, 4 : index, 9 : index], kernel_gemm = 307 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%1154, %c44, %c4, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1151, %c44, %c5, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1152, %c44, %c3, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%1154, %arg148) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %1155 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg140, %1155) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %1156 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg29, %1156) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %1157 = call @kernel_gemm0(%1155, %1156) {adf.kernel, "col, row" = [41 : index, 5 : index], ivs = [0 : index, 5 : index, 9 : index], kernel = 0 : index, kernel_gemm0 = 308 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%1157, %c42, %c5, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1155, %c41, %c6, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1156, %c41, %c4, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %1158 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg141, %1158) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %1159 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg30, %1159) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %1160 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%1157, %1160) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %1161 = call @kernel_gemm(%1158, %1159, %1160) {adf.kernel, "col, row" = [42 : index, 5 : index], ivs = [1 : index, 5 : index, 9 : index], kernel_gemm = 309 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%1161, %c43, %c5, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1158, %c42, %c6, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1159, %c42, %c4, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %1162 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg142, %1162) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %1163 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg31, %1163) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %1164 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%1161, %1164) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %1165 = call @kernel_gemm(%1162, %1163, %1164) {adf.kernel, "col, row" = [43 : index, 5 : index], ivs = [2 : index, 5 : index, 9 : index], kernel_gemm = 310 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%1165, %c44, %c5, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1162, %c43, %c6, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1163, %c43, %c4, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %1166 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg143, %1166) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %1167 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg32, %1167) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %1168 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%1165, %1168) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %1169 = call @kernel_gemm(%1166, %1167, %1168) {adf.kernel, "col, row" = [44 : index, 5 : index], ivs = [3 : index, 5 : index, 9 : index], kernel_gemm = 311 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%1169, %c45, %c5, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1166, %c44, %c6, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1167, %c44, %c4, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%1169, %arg149) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %1170 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg140, %1170) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %1171 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg34, %1171) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %1172 = call @kernel_gemm0(%1170, %1171) {adf.kernel, "col, row" = [41 : index, 6 : index], ivs = [0 : index, 6 : index, 9 : index], kernel = 0 : index, kernel_gemm0 = 312 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%1172, %c41, %c6, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1170, %c41, %c7, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1171, %c41, %c5, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %1173 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg141, %1173) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %1174 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg35, %1174) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %1175 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%1172, %1175) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %1176 = call @kernel_gemm(%1173, %1174, %1175) {adf.kernel, "col, row" = [42 : index, 6 : index], ivs = [1 : index, 6 : index, 9 : index], kernel_gemm = 313 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%1176, %c42, %c6, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1173, %c42, %c7, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1174, %c42, %c5, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %1177 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg142, %1177) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %1178 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg36, %1178) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %1179 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%1176, %1179) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %1180 = call @kernel_gemm(%1177, %1178, %1179) {adf.kernel, "col, row" = [43 : index, 6 : index], ivs = [2 : index, 6 : index, 9 : index], kernel_gemm = 314 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%1180, %c43, %c6, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1177, %c43, %c7, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1178, %c43, %c5, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %1181 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg143, %1181) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %1182 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg37, %1182) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %1183 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%1180, %1183) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %1184 = call @kernel_gemm(%1181, %1182, %1183) {adf.kernel, "col, row" = [44 : index, 6 : index], ivs = [3 : index, 6 : index, 9 : index], kernel_gemm = 315 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%1184, %c44, %c6, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1181, %c44, %c7, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1182, %c44, %c5, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%1184, %arg150) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    %1185 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg140, %1185) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %1186 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg39, %1186) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %1187 = call @kernel_gemm0(%1185, %1186) {adf.kernel, "col, row" = [41 : index, 7 : index], ivs = [0 : index, 7 : index, 9 : index], kernel = 0 : index, kernel_gemm0 = 316 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%1187, %c42, %c7, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1185, %c41, %c7, %c4096, %c12288) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1186, %c41, %c6, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %1188 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg141, %1188) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %1189 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg40, %1189) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %1190 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%1187, %1190) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %1191 = call @kernel_gemm(%1188, %1189, %1190) {adf.kernel, "col, row" = [42 : index, 7 : index], ivs = [1 : index, 7 : index, 9 : index], kernel_gemm = 317 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%1191, %c43, %c7, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1188, %c42, %c7, %c4096, %c12288) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1189, %c42, %c6, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %1192 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg142, %1192) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %1193 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg41, %1193) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %1194 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%1191, %1194) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %1195 = call @kernel_gemm(%1192, %1193, %1194) {adf.kernel, "col, row" = [43 : index, 7 : index], ivs = [2 : index, 7 : index, 9 : index], kernel_gemm = 318 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%1195, %c44, %c7, %c16384, %c24576) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1192, %c43, %c7, %c4096, %c12288) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1193, %c43, %c6, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    %1196 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%arg143, %1196) : (!adf.plio<In, 128>, memref<32x64xi8, 2>)
    %1197 = adf.buffer.create() : memref<64x64xi8, 2>
    adf.connect(%arg42, %1197) : (!adf.plio<In, 128>, memref<64x64xi8, 2>)
    %1198 = adf.buffer.create() : memref<32x64xi8, 2>
    adf.connect(%1195, %1198) : (memref<32x64xi8, 2>, memref<32x64xi8, 2>)
    %1199 = call @kernel_gemm(%1196, %1197, %1198) {adf.kernel, "col, row" = [44 : index, 7 : index], ivs = [3 : index, 7 : index, 9 : index], kernel_gemm = 319 : index} : (memref<32x64xi8, 2>, memref<64x64xi8, 2>, memref<32x64xi8, 2>) -> memref<32x64xi8, 2>
    adf.buffer.location(%1199, %c45, %c7, %c0, %c8192) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1196, %c44, %c7, %c4096, %c12288) : (memref<32x64xi8, 2>, index, index, index, index)
    adf.buffer.location(%1197, %c44, %c6, %c4096, %c12288) : (memref<64x64xi8, 2>, index, index, index, index)
    adf.connect(%1199, %arg151) {write = 3 : index} : (memref<32x64xi8, 2>, !adf.plio<Out, 128>)
    return
  }
  func.func @receive13(%arg0: memref<1xi128, "stream">, %arg1: memref<1xi128, "plio">) attributes {adf.pl, inline = false, receive, template} {
    %c23 = arith.constant 23 : index
    %c16 = arith.constant 16 : index
    %c48 = arith.constant 48 : index
    %c87 = arith.constant 87 : index
    %c55 = arith.constant 55 : index
    %c104 = arith.constant 104 : index
    %c111 = arith.constant 111 : index
    %c80 = arith.constant 80 : index
    %c31 = arith.constant 31 : index
    %c24 = arith.constant 24 : index
    %c56 = arith.constant 56 : index
    %c95 = arith.constant 95 : index
    %c96 = arith.constant 96 : index
    %c63 = arith.constant 63 : index
    %c88 = arith.constant 88 : index
    %c103 = arith.constant 103 : index
    %c71 = arith.constant 71 : index
    %c32 = arith.constant 32 : index
    %c7 = arith.constant 7 : index
    %c64 = arith.constant 64 : index
    %c39 = arith.constant 39 : index
    %c120 = arith.constant 120 : index
    %c127 = arith.constant 127 : index
    %c8 = arith.constant 8 : index
    %c15 = arith.constant 15 : index
    %c40 = arith.constant 40 : index
    %c47 = arith.constant 47 : index
    %c72 = arith.constant 72 : index
    %c112 = arith.constant 112 : index
    %c79 = arith.constant 79 : index
    %c0 = arith.constant 0 : index
    %c119 = arith.constant 119 : index
    %c0_i128 = arith.constant 0 : i128
    %alloc = memref.alloc() {buffer_type = "uram_t2p"} : memref<256x32xi128, 1>
    affine.for %arg2 = 0 to 256 {
      affine.for %arg3 = 0 to 32 {
        affine.store %c0_i128, %alloc[%arg2, %arg3] : memref<256x32xi128, 1>
      } {pipeline_ii = 1 : index}
    }
    affine.for %arg2 = 0 to 1 {
      affine.for %arg3 = 0 to 1 {
        affine.for %arg4 = 0 to 256 {
          affine.for %arg5 = 0 to 8 {
            affine.for %arg6 = 0 to 8 {
              affine.for %arg7 = 0 to 1 {
                affine.for %arg8 = 0 to 32 {
                  affine.for %arg9 = 0 to 4 {
                    %0 = affine.load %arg1[0] : memref<1xi128, "plio">
                    %1 = affine.load %alloc[%arg8 + %arg5 * 32, %arg9 + %arg6 * 4] : memref<256x32xi128, 1>
                    %2 = adf.int_to_apint(%0) : (i128) -> i128
                    %3 = adf.int_to_apint(%1) : (i128) -> i128
                    %4 = adf.int_to_apint(%c0_i128) : (i128) -> i128
                    %5 = adf.get_slice(%2 : i128, %c7, %c0) -> i8
                    %6 = adf.get_slice(%3 : i128, %c7, %c0) -> i8
                    %7 = arith.addi %5, %6 : i8
                    adf.set_slice(%4 : i128, %c7, %c0, %7 : i8)
                    %8 = adf.get_slice(%2 : i128, %c15, %c8) -> i8
                    %9 = adf.get_slice(%3 : i128, %c15, %c8) -> i8
                    %10 = arith.addi %8, %9 : i8
                    adf.set_slice(%4 : i128, %c15, %c8, %10 : i8)
                    %11 = adf.get_slice(%2 : i128, %c23, %c16) -> i8
                    %12 = adf.get_slice(%3 : i128, %c23, %c16) -> i8
                    %13 = arith.addi %11, %12 : i8
                    adf.set_slice(%4 : i128, %c23, %c16, %13 : i8)
                    %14 = adf.get_slice(%2 : i128, %c31, %c24) -> i8
                    %15 = adf.get_slice(%3 : i128, %c31, %c24) -> i8
                    %16 = arith.addi %14, %15 : i8
                    adf.set_slice(%4 : i128, %c31, %c24, %16 : i8)
                    %17 = adf.get_slice(%2 : i128, %c39, %c32) -> i8
                    %18 = adf.get_slice(%3 : i128, %c39, %c32) -> i8
                    %19 = arith.addi %17, %18 : i8
                    adf.set_slice(%4 : i128, %c39, %c32, %19 : i8)
                    %20 = adf.get_slice(%2 : i128, %c47, %c40) -> i8
                    %21 = adf.get_slice(%3 : i128, %c47, %c40) -> i8
                    %22 = arith.addi %20, %21 : i8
                    adf.set_slice(%4 : i128, %c47, %c40, %22 : i8)
                    %23 = adf.get_slice(%2 : i128, %c55, %c48) -> i8
                    %24 = adf.get_slice(%3 : i128, %c55, %c48) -> i8
                    %25 = arith.addi %23, %24 : i8
                    adf.set_slice(%4 : i128, %c55, %c48, %25 : i8)
                    %26 = adf.get_slice(%2 : i128, %c63, %c56) -> i8
                    %27 = adf.get_slice(%3 : i128, %c63, %c56) -> i8
                    %28 = arith.addi %26, %27 : i8
                    adf.set_slice(%4 : i128, %c63, %c56, %28 : i8)
                    %29 = adf.get_slice(%2 : i128, %c71, %c64) -> i8
                    %30 = adf.get_slice(%3 : i128, %c71, %c64) -> i8
                    %31 = arith.addi %29, %30 : i8
                    adf.set_slice(%4 : i128, %c71, %c64, %31 : i8)
                    %32 = adf.get_slice(%2 : i128, %c79, %c72) -> i8
                    %33 = adf.get_slice(%3 : i128, %c79, %c72) -> i8
                    %34 = arith.addi %32, %33 : i8
                    adf.set_slice(%4 : i128, %c79, %c72, %34 : i8)
                    %35 = adf.get_slice(%2 : i128, %c87, %c80) -> i8
                    %36 = adf.get_slice(%3 : i128, %c87, %c80) -> i8
                    %37 = arith.addi %35, %36 : i8
                    adf.set_slice(%4 : i128, %c87, %c80, %37 : i8)
                    %38 = adf.get_slice(%2 : i128, %c95, %c88) -> i8
                    %39 = adf.get_slice(%3 : i128, %c95, %c88) -> i8
                    %40 = arith.addi %38, %39 : i8
                    adf.set_slice(%4 : i128, %c95, %c88, %40 : i8)
                    %41 = adf.get_slice(%2 : i128, %c103, %c96) -> i8
                    %42 = adf.get_slice(%3 : i128, %c103, %c96) -> i8
                    %43 = arith.addi %41, %42 : i8
                    adf.set_slice(%4 : i128, %c103, %c96, %43 : i8)
                    %44 = adf.get_slice(%2 : i128, %c111, %c104) -> i8
                    %45 = adf.get_slice(%3 : i128, %c111, %c104) -> i8
                    %46 = arith.addi %44, %45 : i8
                    adf.set_slice(%4 : i128, %c111, %c104, %46 : i8)
                    %47 = adf.get_slice(%2 : i128, %c119, %c112) -> i8
                    %48 = adf.get_slice(%3 : i128, %c119, %c112) -> i8
                    %49 = arith.addi %47, %48 : i8
                    adf.set_slice(%4 : i128, %c119, %c112, %49 : i8)
                    %50 = adf.get_slice(%2 : i128, %c127, %c120) -> i8
                    %51 = adf.get_slice(%3 : i128, %c127, %c120) -> i8
                    %52 = arith.addi %50, %51 : i8
                    adf.set_slice(%4 : i128, %c127, %c120, %52 : i8)
                    %53 = adf.apint_to_int(%4) : (i128) -> i128
                    affine.store %53, %alloc[%arg8 + %arg5 * 32, %arg9 + %arg6 * 4] : memref<256x32xi128, 1>
                  } {pipeline_ii = 1 : index}
                }
              }
            }
          }
        } {Array_Partition, reduction}
        affine.for %arg4 = 0 to 8 {
          affine.for %arg5 = 0 to 32 {
            affine.for %arg6 = 0 to 8 {
              affine.for %arg7 = 0 to 4 {
                %0 = affine.load %alloc[%arg5 + %arg4 * 32, %arg7 + %arg6 * 4] : memref<256x32xi128, 1>
                affine.store %0, %arg0[0] : memref<1xi128, "stream">
                affine.store %c0_i128, %alloc[%arg5 + %arg4 * 32, %arg7 + %arg6 * 4] : memref<256x32xi128, 1>
              } {pipeline_ii = 1 : index}
            }
          }
        }
      }
    }
    return
  }
  func.func @receive13_top(%arg0: memref<1xi128, "stream">, %arg1: memref<1xi128, "plio">, %arg2: memref<1xi128, "stream">, %arg3: memref<1xi128, "plio">, %arg4: memref<1xi128, "stream">, %arg5: memref<1xi128, "plio">, %arg6: memref<1xi128, "stream">, %arg7: memref<1xi128, "plio">, %arg8: memref<1xi128, "stream">, %arg9: memref<1xi128, "plio">, %arg10: memref<1xi128, "stream">, %arg11: memref<1xi128, "plio">, %arg12: memref<1xi128, "stream">, %arg13: memref<1xi128, "plio">, %arg14: memref<1xi128, "stream">, %arg15: memref<1xi128, "plio">, %arg16: memref<1xi128, "stream">, %arg17: memref<1xi128, "plio">, %arg18: memref<1xi128, "stream">, %arg19: memref<1xi128, "plio">, %arg20: memref<1xi128, "stream">, %arg21: memref<1xi128, "plio">, %arg22: memref<1xi128, "stream">, %arg23: memref<1xi128, "plio">, %arg24: memref<1xi128, "stream">, %arg25: memref<1xi128, "plio">, %arg26: memref<1xi128, "stream">, %arg27: memref<1xi128, "plio">, %arg28: memref<1xi128, "stream">, %arg29: memref<1xi128, "plio">, %arg30: memref<1xi128, "stream">, %arg31: memref<1xi128, "plio">, %arg32: memref<1xi128, "stream">, %arg33: memref<1xi128, "plio">, %arg34: memref<1xi128, "stream">, %arg35: memref<1xi128, "plio">, %arg36: memref<1xi128, "stream">, %arg37: memref<1xi128, "plio">, %arg38: memref<1xi128, "stream">, %arg39: memref<1xi128, "plio">, %arg40: memref<1xi128, "stream">, %arg41: memref<1xi128, "plio">, %arg42: memref<1xi128, "stream">, %arg43: memref<1xi128, "plio">, %arg44: memref<1xi128, "stream">, %arg45: memref<1xi128, "plio">, %arg46: memref<1xi128, "stream">, %arg47: memref<1xi128, "plio">, %arg48: memref<1xi128, "stream">, %arg49: memref<1xi128, "plio">, %arg50: memref<1xi128, "stream">, %arg51: memref<1xi128, "plio">, %arg52: memref<1xi128, "stream">, %arg53: memref<1xi128, "plio">, %arg54: memref<1xi128, "stream">, %arg55: memref<1xi128, "plio">, %arg56: memref<1xi128, "stream">, %arg57: memref<1xi128, "plio">, %arg58: memref<1xi128, "stream">, %arg59: memref<1xi128, "plio">, %arg60: memref<1xi128, "stream">, %arg61: memref<1xi128, "plio">, %arg62: memref<1xi128, "stream">, %arg63: memref<1xi128, "plio">, %arg64: memref<1xi128, "stream">, %arg65: memref<1xi128, "plio">, %arg66: memref<1xi128, "stream">, %arg67: memref<1xi128, "plio">, %arg68: memref<1xi128, "stream">, %arg69: memref<1xi128, "plio">, %arg70: memref<1xi128, "stream">, %arg71: memref<1xi128, "plio">, %arg72: memref<1xi128, "stream">, %arg73: memref<1xi128, "plio">, %arg74: memref<1xi128, "stream">, %arg75: memref<1xi128, "plio">) attributes {adf.pl, inline = false} {
    call @receive13(%arg0, %arg1) {template = 0 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @receive13(%arg2, %arg3) {template = 1 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @receive13(%arg4, %arg5) {template = 2 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @receive13(%arg6, %arg7) {template = 3 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @receive13(%arg8, %arg9) {template = 4 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @receive13(%arg10, %arg11) {template = 5 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @receive13(%arg12, %arg13) {template = 6 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @receive13(%arg14, %arg15) {template = 7 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @receive13(%arg16, %arg17) {template = 8 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @receive13(%arg18, %arg19) {template = 9 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @receive13(%arg20, %arg21) {template = 10 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @receive13(%arg22, %arg23) {template = 11 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @receive13(%arg24, %arg25) {template = 12 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @receive13(%arg26, %arg27) {template = 13 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @receive13(%arg28, %arg29) {template = 14 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @receive13(%arg30, %arg31) {template = 15 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @receive13(%arg32, %arg33) {template = 16 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @receive13(%arg34, %arg35) {template = 17 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @receive13(%arg36, %arg37) {template = 18 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @receive13(%arg38, %arg39) {template = 19 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @receive13(%arg40, %arg41) {template = 20 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @receive13(%arg42, %arg43) {template = 21 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @receive13(%arg44, %arg45) {template = 22 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @receive13(%arg46, %arg47) {template = 23 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @receive13(%arg48, %arg49) {template = 24 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @receive13(%arg50, %arg51) {template = 25 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @receive13(%arg52, %arg53) {template = 26 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @receive13(%arg54, %arg55) {template = 27 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @receive13(%arg56, %arg57) {template = 28 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @receive13(%arg58, %arg59) {template = 29 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @receive13(%arg60, %arg61) {template = 30 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @receive13(%arg62, %arg63) {template = 31 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @receive13(%arg64, %arg65) {template = 32 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @receive13(%arg66, %arg67) {template = 33 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @receive13(%arg68, %arg69) {template = 34 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @receive13(%arg70, %arg71) {template = 35 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @receive13(%arg72, %arg73) {template = 36 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @receive13(%arg74, %arg75) {template = 37 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    return
  }
  func.func @send29_0(%arg0: memref<1xi128, "stream">, %arg1: memref<64x32xi128, 1>, %arg2: i1) attributes {adf.pl, inline = false} {
    scf.if %arg2 {
      affine.for %arg3 = 0 to 1 {
        affine.for %arg4 = 0 to 64 {
          affine.for %arg5 = 0 to 8 {
            affine.for %arg6 = 0 to 4 {
              %0 = affine.load %arg0[0] : memref<1xi128, "stream">
              affine.store %0, %arg1[%arg4 + %arg3 * 64, %arg6 + %arg5 * 4] : memref<64x32xi128, 1>
            } {pipeline_ii = 1 : index}
          }
        }
      }
    }
    return
  }
  func.func @send29_1(%arg0: memref<64x32xi128, 1>, %arg1: memref<1xi128, "plio">, %arg2: i1) attributes {adf.pl, inline = false} {
    scf.if %arg2 {
      affine.for %arg3 = 0 to 8 {
        affine.for %arg4 = 0 to 8 {
          affine.for %arg5 = 0 to 1 {
            affine.for %arg6 = 0 to 64 {
              affine.for %arg7 = 0 to 4 {
                %0 = affine.load %arg0[%arg6 + %arg5 * 64, %arg7 + %arg4 * 4] : memref<64x32xi128, 1>
                affine.store %0, %arg1[0] : memref<1xi128, "plio">
              } {pipeline_ii = 1 : index}
            }
          }
        }
      }
    }
    return
  }
  func.func @send29(%arg0: memref<1xi128, "stream">, %arg1: memref<1xi128, "plio">) attributes {adf.pl, inline = false, send, template} {
    %true = arith.constant true
    %c256 = arith.constant 256 : index
    %c0 = arith.constant 0 : index
    %c2 = arith.constant 2 : index
    %alloc = memref.alloc() {buffer_type = "bram_s2p"} : memref<64x32xi128, 1>
    %alloc_0 = memref.alloc() {buffer_type = "bram_s2p"} : memref<64x32xi128, 1>
    affine.for %arg2 = 0 to 1 {
      affine.for %arg3 = 0 to 1 {
        affine.for %arg4 = 0 to 256 {
          %0 = arith.muli %arg3, %c256 : index
          %1 = arith.addi %arg4, %0 : index
          %2 = arith.muli %arg2, %c256 : index
          %3 = arith.addi %1, %2 : index
          %4 = arith.remsi %3, %c2 : index
          %5 = arith.cmpi eq, %4, %c0 : index
          %6 = arith.cmpi ne, %3, %c0 : index
          scf.if %5 {
            func.call @send29_0(%arg0, %alloc, %true) : (memref<1xi128, "stream">, memref<64x32xi128, 1>, i1) -> ()
            func.call @send29_1(%alloc_0, %arg1, %6) : (memref<64x32xi128, 1>, memref<1xi128, "plio">, i1) -> ()
          } else {
            func.call @send29_0(%arg0, %alloc_0, %true) : (memref<1xi128, "stream">, memref<64x32xi128, 1>, i1) -> ()
            func.call @send29_1(%alloc, %arg1, %6) : (memref<64x32xi128, 1>, memref<1xi128, "plio">, i1) -> ()
          }
        } {Array_Partition, reduction}
      }
    }
    call @send29_1(%alloc_0, %arg1, %true) : (memref<64x32xi128, 1>, memref<1xi128, "plio">, i1) -> ()
    return
  }
  func.func @send29_top(%arg0: memref<1xi128, "stream">, %arg1: memref<1xi128, "plio">, %arg2: memref<1xi128, "stream">, %arg3: memref<1xi128, "plio">, %arg4: memref<1xi128, "stream">, %arg5: memref<1xi128, "plio">, %arg6: memref<1xi128, "stream">, %arg7: memref<1xi128, "plio">, %arg8: memref<1xi128, "stream">, %arg9: memref<1xi128, "plio">, %arg10: memref<1xi128, "stream">, %arg11: memref<1xi128, "plio">, %arg12: memref<1xi128, "stream">, %arg13: memref<1xi128, "plio">, %arg14: memref<1xi128, "stream">, %arg15: memref<1xi128, "plio">, %arg16: memref<1xi128, "stream">, %arg17: memref<1xi128, "plio">, %arg18: memref<1xi128, "stream">, %arg19: memref<1xi128, "plio">, %arg20: memref<1xi128, "stream">, %arg21: memref<1xi128, "plio">, %arg22: memref<1xi128, "stream">, %arg23: memref<1xi128, "plio">, %arg24: memref<1xi128, "stream">, %arg25: memref<1xi128, "plio">, %arg26: memref<1xi128, "stream">, %arg27: memref<1xi128, "plio">, %arg28: memref<1xi128, "stream">, %arg29: memref<1xi128, "plio">, %arg30: memref<1xi128, "stream">, %arg31: memref<1xi128, "plio">, %arg32: memref<1xi128, "stream">, %arg33: memref<1xi128, "plio">, %arg34: memref<1xi128, "stream">, %arg35: memref<1xi128, "plio">, %arg36: memref<1xi128, "stream">, %arg37: memref<1xi128, "plio">, %arg38: memref<1xi128, "stream">, %arg39: memref<1xi128, "plio">, %arg40: memref<1xi128, "stream">, %arg41: memref<1xi128, "plio">, %arg42: memref<1xi128, "stream">, %arg43: memref<1xi128, "plio">, %arg44: memref<1xi128, "stream">, %arg45: memref<1xi128, "plio">, %arg46: memref<1xi128, "stream">, %arg47: memref<1xi128, "plio">, %arg48: memref<1xi128, "stream">, %arg49: memref<1xi128, "plio">, %arg50: memref<1xi128, "stream">, %arg51: memref<1xi128, "plio">, %arg52: memref<1xi128, "stream">, %arg53: memref<1xi128, "plio">, %arg54: memref<1xi128, "stream">, %arg55: memref<1xi128, "plio">, %arg56: memref<1xi128, "stream">, %arg57: memref<1xi128, "plio">, %arg58: memref<1xi128, "stream">, %arg59: memref<1xi128, "plio">, %arg60: memref<1xi128, "stream">, %arg61: memref<1xi128, "plio">, %arg62: memref<1xi128, "stream">, %arg63: memref<1xi128, "plio">) attributes {adf.pl, inline = false} {
    call @send29(%arg0, %arg1) {template = 0 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send29(%arg2, %arg3) {template = 1 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send29(%arg4, %arg5) {template = 2 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send29(%arg6, %arg7) {template = 3 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send29(%arg8, %arg9) {template = 4 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send29(%arg10, %arg11) {template = 5 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send29(%arg12, %arg13) {template = 6 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send29(%arg14, %arg15) {template = 7 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send29(%arg16, %arg17) {template = 8 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send29(%arg18, %arg19) {template = 9 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send29(%arg20, %arg21) {template = 10 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send29(%arg22, %arg23) {template = 11 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send29(%arg24, %arg25) {template = 12 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send29(%arg26, %arg27) {template = 13 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send29(%arg28, %arg29) {template = 14 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send29(%arg30, %arg31) {template = 15 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send29(%arg32, %arg33) {template = 16 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send29(%arg34, %arg35) {template = 17 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send29(%arg36, %arg37) {template = 18 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send29(%arg38, %arg39) {template = 19 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send29(%arg40, %arg41) {template = 20 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send29(%arg42, %arg43) {template = 21 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send29(%arg44, %arg45) {template = 22 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send29(%arg46, %arg47) {template = 23 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send29(%arg48, %arg49) {template = 24 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send29(%arg50, %arg51) {template = 25 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send29(%arg52, %arg53) {template = 26 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send29(%arg54, %arg55) {template = 27 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send29(%arg56, %arg57) {template = 28 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send29(%arg58, %arg59) {template = 29 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send29(%arg60, %arg61) {template = 30 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send29(%arg62, %arg63) {template = 31 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    return
  }
  func.func @send39_0(%arg0: memref<1xi128, "stream">, %arg1: memref<256x4xi128, 1>, %arg2: i1) attributes {adf.pl, inline = false} {
    scf.if %arg2 {
      affine.for %arg3 = 0 to 8 {
        affine.for %arg4 = 0 to 32 {
          affine.for %arg5 = 0 to 1 {
            affine.for %arg6 = 0 to 4 {
              %0 = affine.load %arg0[0] : memref<1xi128, "stream">
              affine.store %0, %arg1[%arg4 + %arg3 * 32, %arg6 + %arg5 * 4] : memref<256x4xi128, 1>
            } {pipeline_ii = 1 : index}
          }
        }
      }
    }
    return
  }
  func.func @send39_1(%arg0: memref<256x4xi128, 1>, %arg1: memref<1xi128, "plio">, %arg2: i1) attributes {adf.pl, inline = false} {
    scf.if %arg2 {
      affine.for %arg3 = 0 to 8 {
        affine.for %arg4 = 0 to 8 {
          affine.for %arg5 = 0 to 1 {
            affine.for %arg6 = 0 to 32 {
              affine.for %arg7 = 0 to 4 {
                %0 = affine.load %arg0[%arg6 + %arg3 * 32, %arg7 + %arg5 * 4] : memref<256x4xi128, 1>
                affine.store %0, %arg1[0] : memref<1xi128, "plio">
              } {pipeline_ii = 1 : index}
            }
          }
        }
      }
    }
    return
  }
  func.func @send39(%arg0: memref<1xi128, "stream">, %arg1: memref<1xi128, "plio">) attributes {adf.pl, inline = false, send, template} {
    %true = arith.constant true
    %c256 = arith.constant 256 : index
    %c0 = arith.constant 0 : index
    %c2 = arith.constant 2 : index
    %alloc = memref.alloc() {buffer_type = "bram_s2p"} : memref<256x4xi128, 1>
    %alloc_0 = memref.alloc() {buffer_type = "bram_s2p"} : memref<256x4xi128, 1>
    affine.for %arg2 = 0 to 1 {
      affine.for %arg3 = 0 to 1 {
        affine.for %arg4 = 0 to 256 {
          %0 = arith.muli %arg3, %c256 : index
          %1 = arith.addi %arg4, %0 : index
          %2 = arith.muli %arg2, %c256 : index
          %3 = arith.addi %1, %2 : index
          %4 = arith.remsi %3, %c2 : index
          %5 = arith.cmpi eq, %4, %c0 : index
          %6 = arith.cmpi ne, %3, %c0 : index
          scf.if %5 {
            func.call @send39_0(%arg0, %alloc, %true) : (memref<1xi128, "stream">, memref<256x4xi128, 1>, i1) -> ()
            func.call @send39_1(%alloc_0, %arg1, %6) : (memref<256x4xi128, 1>, memref<1xi128, "plio">, i1) -> ()
          } else {
            func.call @send39_0(%arg0, %alloc_0, %true) : (memref<1xi128, "stream">, memref<256x4xi128, 1>, i1) -> ()
            func.call @send39_1(%alloc, %arg1, %6) : (memref<256x4xi128, 1>, memref<1xi128, "plio">, i1) -> ()
          }
        } {Array_Partition, reduction}
      }
    }
    call @send39_1(%alloc_0, %arg1, %true) : (memref<256x4xi128, 1>, memref<1xi128, "plio">, i1) -> ()
    return
  }
  func.func @send39_top(%arg0: memref<1xi128, "stream">, %arg1: memref<1xi128, "plio">, %arg2: memref<1xi128, "stream">, %arg3: memref<1xi128, "plio">, %arg4: memref<1xi128, "stream">, %arg5: memref<1xi128, "plio">, %arg6: memref<1xi128, "stream">, %arg7: memref<1xi128, "plio">, %arg8: memref<1xi128, "stream">, %arg9: memref<1xi128, "plio">, %arg10: memref<1xi128, "stream">, %arg11: memref<1xi128, "plio">, %arg12: memref<1xi128, "stream">, %arg13: memref<1xi128, "plio">, %arg14: memref<1xi128, "stream">, %arg15: memref<1xi128, "plio">, %arg16: memref<1xi128, "stream">, %arg17: memref<1xi128, "plio">, %arg18: memref<1xi128, "stream">, %arg19: memref<1xi128, "plio">, %arg20: memref<1xi128, "stream">, %arg21: memref<1xi128, "plio">, %arg22: memref<1xi128, "stream">, %arg23: memref<1xi128, "plio">, %arg24: memref<1xi128, "stream">, %arg25: memref<1xi128, "plio">, %arg26: memref<1xi128, "stream">, %arg27: memref<1xi128, "plio">, %arg28: memref<1xi128, "stream">, %arg29: memref<1xi128, "plio">, %arg30: memref<1xi128, "stream">, %arg31: memref<1xi128, "plio">, %arg32: memref<1xi128, "stream">, %arg33: memref<1xi128, "plio">, %arg34: memref<1xi128, "stream">, %arg35: memref<1xi128, "plio">, %arg36: memref<1xi128, "stream">, %arg37: memref<1xi128, "plio">, %arg38: memref<1xi128, "stream">, %arg39: memref<1xi128, "plio">, %arg40: memref<1xi128, "stream">, %arg41: memref<1xi128, "plio">, %arg42: memref<1xi128, "stream">, %arg43: memref<1xi128, "plio">, %arg44: memref<1xi128, "stream">, %arg45: memref<1xi128, "plio">, %arg46: memref<1xi128, "stream">, %arg47: memref<1xi128, "plio">, %arg48: memref<1xi128, "stream">, %arg49: memref<1xi128, "plio">, %arg50: memref<1xi128, "stream">, %arg51: memref<1xi128, "plio">, %arg52: memref<1xi128, "stream">, %arg53: memref<1xi128, "plio">, %arg54: memref<1xi128, "stream">, %arg55: memref<1xi128, "plio">, %arg56: memref<1xi128, "stream">, %arg57: memref<1xi128, "plio">, %arg58: memref<1xi128, "stream">, %arg59: memref<1xi128, "plio">, %arg60: memref<1xi128, "stream">, %arg61: memref<1xi128, "plio">, %arg62: memref<1xi128, "stream">, %arg63: memref<1xi128, "plio">, %arg64: memref<1xi128, "stream">, %arg65: memref<1xi128, "plio">, %arg66: memref<1xi128, "stream">, %arg67: memref<1xi128, "plio">, %arg68: memref<1xi128, "stream">, %arg69: memref<1xi128, "plio">, %arg70: memref<1xi128, "stream">, %arg71: memref<1xi128, "plio">, %arg72: memref<1xi128, "stream">, %arg73: memref<1xi128, "plio">, %arg74: memref<1xi128, "stream">, %arg75: memref<1xi128, "plio">, %arg76: memref<1xi128, "stream">, %arg77: memref<1xi128, "plio">, %arg78: memref<1xi128, "stream">, %arg79: memref<1xi128, "plio">) attributes {adf.pl, inline = false} {
    call @send39(%arg0, %arg1) {template = 0 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send39(%arg2, %arg3) {template = 1 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send39(%arg4, %arg5) {template = 2 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send39(%arg6, %arg7) {template = 3 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send39(%arg8, %arg9) {template = 4 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send39(%arg10, %arg11) {template = 5 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send39(%arg12, %arg13) {template = 6 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send39(%arg14, %arg15) {template = 7 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send39(%arg16, %arg17) {template = 8 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send39(%arg18, %arg19) {template = 9 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send39(%arg20, %arg21) {template = 10 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send39(%arg22, %arg23) {template = 11 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send39(%arg24, %arg25) {template = 12 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send39(%arg26, %arg27) {template = 13 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send39(%arg28, %arg29) {template = 14 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send39(%arg30, %arg31) {template = 15 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send39(%arg32, %arg33) {template = 16 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send39(%arg34, %arg35) {template = 17 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send39(%arg36, %arg37) {template = 18 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send39(%arg38, %arg39) {template = 19 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send39(%arg40, %arg41) {template = 20 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send39(%arg42, %arg43) {template = 21 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send39(%arg44, %arg45) {template = 22 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send39(%arg46, %arg47) {template = 23 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send39(%arg48, %arg49) {template = 24 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send39(%arg50, %arg51) {template = 25 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send39(%arg52, %arg53) {template = 26 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send39(%arg54, %arg55) {template = 27 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send39(%arg56, %arg57) {template = 28 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send39(%arg58, %arg59) {template = 29 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send39(%arg60, %arg61) {template = 30 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send39(%arg62, %arg63) {template = 31 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send39(%arg64, %arg65) {template = 32 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send39(%arg66, %arg67) {template = 33 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send39(%arg68, %arg69) {template = 34 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send39(%arg70, %arg71) {template = 35 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send39(%arg72, %arg73) {template = 36 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send39(%arg74, %arg75) {template = 37 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send39(%arg76, %arg77) {template = 38 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send39(%arg78, %arg79) {template = 39 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    return
  }
  func.func @receive27(%arg0: memref<1xi128, "plio">, %arg1: memref<1xi128, "stream">) attributes {adf.pl, inline = false, receive, template} {
    %c23 = arith.constant 23 : index
    %c16 = arith.constant 16 : index
    %c48 = arith.constant 48 : index
    %c87 = arith.constant 87 : index
    %c55 = arith.constant 55 : index
    %c104 = arith.constant 104 : index
    %c111 = arith.constant 111 : index
    %c80 = arith.constant 80 : index
    %c31 = arith.constant 31 : index
    %c24 = arith.constant 24 : index
    %c56 = arith.constant 56 : index
    %c95 = arith.constant 95 : index
    %c96 = arith.constant 96 : index
    %c63 = arith.constant 63 : index
    %c88 = arith.constant 88 : index
    %c103 = arith.constant 103 : index
    %c71 = arith.constant 71 : index
    %c32 = arith.constant 32 : index
    %c7 = arith.constant 7 : index
    %c64 = arith.constant 64 : index
    %c39 = arith.constant 39 : index
    %c120 = arith.constant 120 : index
    %c0_i128 = arith.constant 0 : i128
    %c119 = arith.constant 119 : index
    %c0 = arith.constant 0 : index
    %c79 = arith.constant 79 : index
    %c72 = arith.constant 72 : index
    %c47 = arith.constant 47 : index
    %c112 = arith.constant 112 : index
    %c40 = arith.constant 40 : index
    %c15 = arith.constant 15 : index
    %c8 = arith.constant 8 : index
    %c127 = arith.constant 127 : index
    %alloc = memref.alloc() {buffer_type = "uram_t2p"} : memref<256x32xi128, 1>
    affine.for %arg2 = 0 to 256 {
      affine.for %arg3 = 0 to 32 {
        affine.store %c0_i128, %alloc[%arg2, %arg3] : memref<256x32xi128, 1>
      } {pipeline_ii = 1 : index}
    }
    affine.for %arg2 = 0 to 1 {
      affine.for %arg3 = 0 to 1 {
        affine.for %arg4 = 0 to 256 {
          affine.for %arg5 = 0 to 8 {
            affine.for %arg6 = 0 to 8 {
              affine.for %arg7 = 0 to 1 {
                affine.for %arg8 = 0 to 32 {
                  affine.for %arg9 = 0 to 4 {
                    %0 = affine.load %arg0[0] : memref<1xi128, "plio">
                    %1 = affine.load %alloc[%arg8 + %arg5 * 32, %arg9 + %arg6 * 4] : memref<256x32xi128, 1>
                    %2 = adf.int_to_apint(%0) : (i128) -> i128
                    %3 = adf.int_to_apint(%1) : (i128) -> i128
                    %4 = adf.int_to_apint(%c0_i128) : (i128) -> i128
                    %5 = adf.get_slice(%2 : i128, %c7, %c0) -> i8
                    %6 = adf.get_slice(%3 : i128, %c7, %c0) -> i8
                    %7 = arith.addi %5, %6 : i8
                    adf.set_slice(%4 : i128, %c7, %c0, %7 : i8)
                    %8 = adf.get_slice(%2 : i128, %c15, %c8) -> i8
                    %9 = adf.get_slice(%3 : i128, %c15, %c8) -> i8
                    %10 = arith.addi %8, %9 : i8
                    adf.set_slice(%4 : i128, %c15, %c8, %10 : i8)
                    %11 = adf.get_slice(%2 : i128, %c23, %c16) -> i8
                    %12 = adf.get_slice(%3 : i128, %c23, %c16) -> i8
                    %13 = arith.addi %11, %12 : i8
                    adf.set_slice(%4 : i128, %c23, %c16, %13 : i8)
                    %14 = adf.get_slice(%2 : i128, %c31, %c24) -> i8
                    %15 = adf.get_slice(%3 : i128, %c31, %c24) -> i8
                    %16 = arith.addi %14, %15 : i8
                    adf.set_slice(%4 : i128, %c31, %c24, %16 : i8)
                    %17 = adf.get_slice(%2 : i128, %c39, %c32) -> i8
                    %18 = adf.get_slice(%3 : i128, %c39, %c32) -> i8
                    %19 = arith.addi %17, %18 : i8
                    adf.set_slice(%4 : i128, %c39, %c32, %19 : i8)
                    %20 = adf.get_slice(%2 : i128, %c47, %c40) -> i8
                    %21 = adf.get_slice(%3 : i128, %c47, %c40) -> i8
                    %22 = arith.addi %20, %21 : i8
                    adf.set_slice(%4 : i128, %c47, %c40, %22 : i8)
                    %23 = adf.get_slice(%2 : i128, %c55, %c48) -> i8
                    %24 = adf.get_slice(%3 : i128, %c55, %c48) -> i8
                    %25 = arith.addi %23, %24 : i8
                    adf.set_slice(%4 : i128, %c55, %c48, %25 : i8)
                    %26 = adf.get_slice(%2 : i128, %c63, %c56) -> i8
                    %27 = adf.get_slice(%3 : i128, %c63, %c56) -> i8
                    %28 = arith.addi %26, %27 : i8
                    adf.set_slice(%4 : i128, %c63, %c56, %28 : i8)
                    %29 = adf.get_slice(%2 : i128, %c71, %c64) -> i8
                    %30 = adf.get_slice(%3 : i128, %c71, %c64) -> i8
                    %31 = arith.addi %29, %30 : i8
                    adf.set_slice(%4 : i128, %c71, %c64, %31 : i8)
                    %32 = adf.get_slice(%2 : i128, %c79, %c72) -> i8
                    %33 = adf.get_slice(%3 : i128, %c79, %c72) -> i8
                    %34 = arith.addi %32, %33 : i8
                    adf.set_slice(%4 : i128, %c79, %c72, %34 : i8)
                    %35 = adf.get_slice(%2 : i128, %c87, %c80) -> i8
                    %36 = adf.get_slice(%3 : i128, %c87, %c80) -> i8
                    %37 = arith.addi %35, %36 : i8
                    adf.set_slice(%4 : i128, %c87, %c80, %37 : i8)
                    %38 = adf.get_slice(%2 : i128, %c95, %c88) -> i8
                    %39 = adf.get_slice(%3 : i128, %c95, %c88) -> i8
                    %40 = arith.addi %38, %39 : i8
                    adf.set_slice(%4 : i128, %c95, %c88, %40 : i8)
                    %41 = adf.get_slice(%2 : i128, %c103, %c96) -> i8
                    %42 = adf.get_slice(%3 : i128, %c103, %c96) -> i8
                    %43 = arith.addi %41, %42 : i8
                    adf.set_slice(%4 : i128, %c103, %c96, %43 : i8)
                    %44 = adf.get_slice(%2 : i128, %c111, %c104) -> i8
                    %45 = adf.get_slice(%3 : i128, %c111, %c104) -> i8
                    %46 = arith.addi %44, %45 : i8
                    adf.set_slice(%4 : i128, %c111, %c104, %46 : i8)
                    %47 = adf.get_slice(%2 : i128, %c119, %c112) -> i8
                    %48 = adf.get_slice(%3 : i128, %c119, %c112) -> i8
                    %49 = arith.addi %47, %48 : i8
                    adf.set_slice(%4 : i128, %c119, %c112, %49 : i8)
                    %50 = adf.get_slice(%2 : i128, %c127, %c120) -> i8
                    %51 = adf.get_slice(%3 : i128, %c127, %c120) -> i8
                    %52 = arith.addi %50, %51 : i8
                    adf.set_slice(%4 : i128, %c127, %c120, %52 : i8)
                    %53 = adf.apint_to_int(%4) : (i128) -> i128
                    affine.store %53, %alloc[%arg8 + %arg5 * 32, %arg9 + %arg6 * 4] : memref<256x32xi128, 1>
                  } {pipeline_ii = 1 : index}
                }
              }
            }
          }
        } {Array_Partition, reduction}
        affine.for %arg4 = 0 to 8 {
          affine.for %arg5 = 0 to 32 {
            affine.for %arg6 = 0 to 8 {
              affine.for %arg7 = 0 to 4 {
                %0 = affine.load %alloc[%arg5 + %arg4 * 32, %arg7 + %arg6 * 4] : memref<256x32xi128, 1>
                affine.store %0, %arg1[0] : memref<1xi128, "stream">
                affine.store %c0_i128, %alloc[%arg5 + %arg4 * 32, %arg7 + %arg6 * 4] : memref<256x32xi128, 1>
              } {pipeline_ii = 1 : index}
            }
          }
        }
      }
    }
    return
  }
  func.func @receive27_top(%arg0: memref<1xi128, "plio">, %arg1: memref<1xi128, "stream">, %arg2: memref<1xi128, "plio">, %arg3: memref<1xi128, "stream">, %arg4: memref<1xi128, "plio">, %arg5: memref<1xi128, "stream">, %arg6: memref<1xi128, "plio">, %arg7: memref<1xi128, "stream">, %arg8: memref<1xi128, "plio">, %arg9: memref<1xi128, "stream">, %arg10: memref<1xi128, "plio">, %arg11: memref<1xi128, "stream">, %arg12: memref<1xi128, "plio">, %arg13: memref<1xi128, "stream">, %arg14: memref<1xi128, "plio">, %arg15: memref<1xi128, "stream">, %arg16: memref<1xi128, "plio">, %arg17: memref<1xi128, "stream">, %arg18: memref<1xi128, "plio">, %arg19: memref<1xi128, "stream">, %arg20: memref<1xi128, "plio">, %arg21: memref<1xi128, "stream">, %arg22: memref<1xi128, "plio">, %arg23: memref<1xi128, "stream">, %arg24: memref<1xi128, "plio">, %arg25: memref<1xi128, "stream">, %arg26: memref<1xi128, "plio">, %arg27: memref<1xi128, "stream">, %arg28: memref<1xi128, "plio">, %arg29: memref<1xi128, "stream">, %arg30: memref<1xi128, "plio">, %arg31: memref<1xi128, "stream">, %arg32: memref<1xi128, "plio">, %arg33: memref<1xi128, "stream">, %arg34: memref<1xi128, "plio">, %arg35: memref<1xi128, "stream">, %arg36: memref<1xi128, "plio">, %arg37: memref<1xi128, "stream">, %arg38: memref<1xi128, "plio">, %arg39: memref<1xi128, "stream">, %arg40: memref<1xi128, "plio">, %arg41: memref<1xi128, "stream">, %arg42: memref<1xi128, "plio">, %arg43: memref<1xi128, "stream">, %arg44: memref<1xi128, "plio">, %arg45: memref<1xi128, "stream">, %arg46: memref<1xi128, "plio">, %arg47: memref<1xi128, "stream">, %arg48: memref<1xi128, "plio">, %arg49: memref<1xi128, "stream">, %arg50: memref<1xi128, "plio">, %arg51: memref<1xi128, "stream">, %arg52: memref<1xi128, "plio">, %arg53: memref<1xi128, "stream">, %arg54: memref<1xi128, "plio">, %arg55: memref<1xi128, "stream">, %arg56: memref<1xi128, "plio">, %arg57: memref<1xi128, "stream">, %arg58: memref<1xi128, "plio">, %arg59: memref<1xi128, "stream">, %arg60: memref<1xi128, "plio">, %arg61: memref<1xi128, "stream">, %arg62: memref<1xi128, "plio">, %arg63: memref<1xi128, "stream">, %arg64: memref<1xi128, "plio">, %arg65: memref<1xi128, "stream">, %arg66: memref<1xi128, "plio">, %arg67: memref<1xi128, "stream">, %arg68: memref<1xi128, "plio">, %arg69: memref<1xi128, "stream">, %arg70: memref<1xi128, "plio">, %arg71: memref<1xi128, "stream">, %arg72: memref<1xi128, "plio">, %arg73: memref<1xi128, "stream">, %arg74: memref<1xi128, "plio">, %arg75: memref<1xi128, "stream">, %arg76: memref<1xi128, "plio">, %arg77: memref<1xi128, "stream">, %arg78: memref<1xi128, "plio">, %arg79: memref<1xi128, "stream">, %arg80: memref<1xi128, "plio">, %arg81: memref<1xi128, "stream">, %arg82: memref<1xi128, "plio">, %arg83: memref<1xi128, "stream">) attributes {adf.pl, inline = false} {
    call @receive27(%arg0, %arg1) {template = 0 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive27(%arg2, %arg3) {template = 1 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive27(%arg4, %arg5) {template = 2 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive27(%arg6, %arg7) {template = 3 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive27(%arg8, %arg9) {template = 4 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive27(%arg10, %arg11) {template = 5 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive27(%arg12, %arg13) {template = 6 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive27(%arg14, %arg15) {template = 7 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive27(%arg16, %arg17) {template = 8 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive27(%arg18, %arg19) {template = 9 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive27(%arg20, %arg21) {template = 10 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive27(%arg22, %arg23) {template = 11 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive27(%arg24, %arg25) {template = 12 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive27(%arg26, %arg27) {template = 13 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive27(%arg28, %arg29) {template = 14 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive27(%arg30, %arg31) {template = 15 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive27(%arg32, %arg33) {template = 16 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive27(%arg34, %arg35) {template = 17 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive27(%arg36, %arg37) {template = 18 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive27(%arg38, %arg39) {template = 19 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive27(%arg40, %arg41) {template = 20 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive27(%arg42, %arg43) {template = 21 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive27(%arg44, %arg45) {template = 22 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive27(%arg46, %arg47) {template = 23 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive27(%arg48, %arg49) {template = 24 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive27(%arg50, %arg51) {template = 25 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive27(%arg52, %arg53) {template = 26 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive27(%arg54, %arg55) {template = 27 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive27(%arg56, %arg57) {template = 28 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive27(%arg58, %arg59) {template = 29 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive27(%arg60, %arg61) {template = 30 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive27(%arg62, %arg63) {template = 31 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive27(%arg64, %arg65) {template = 32 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive27(%arg66, %arg67) {template = 33 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive27(%arg68, %arg69) {template = 34 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive27(%arg70, %arg71) {template = 35 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive27(%arg72, %arg73) {template = 36 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive27(%arg74, %arg75) {template = 37 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive27(%arg76, %arg77) {template = 38 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive27(%arg78, %arg79) {template = 39 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive27(%arg80, %arg81) {template = 40 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive27(%arg82, %arg83) {template = 41 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    return
  }
  func.func @store0_0(%arg0: memref<1xi128, "stream">, %arg1: memref<1xi512, "stream1">) attributes {adf.pl, inline = false, store, template} {
    %c0_i512 = arith.constant 0 : i512
    affine.for %arg2 = 0 to 1 {
      affine.for %arg3 = 0 to 1 {
        affine.for %arg4 = 0 to 8 {
          affine.for %arg5 = 0 to 32 {
            affine.for %arg6 = 0 to 8 {
              affine.for %arg7 = 0 to 1 {
                %0 = adf.int_to_apint(%c0_i512) : (i512) -> i512
                affine.for %arg8 = 0 to 4 {
                  %1 = affine.load %arg0[0] : memref<1xi128, "stream">
                  %2 = affine.apply #map(%arg8)
                  %3 = affine.apply #map1(%arg8)
                  adf.set_slice(%0 : i512, %2, %3, %1 : i128)
                } {pipeline_ii = 1 : index}
                affine.store %0, %arg1[0] : memref<1xi512, "stream1">
              } {pipeline_ii = 4 : index}
            }
          }
        }
      }
    }
    return
  }
  func.func @store0_0_top(%arg0: memref<1xi128, "stream">, %arg1: memref<1xi512, "stream1">, %arg2: memref<1xi128, "stream">, %arg3: memref<1xi512, "stream1">, %arg4: memref<1xi128, "stream">, %arg5: memref<1xi512, "stream1">, %arg6: memref<1xi128, "stream">, %arg7: memref<1xi512, "stream1">, %arg8: memref<1xi128, "stream">, %arg9: memref<1xi512, "stream1">, %arg10: memref<1xi128, "stream">, %arg11: memref<1xi512, "stream1">, %arg12: memref<1xi128, "stream">, %arg13: memref<1xi512, "stream1">, %arg14: memref<1xi128, "stream">, %arg15: memref<1xi512, "stream1">, %arg16: memref<1xi128, "stream">, %arg17: memref<1xi512, "stream1">, %arg18: memref<1xi128, "stream">, %arg19: memref<1xi512, "stream1">, %arg20: memref<1xi128, "stream">, %arg21: memref<1xi512, "stream1">, %arg22: memref<1xi128, "stream">, %arg23: memref<1xi512, "stream1">, %arg24: memref<1xi128, "stream">, %arg25: memref<1xi512, "stream1">, %arg26: memref<1xi128, "stream">, %arg27: memref<1xi512, "stream1">, %arg28: memref<1xi128, "stream">, %arg29: memref<1xi512, "stream1">, %arg30: memref<1xi128, "stream">, %arg31: memref<1xi512, "stream1">, %arg32: memref<1xi128, "stream">, %arg33: memref<1xi512, "stream1">, %arg34: memref<1xi128, "stream">, %arg35: memref<1xi512, "stream1">, %arg36: memref<1xi128, "stream">, %arg37: memref<1xi512, "stream1">, %arg38: memref<1xi128, "stream">, %arg39: memref<1xi512, "stream1">, %arg40: memref<1xi128, "stream">, %arg41: memref<1xi512, "stream1">, %arg42: memref<1xi128, "stream">, %arg43: memref<1xi512, "stream1">, %arg44: memref<1xi128, "stream">, %arg45: memref<1xi512, "stream1">, %arg46: memref<1xi128, "stream">, %arg47: memref<1xi512, "stream1">, %arg48: memref<1xi128, "stream">, %arg49: memref<1xi512, "stream1">, %arg50: memref<1xi128, "stream">, %arg51: memref<1xi512, "stream1">, %arg52: memref<1xi128, "stream">, %arg53: memref<1xi512, "stream1">, %arg54: memref<1xi128, "stream">, %arg55: memref<1xi512, "stream1">, %arg56: memref<1xi128, "stream">, %arg57: memref<1xi512, "stream1">, %arg58: memref<1xi128, "stream">, %arg59: memref<1xi512, "stream1">, %arg60: memref<1xi128, "stream">, %arg61: memref<1xi512, "stream1">, %arg62: memref<1xi128, "stream">, %arg63: memref<1xi512, "stream1">, %arg64: memref<1xi128, "stream">, %arg65: memref<1xi512, "stream1">, %arg66: memref<1xi128, "stream">, %arg67: memref<1xi512, "stream1">, %arg68: memref<1xi128, "stream">, %arg69: memref<1xi512, "stream1">, %arg70: memref<1xi128, "stream">, %arg71: memref<1xi512, "stream1">, %arg72: memref<1xi128, "stream">, %arg73: memref<1xi512, "stream1">, %arg74: memref<1xi128, "stream">, %arg75: memref<1xi512, "stream1">, %arg76: memref<1xi128, "stream">, %arg77: memref<1xi512, "stream1">, %arg78: memref<1xi128, "stream">, %arg79: memref<1xi512, "stream1">, %arg80: memref<1xi128, "stream">, %arg81: memref<1xi512, "stream1">, %arg82: memref<1xi128, "stream">, %arg83: memref<1xi512, "stream1">, %arg84: memref<1xi128, "stream">, %arg85: memref<1xi512, "stream1">, %arg86: memref<1xi128, "stream">, %arg87: memref<1xi512, "stream1">, %arg88: memref<1xi128, "stream">, %arg89: memref<1xi512, "stream1">, %arg90: memref<1xi128, "stream">, %arg91: memref<1xi512, "stream1">, %arg92: memref<1xi128, "stream">, %arg93: memref<1xi512, "stream1">, %arg94: memref<1xi128, "stream">, %arg95: memref<1xi512, "stream1">, %arg96: memref<1xi128, "stream">, %arg97: memref<1xi512, "stream1">, %arg98: memref<1xi128, "stream">, %arg99: memref<1xi512, "stream1">, %arg100: memref<1xi128, "stream">, %arg101: memref<1xi512, "stream1">, %arg102: memref<1xi128, "stream">, %arg103: memref<1xi512, "stream1">, %arg104: memref<1xi128, "stream">, %arg105: memref<1xi512, "stream1">, %arg106: memref<1xi128, "stream">, %arg107: memref<1xi512, "stream1">, %arg108: memref<1xi128, "stream">, %arg109: memref<1xi512, "stream1">, %arg110: memref<1xi128, "stream">, %arg111: memref<1xi512, "stream1">, %arg112: memref<1xi128, "stream">, %arg113: memref<1xi512, "stream1">, %arg114: memref<1xi128, "stream">, %arg115: memref<1xi512, "stream1">, %arg116: memref<1xi128, "stream">, %arg117: memref<1xi512, "stream1">, %arg118: memref<1xi128, "stream">, %arg119: memref<1xi512, "stream1">, %arg120: memref<1xi128, "stream">, %arg121: memref<1xi512, "stream1">, %arg122: memref<1xi128, "stream">, %arg123: memref<1xi512, "stream1">, %arg124: memref<1xi128, "stream">, %arg125: memref<1xi512, "stream1">, %arg126: memref<1xi128, "stream">, %arg127: memref<1xi512, "stream1">, %arg128: memref<1xi128, "stream">, %arg129: memref<1xi512, "stream1">, %arg130: memref<1xi128, "stream">, %arg131: memref<1xi512, "stream1">, %arg132: memref<1xi128, "stream">, %arg133: memref<1xi512, "stream1">, %arg134: memref<1xi128, "stream">, %arg135: memref<1xi512, "stream1">, %arg136: memref<1xi128, "stream">, %arg137: memref<1xi512, "stream1">, %arg138: memref<1xi128, "stream">, %arg139: memref<1xi512, "stream1">, %arg140: memref<1xi128, "stream">, %arg141: memref<1xi512, "stream1">, %arg142: memref<1xi128, "stream">, %arg143: memref<1xi512, "stream1">, %arg144: memref<1xi128, "stream">, %arg145: memref<1xi512, "stream1">, %arg146: memref<1xi128, "stream">, %arg147: memref<1xi512, "stream1">, %arg148: memref<1xi128, "stream">, %arg149: memref<1xi512, "stream1">, %arg150: memref<1xi128, "stream">, %arg151: memref<1xi512, "stream1">, %arg152: memref<1xi128, "stream">, %arg153: memref<1xi512, "stream1">, %arg154: memref<1xi128, "stream">, %arg155: memref<1xi512, "stream1">, %arg156: memref<1xi128, "stream">, %arg157: memref<1xi512, "stream1">, %arg158: memref<1xi128, "stream">, %arg159: memref<1xi512, "stream1">) attributes {adf.pl, inline = false} {
    call @store0_0(%arg0, %arg1) {template = 0 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg2, %arg3) {template = 1 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg4, %arg5) {template = 2 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg6, %arg7) {template = 3 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg8, %arg9) {template = 4 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg10, %arg11) {template = 5 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg12, %arg13) {template = 6 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg14, %arg15) {template = 7 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg16, %arg17) {template = 8 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg18, %arg19) {template = 9 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg20, %arg21) {template = 10 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg22, %arg23) {template = 11 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg24, %arg25) {template = 12 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg26, %arg27) {template = 13 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg28, %arg29) {template = 14 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg30, %arg31) {template = 15 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg32, %arg33) {template = 16 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg34, %arg35) {template = 17 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg36, %arg37) {template = 18 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg38, %arg39) {template = 19 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg40, %arg41) {template = 20 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg42, %arg43) {template = 21 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg44, %arg45) {template = 22 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg46, %arg47) {template = 23 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg48, %arg49) {template = 24 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg50, %arg51) {template = 25 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg52, %arg53) {template = 26 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg54, %arg55) {template = 27 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg56, %arg57) {template = 28 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg58, %arg59) {template = 29 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg60, %arg61) {template = 30 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg62, %arg63) {template = 31 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg64, %arg65) {template = 32 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg66, %arg67) {template = 33 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg68, %arg69) {template = 34 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg70, %arg71) {template = 35 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg72, %arg73) {template = 36 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg74, %arg75) {template = 37 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg76, %arg77) {template = 38 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg78, %arg79) {template = 39 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg80, %arg81) {template = 40 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg82, %arg83) {template = 41 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg84, %arg85) {template = 42 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg86, %arg87) {template = 43 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg88, %arg89) {template = 44 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg90, %arg91) {template = 45 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg92, %arg93) {template = 46 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg94, %arg95) {template = 47 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg96, %arg97) {template = 48 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg98, %arg99) {template = 49 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg100, %arg101) {template = 50 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg102, %arg103) {template = 51 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg104, %arg105) {template = 52 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg106, %arg107) {template = 53 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg108, %arg109) {template = 54 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg110, %arg111) {template = 55 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg112, %arg113) {template = 56 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg114, %arg115) {template = 57 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg116, %arg117) {template = 58 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg118, %arg119) {template = 59 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg120, %arg121) {template = 60 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg122, %arg123) {template = 61 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg124, %arg125) {template = 62 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg126, %arg127) {template = 63 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg128, %arg129) {template = 64 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg130, %arg131) {template = 65 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg132, %arg133) {template = 66 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg134, %arg135) {template = 67 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg136, %arg137) {template = 68 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg138, %arg139) {template = 69 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg140, %arg141) {template = 70 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg142, %arg143) {template = 71 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg144, %arg145) {template = 72 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg146, %arg147) {template = 73 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg148, %arg149) {template = 74 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg150, %arg151) {template = 75 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg152, %arg153) {template = 76 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg154, %arg155) {template = 77 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg156, %arg157) {template = 78 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg158, %arg159) {template = 79 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    return
  }
  func.func @store0(%arg0: memref<1xi512, "stream1">, %arg1: memref<1xi512, "stream1">, %arg2: memref<1xi512, "stream1">, %arg3: memref<1xi512, "stream1">, %arg4: memref<2560x64xi512>, %arg5: memref<1xi512, "stream1">, %arg6: memref<1xi512, "stream1">, %arg7: memref<1xi512, "stream1">, %arg8: memref<1xi512, "stream1">, %arg9: memref<1xi512, "stream1">, %arg10: memref<1xi512, "stream1">, %arg11: memref<1xi512, "stream1">, %arg12: memref<1xi512, "stream1">, %arg13: memref<1xi512, "stream1">, %arg14: memref<1xi512, "stream1">, %arg15: memref<1xi512, "stream1">, %arg16: memref<1xi512, "stream1">, %arg17: memref<1xi512, "stream1">, %arg18: memref<1xi512, "stream1">, %arg19: memref<1xi512, "stream1">, %arg20: memref<1xi512, "stream1">, %arg21: memref<1xi512, "stream1">, %arg22: memref<1xi512, "stream1">, %arg23: memref<1xi512, "stream1">, %arg24: memref<1xi512, "stream1">, %arg25: memref<1xi512, "stream1">, %arg26: memref<1xi512, "stream1">, %arg27: memref<1xi512, "stream1">, %arg28: memref<1xi512, "stream1">, %arg29: memref<1xi512, "stream1">, %arg30: memref<1xi512, "stream1">, %arg31: memref<1xi512, "stream1">, %arg32: memref<1xi512, "stream1">, %arg33: memref<1xi512, "stream1">, %arg34: memref<1xi512, "stream1">, %arg35: memref<1xi512, "stream1">, %arg36: memref<1xi512, "stream1">, %arg37: memref<1xi512, "stream1">, %arg38: memref<1xi512, "stream1">, %arg39: memref<1xi512, "stream1">, %arg40: memref<1xi512, "stream1">, %arg41: memref<1xi512, "stream1">, %arg42: memref<1xi512, "stream1">, %arg43: memref<1xi512, "stream1">, %arg44: memref<1xi512, "stream1">, %arg45: memref<1xi512, "stream1">, %arg46: memref<1xi512, "stream1">, %arg47: memref<1xi512, "stream1">, %arg48: memref<1xi512, "stream1">, %arg49: memref<1xi512, "stream1">, %arg50: memref<1xi512, "stream1">, %arg51: memref<1xi512, "stream1">, %arg52: memref<1xi512, "stream1">, %arg53: memref<1xi512, "stream1">, %arg54: memref<1xi512, "stream1">, %arg55: memref<1xi512, "stream1">, %arg56: memref<1xi512, "stream1">, %arg57: memref<1xi512, "stream1">, %arg58: memref<1xi512, "stream1">, %arg59: memref<1xi512, "stream1">, %arg60: memref<1xi512, "stream1">, %arg61: memref<1xi512, "stream1">, %arg62: memref<1xi512, "stream1">, %arg63: memref<1xi512, "stream1">, %arg64: memref<1xi512, "stream1">, %arg65: memref<1xi512, "stream1">, %arg66: memref<1xi512, "stream1">, %arg67: memref<1xi512, "stream1">, %arg68: memref<1xi512, "stream1">, %arg69: memref<1xi512, "stream1">, %arg70: memref<1xi512, "stream1">, %arg71: memref<1xi512, "stream1">, %arg72: memref<1xi512, "stream1">, %arg73: memref<1xi512, "stream1">, %arg74: memref<1xi512, "stream1">, %arg75: memref<1xi512, "stream1">, %arg76: memref<1xi512, "stream1">, %arg77: memref<1xi512, "stream1">, %arg78: memref<1xi512, "stream1">, %arg79: memref<1xi512, "stream1">, %arg80: memref<1xi512, "stream1">) attributes {adf.pl, inline = false, mem_idx = [4 : i32], mem_type = [i8], store, template} {
    %c7 = arith.constant 7 : index
    %c6 = arith.constant 6 : index
    %c5 = arith.constant 5 : index
    %c4 = arith.constant 4 : index
    %c3 = arith.constant 3 : index
    %c2 = arith.constant 2 : index
    %c1 = arith.constant 1 : index
    affine.for %arg81 = 0 to 1 {
      affine.for %arg82 = 0 to 1 {
        affine.for %arg83 = 0 to 8 {
          affine.for %arg84 = 0 to 32 {
            affine.for %arg85 = 0 to 8 {
              affine.for %arg86 = 0 to 8 {
                %0 = arith.cmpi slt, %arg86, %c1 : index
                %1 = scf.if %0 -> (i512) {
                  %2 = affine.load %arg33[0] : memref<1xi512, "stream1">
                  scf.yield %2 : i512
                } else {
                  %2 = arith.cmpi slt, %arg86, %c2 : index
                  %3 = scf.if %2 -> (i512) {
                    %4 = affine.load %arg72[0] : memref<1xi512, "stream1">
                    scf.yield %4 : i512
                  } else {
                    %4 = arith.cmpi slt, %arg86, %c3 : index
                    %5 = scf.if %4 -> (i512) {
                      %6 = affine.load %arg41[0] : memref<1xi512, "stream1">
                      scf.yield %6 : i512
                    } else {
                      %6 = arith.cmpi slt, %arg86, %c4 : index
                      %7 = scf.if %6 -> (i512) {
                        %8 = affine.load %arg3[0] : memref<1xi512, "stream1">
                        scf.yield %8 : i512
                      } else {
                        %8 = arith.cmpi slt, %arg86, %c5 : index
                        %9 = scf.if %8 -> (i512) {
                          %10 = affine.load %arg70[0] : memref<1xi512, "stream1">
                          scf.yield %10 : i512
                        } else {
                          %10 = arith.cmpi slt, %arg86, %c6 : index
                          %11 = scf.if %10 -> (i512) {
                            %12 = affine.load %arg79[0] : memref<1xi512, "stream1">
                            scf.yield %12 : i512
                          } else {
                            %12 = arith.cmpi slt, %arg86, %c7 : index
                            %13 = scf.if %12 -> (i512) {
                              %14 = affine.load %arg12[0] : memref<1xi512, "stream1">
                              scf.yield %14 : i512
                            } else {
                              %14 = affine.load %arg29[0] : memref<1xi512, "stream1">
                              scf.yield %14 : i512
                            }
                            scf.yield %13 : i512
                          }
                          scf.yield %11 : i512
                        }
                        scf.yield %9 : i512
                      }
                      scf.yield %7 : i512
                    }
                    scf.yield %5 : i512
                  }
                  scf.yield %3 : i512
                }
                affine.store %1, %arg4[%arg84 + %arg83 * 320 + %arg81 * 2560, %arg86 + %arg85 * 8 + %arg82 * 64] : memref<2560x64xi512>
              } {pipeline_ii = 1 : index}
            }
          }
        } {merge}
        affine.for %arg83 = 0 to 8 {
          affine.for %arg84 = 0 to 32 {
            affine.for %arg85 = 0 to 8 {
              affine.for %arg86 = 0 to 8 {
                %0 = arith.cmpi slt, %arg86, %c1 : index
                %1 = scf.if %0 -> (i512) {
                  %2 = affine.load %arg48[0] : memref<1xi512, "stream1">
                  scf.yield %2 : i512
                } else {
                  %2 = arith.cmpi slt, %arg86, %c2 : index
                  %3 = scf.if %2 -> (i512) {
                    %4 = affine.load %arg58[0] : memref<1xi512, "stream1">
                    scf.yield %4 : i512
                  } else {
                    %4 = arith.cmpi slt, %arg86, %c3 : index
                    %5 = scf.if %4 -> (i512) {
                      %6 = affine.load %arg74[0] : memref<1xi512, "stream1">
                      scf.yield %6 : i512
                    } else {
                      %6 = arith.cmpi slt, %arg86, %c4 : index
                      %7 = scf.if %6 -> (i512) {
                        %8 = affine.load %arg52[0] : memref<1xi512, "stream1">
                        scf.yield %8 : i512
                      } else {
                        %8 = arith.cmpi slt, %arg86, %c5 : index
                        %9 = scf.if %8 -> (i512) {
                          %10 = affine.load %arg34[0] : memref<1xi512, "stream1">
                          scf.yield %10 : i512
                        } else {
                          %10 = arith.cmpi slt, %arg86, %c6 : index
                          %11 = scf.if %10 -> (i512) {
                            %12 = affine.load %arg5[0] : memref<1xi512, "stream1">
                            scf.yield %12 : i512
                          } else {
                            %12 = arith.cmpi slt, %arg86, %c7 : index
                            %13 = scf.if %12 -> (i512) {
                              %14 = affine.load %arg55[0] : memref<1xi512, "stream1">
                              scf.yield %14 : i512
                            } else {
                              %14 = affine.load %arg57[0] : memref<1xi512, "stream1">
                              scf.yield %14 : i512
                            }
                            scf.yield %13 : i512
                          }
                          scf.yield %11 : i512
                        }
                        scf.yield %9 : i512
                      }
                      scf.yield %7 : i512
                    }
                    scf.yield %5 : i512
                  }
                  scf.yield %3 : i512
                }
                affine.store %1, %arg4[%arg84 + %arg83 * 320 + %arg81 * 2560 + 32, %arg86 + %arg85 * 8 + %arg82 * 64] : memref<2560x64xi512>
              } {pipeline_ii = 1 : index}
            }
          }
        } {merge}
        affine.for %arg83 = 0 to 8 {
          affine.for %arg84 = 0 to 32 {
            affine.for %arg85 = 0 to 8 {
              affine.for %arg86 = 0 to 8 {
                %0 = arith.cmpi slt, %arg86, %c1 : index
                %1 = scf.if %0 -> (i512) {
                  %2 = affine.load %arg2[0] : memref<1xi512, "stream1">
                  scf.yield %2 : i512
                } else {
                  %2 = arith.cmpi slt, %arg86, %c2 : index
                  %3 = scf.if %2 -> (i512) {
                    %4 = affine.load %arg22[0] : memref<1xi512, "stream1">
                    scf.yield %4 : i512
                  } else {
                    %4 = arith.cmpi slt, %arg86, %c3 : index
                    %5 = scf.if %4 -> (i512) {
                      %6 = affine.load %arg11[0] : memref<1xi512, "stream1">
                      scf.yield %6 : i512
                    } else {
                      %6 = arith.cmpi slt, %arg86, %c4 : index
                      %7 = scf.if %6 -> (i512) {
                        %8 = affine.load %arg49[0] : memref<1xi512, "stream1">
                        scf.yield %8 : i512
                      } else {
                        %8 = arith.cmpi slt, %arg86, %c5 : index
                        %9 = scf.if %8 -> (i512) {
                          %10 = affine.load %arg23[0] : memref<1xi512, "stream1">
                          scf.yield %10 : i512
                        } else {
                          %10 = arith.cmpi slt, %arg86, %c6 : index
                          %11 = scf.if %10 -> (i512) {
                            %12 = affine.load %arg80[0] : memref<1xi512, "stream1">
                            scf.yield %12 : i512
                          } else {
                            %12 = arith.cmpi slt, %arg86, %c7 : index
                            %13 = scf.if %12 -> (i512) {
                              %14 = affine.load %arg24[0] : memref<1xi512, "stream1">
                              scf.yield %14 : i512
                            } else {
                              %14 = affine.load %arg67[0] : memref<1xi512, "stream1">
                              scf.yield %14 : i512
                            }
                            scf.yield %13 : i512
                          }
                          scf.yield %11 : i512
                        }
                        scf.yield %9 : i512
                      }
                      scf.yield %7 : i512
                    }
                    scf.yield %5 : i512
                  }
                  scf.yield %3 : i512
                }
                affine.store %1, %arg4[%arg84 + %arg83 * 320 + %arg81 * 2560 + 64, %arg86 + %arg85 * 8 + %arg82 * 64] : memref<2560x64xi512>
              } {pipeline_ii = 1 : index}
            }
          }
        } {merge}
        affine.for %arg83 = 0 to 8 {
          affine.for %arg84 = 0 to 32 {
            affine.for %arg85 = 0 to 8 {
              affine.for %arg86 = 0 to 8 {
                %0 = arith.cmpi slt, %arg86, %c1 : index
                %1 = scf.if %0 -> (i512) {
                  %2 = affine.load %arg47[0] : memref<1xi512, "stream1">
                  scf.yield %2 : i512
                } else {
                  %2 = arith.cmpi slt, %arg86, %c2 : index
                  %3 = scf.if %2 -> (i512) {
                    %4 = affine.load %arg75[0] : memref<1xi512, "stream1">
                    scf.yield %4 : i512
                  } else {
                    %4 = arith.cmpi slt, %arg86, %c3 : index
                    %5 = scf.if %4 -> (i512) {
                      %6 = affine.load %arg39[0] : memref<1xi512, "stream1">
                      scf.yield %6 : i512
                    } else {
                      %6 = arith.cmpi slt, %arg86, %c4 : index
                      %7 = scf.if %6 -> (i512) {
                        %8 = affine.load %arg46[0] : memref<1xi512, "stream1">
                        scf.yield %8 : i512
                      } else {
                        %8 = arith.cmpi slt, %arg86, %c5 : index
                        %9 = scf.if %8 -> (i512) {
                          %10 = affine.load %arg73[0] : memref<1xi512, "stream1">
                          scf.yield %10 : i512
                        } else {
                          %10 = arith.cmpi slt, %arg86, %c6 : index
                          %11 = scf.if %10 -> (i512) {
                            %12 = affine.load %arg20[0] : memref<1xi512, "stream1">
                            scf.yield %12 : i512
                          } else {
                            %12 = arith.cmpi slt, %arg86, %c7 : index
                            %13 = scf.if %12 -> (i512) {
                              %14 = affine.load %arg15[0] : memref<1xi512, "stream1">
                              scf.yield %14 : i512
                            } else {
                              %14 = affine.load %arg1[0] : memref<1xi512, "stream1">
                              scf.yield %14 : i512
                            }
                            scf.yield %13 : i512
                          }
                          scf.yield %11 : i512
                        }
                        scf.yield %9 : i512
                      }
                      scf.yield %7 : i512
                    }
                    scf.yield %5 : i512
                  }
                  scf.yield %3 : i512
                }
                affine.store %1, %arg4[%arg84 + %arg83 * 320 + %arg81 * 2560 + 96, %arg86 + %arg85 * 8 + %arg82 * 64] : memref<2560x64xi512>
              } {pipeline_ii = 1 : index}
            }
          }
        } {merge}
        affine.for %arg83 = 0 to 8 {
          affine.for %arg84 = 0 to 32 {
            affine.for %arg85 = 0 to 8 {
              affine.for %arg86 = 0 to 8 {
                %0 = arith.cmpi slt, %arg86, %c1 : index
                %1 = scf.if %0 -> (i512) {
                  %2 = affine.load %arg30[0] : memref<1xi512, "stream1">
                  scf.yield %2 : i512
                } else {
                  %2 = arith.cmpi slt, %arg86, %c2 : index
                  %3 = scf.if %2 -> (i512) {
                    %4 = affine.load %arg0[0] : memref<1xi512, "stream1">
                    scf.yield %4 : i512
                  } else {
                    %4 = arith.cmpi slt, %arg86, %c3 : index
                    %5 = scf.if %4 -> (i512) {
                      %6 = affine.load %arg77[0] : memref<1xi512, "stream1">
                      scf.yield %6 : i512
                    } else {
                      %6 = arith.cmpi slt, %arg86, %c4 : index
                      %7 = scf.if %6 -> (i512) {
                        %8 = affine.load %arg76[0] : memref<1xi512, "stream1">
                        scf.yield %8 : i512
                      } else {
                        %8 = arith.cmpi slt, %arg86, %c5 : index
                        %9 = scf.if %8 -> (i512) {
                          %10 = affine.load %arg42[0] : memref<1xi512, "stream1">
                          scf.yield %10 : i512
                        } else {
                          %10 = arith.cmpi slt, %arg86, %c6 : index
                          %11 = scf.if %10 -> (i512) {
                            %12 = affine.load %arg7[0] : memref<1xi512, "stream1">
                            scf.yield %12 : i512
                          } else {
                            %12 = arith.cmpi slt, %arg86, %c7 : index
                            %13 = scf.if %12 -> (i512) {
                              %14 = affine.load %arg56[0] : memref<1xi512, "stream1">
                              scf.yield %14 : i512
                            } else {
                              %14 = affine.load %arg63[0] : memref<1xi512, "stream1">
                              scf.yield %14 : i512
                            }
                            scf.yield %13 : i512
                          }
                          scf.yield %11 : i512
                        }
                        scf.yield %9 : i512
                      }
                      scf.yield %7 : i512
                    }
                    scf.yield %5 : i512
                  }
                  scf.yield %3 : i512
                }
                affine.store %1, %arg4[%arg84 + %arg83 * 320 + %arg81 * 2560 + 128, %arg86 + %arg85 * 8 + %arg82 * 64] : memref<2560x64xi512>
              } {pipeline_ii = 1 : index}
            }
          }
        } {merge}
        affine.for %arg83 = 0 to 8 {
          affine.for %arg84 = 0 to 32 {
            affine.for %arg85 = 0 to 8 {
              affine.for %arg86 = 0 to 8 {
                %0 = arith.cmpi slt, %arg86, %c1 : index
                %1 = scf.if %0 -> (i512) {
                  %2 = affine.load %arg59[0] : memref<1xi512, "stream1">
                  scf.yield %2 : i512
                } else {
                  %2 = arith.cmpi slt, %arg86, %c2 : index
                  %3 = scf.if %2 -> (i512) {
                    %4 = affine.load %arg6[0] : memref<1xi512, "stream1">
                    scf.yield %4 : i512
                  } else {
                    %4 = arith.cmpi slt, %arg86, %c3 : index
                    %5 = scf.if %4 -> (i512) {
                      %6 = affine.load %arg43[0] : memref<1xi512, "stream1">
                      scf.yield %6 : i512
                    } else {
                      %6 = arith.cmpi slt, %arg86, %c4 : index
                      %7 = scf.if %6 -> (i512) {
                        %8 = affine.load %arg62[0] : memref<1xi512, "stream1">
                        scf.yield %8 : i512
                      } else {
                        %8 = arith.cmpi slt, %arg86, %c5 : index
                        %9 = scf.if %8 -> (i512) {
                          %10 = affine.load %arg69[0] : memref<1xi512, "stream1">
                          scf.yield %10 : i512
                        } else {
                          %10 = arith.cmpi slt, %arg86, %c6 : index
                          %11 = scf.if %10 -> (i512) {
                            %12 = affine.load %arg16[0] : memref<1xi512, "stream1">
                            scf.yield %12 : i512
                          } else {
                            %12 = arith.cmpi slt, %arg86, %c7 : index
                            %13 = scf.if %12 -> (i512) {
                              %14 = affine.load %arg60[0] : memref<1xi512, "stream1">
                              scf.yield %14 : i512
                            } else {
                              %14 = affine.load %arg14[0] : memref<1xi512, "stream1">
                              scf.yield %14 : i512
                            }
                            scf.yield %13 : i512
                          }
                          scf.yield %11 : i512
                        }
                        scf.yield %9 : i512
                      }
                      scf.yield %7 : i512
                    }
                    scf.yield %5 : i512
                  }
                  scf.yield %3 : i512
                }
                affine.store %1, %arg4[%arg84 + %arg83 * 320 + %arg81 * 2560 + 160, %arg86 + %arg85 * 8 + %arg82 * 64] : memref<2560x64xi512>
              } {pipeline_ii = 1 : index}
            }
          }
        } {merge}
        affine.for %arg83 = 0 to 8 {
          affine.for %arg84 = 0 to 32 {
            affine.for %arg85 = 0 to 8 {
              affine.for %arg86 = 0 to 8 {
                %0 = arith.cmpi slt, %arg86, %c1 : index
                %1 = scf.if %0 -> (i512) {
                  %2 = affine.load %arg13[0] : memref<1xi512, "stream1">
                  scf.yield %2 : i512
                } else {
                  %2 = arith.cmpi slt, %arg86, %c2 : index
                  %3 = scf.if %2 -> (i512) {
                    %4 = affine.load %arg68[0] : memref<1xi512, "stream1">
                    scf.yield %4 : i512
                  } else {
                    %4 = arith.cmpi slt, %arg86, %c3 : index
                    %5 = scf.if %4 -> (i512) {
                      %6 = affine.load %arg26[0] : memref<1xi512, "stream1">
                      scf.yield %6 : i512
                    } else {
                      %6 = arith.cmpi slt, %arg86, %c4 : index
                      %7 = scf.if %6 -> (i512) {
                        %8 = affine.load %arg38[0] : memref<1xi512, "stream1">
                        scf.yield %8 : i512
                      } else {
                        %8 = arith.cmpi slt, %arg86, %c5 : index
                        %9 = scf.if %8 -> (i512) {
                          %10 = affine.load %arg21[0] : memref<1xi512, "stream1">
                          scf.yield %10 : i512
                        } else {
                          %10 = arith.cmpi slt, %arg86, %c6 : index
                          %11 = scf.if %10 -> (i512) {
                            %12 = affine.load %arg28[0] : memref<1xi512, "stream1">
                            scf.yield %12 : i512
                          } else {
                            %12 = arith.cmpi slt, %arg86, %c7 : index
                            %13 = scf.if %12 -> (i512) {
                              %14 = affine.load %arg18[0] : memref<1xi512, "stream1">
                              scf.yield %14 : i512
                            } else {
                              %14 = affine.load %arg51[0] : memref<1xi512, "stream1">
                              scf.yield %14 : i512
                            }
                            scf.yield %13 : i512
                          }
                          scf.yield %11 : i512
                        }
                        scf.yield %9 : i512
                      }
                      scf.yield %7 : i512
                    }
                    scf.yield %5 : i512
                  }
                  scf.yield %3 : i512
                }
                affine.store %1, %arg4[%arg84 + %arg83 * 320 + %arg81 * 2560 + 192, %arg86 + %arg85 * 8 + %arg82 * 64] : memref<2560x64xi512>
              } {pipeline_ii = 1 : index}
            }
          }
        } {merge}
        affine.for %arg83 = 0 to 8 {
          affine.for %arg84 = 0 to 32 {
            affine.for %arg85 = 0 to 8 {
              affine.for %arg86 = 0 to 8 {
                %0 = arith.cmpi slt, %arg86, %c1 : index
                %1 = scf.if %0 -> (i512) {
                  %2 = affine.load %arg65[0] : memref<1xi512, "stream1">
                  scf.yield %2 : i512
                } else {
                  %2 = arith.cmpi slt, %arg86, %c2 : index
                  %3 = scf.if %2 -> (i512) {
                    %4 = affine.load %arg17[0] : memref<1xi512, "stream1">
                    scf.yield %4 : i512
                  } else {
                    %4 = arith.cmpi slt, %arg86, %c3 : index
                    %5 = scf.if %4 -> (i512) {
                      %6 = affine.load %arg61[0] : memref<1xi512, "stream1">
                      scf.yield %6 : i512
                    } else {
                      %6 = arith.cmpi slt, %arg86, %c4 : index
                      %7 = scf.if %6 -> (i512) {
                        %8 = affine.load %arg8[0] : memref<1xi512, "stream1">
                        scf.yield %8 : i512
                      } else {
                        %8 = arith.cmpi slt, %arg86, %c5 : index
                        %9 = scf.if %8 -> (i512) {
                          %10 = affine.load %arg32[0] : memref<1xi512, "stream1">
                          scf.yield %10 : i512
                        } else {
                          %10 = arith.cmpi slt, %arg86, %c6 : index
                          %11 = scf.if %10 -> (i512) {
                            %12 = affine.load %arg27[0] : memref<1xi512, "stream1">
                            scf.yield %12 : i512
                          } else {
                            %12 = arith.cmpi slt, %arg86, %c7 : index
                            %13 = scf.if %12 -> (i512) {
                              %14 = affine.load %arg10[0] : memref<1xi512, "stream1">
                              scf.yield %14 : i512
                            } else {
                              %14 = affine.load %arg78[0] : memref<1xi512, "stream1">
                              scf.yield %14 : i512
                            }
                            scf.yield %13 : i512
                          }
                          scf.yield %11 : i512
                        }
                        scf.yield %9 : i512
                      }
                      scf.yield %7 : i512
                    }
                    scf.yield %5 : i512
                  }
                  scf.yield %3 : i512
                }
                affine.store %1, %arg4[%arg84 + %arg83 * 320 + %arg81 * 2560 + 224, %arg86 + %arg85 * 8 + %arg82 * 64] : memref<2560x64xi512>
              } {pipeline_ii = 1 : index}
            }
          }
        } {merge}
        affine.for %arg83 = 0 to 8 {
          affine.for %arg84 = 0 to 32 {
            affine.for %arg85 = 0 to 8 {
              affine.for %arg86 = 0 to 8 {
                %0 = arith.cmpi slt, %arg86, %c1 : index
                %1 = scf.if %0 -> (i512) {
                  %2 = affine.load %arg31[0] : memref<1xi512, "stream1">
                  scf.yield %2 : i512
                } else {
                  %2 = arith.cmpi slt, %arg86, %c2 : index
                  %3 = scf.if %2 -> (i512) {
                    %4 = affine.load %arg44[0] : memref<1xi512, "stream1">
                    scf.yield %4 : i512
                  } else {
                    %4 = arith.cmpi slt, %arg86, %c3 : index
                    %5 = scf.if %4 -> (i512) {
                      %6 = affine.load %arg45[0] : memref<1xi512, "stream1">
                      scf.yield %6 : i512
                    } else {
                      %6 = arith.cmpi slt, %arg86, %c4 : index
                      %7 = scf.if %6 -> (i512) {
                        %8 = affine.load %arg9[0] : memref<1xi512, "stream1">
                        scf.yield %8 : i512
                      } else {
                        %8 = arith.cmpi slt, %arg86, %c5 : index
                        %9 = scf.if %8 -> (i512) {
                          %10 = affine.load %arg66[0] : memref<1xi512, "stream1">
                          scf.yield %10 : i512
                        } else {
                          %10 = arith.cmpi slt, %arg86, %c6 : index
                          %11 = scf.if %10 -> (i512) {
                            %12 = affine.load %arg35[0] : memref<1xi512, "stream1">
                            scf.yield %12 : i512
                          } else {
                            %12 = arith.cmpi slt, %arg86, %c7 : index
                            %13 = scf.if %12 -> (i512) {
                              %14 = affine.load %arg71[0] : memref<1xi512, "stream1">
                              scf.yield %14 : i512
                            } else {
                              %14 = affine.load %arg25[0] : memref<1xi512, "stream1">
                              scf.yield %14 : i512
                            }
                            scf.yield %13 : i512
                          }
                          scf.yield %11 : i512
                        }
                        scf.yield %9 : i512
                      }
                      scf.yield %7 : i512
                    }
                    scf.yield %5 : i512
                  }
                  scf.yield %3 : i512
                }
                affine.store %1, %arg4[%arg84 + %arg83 * 320 + %arg81 * 2560 + 256, %arg86 + %arg85 * 8 + %arg82 * 64] : memref<2560x64xi512>
              } {pipeline_ii = 1 : index}
            }
          }
        } {merge}
        affine.for %arg83 = 0 to 8 {
          affine.for %arg84 = 0 to 32 {
            affine.for %arg85 = 0 to 8 {
              affine.for %arg86 = 0 to 8 {
                %0 = arith.cmpi slt, %arg86, %c1 : index
                %1 = scf.if %0 -> (i512) {
                  %2 = affine.load %arg64[0] : memref<1xi512, "stream1">
                  scf.yield %2 : i512
                } else {
                  %2 = arith.cmpi slt, %arg86, %c2 : index
                  %3 = scf.if %2 -> (i512) {
                    %4 = affine.load %arg50[0] : memref<1xi512, "stream1">
                    scf.yield %4 : i512
                  } else {
                    %4 = arith.cmpi slt, %arg86, %c3 : index
                    %5 = scf.if %4 -> (i512) {
                      %6 = affine.load %arg19[0] : memref<1xi512, "stream1">
                      scf.yield %6 : i512
                    } else {
                      %6 = arith.cmpi slt, %arg86, %c4 : index
                      %7 = scf.if %6 -> (i512) {
                        %8 = affine.load %arg40[0] : memref<1xi512, "stream1">
                        scf.yield %8 : i512
                      } else {
                        %8 = arith.cmpi slt, %arg86, %c5 : index
                        %9 = scf.if %8 -> (i512) {
                          %10 = affine.load %arg53[0] : memref<1xi512, "stream1">
                          scf.yield %10 : i512
                        } else {
                          %10 = arith.cmpi slt, %arg86, %c6 : index
                          %11 = scf.if %10 -> (i512) {
                            %12 = affine.load %arg36[0] : memref<1xi512, "stream1">
                            scf.yield %12 : i512
                          } else {
                            %12 = arith.cmpi slt, %arg86, %c7 : index
                            %13 = scf.if %12 -> (i512) {
                              %14 = affine.load %arg54[0] : memref<1xi512, "stream1">
                              scf.yield %14 : i512
                            } else {
                              %14 = affine.load %arg37[0] : memref<1xi512, "stream1">
                              scf.yield %14 : i512
                            }
                            scf.yield %13 : i512
                          }
                          scf.yield %11 : i512
                        }
                        scf.yield %9 : i512
                      }
                      scf.yield %7 : i512
                    }
                    scf.yield %5 : i512
                  }
                  scf.yield %3 : i512
                }
                affine.store %1, %arg4[%arg84 + %arg83 * 320 + %arg81 * 2560 + 288, %arg86 + %arg85 * 8 + %arg82 * 64] : memref<2560x64xi512>
              } {pipeline_ii = 1 : index}
            }
          }
        } {merge}
      }
    }
    return
  }
  func.func @store0_top(%arg0: memref<1xi512, "stream1">, %arg1: memref<1xi512, "stream1">, %arg2: memref<1xi512, "stream1">, %arg3: memref<1xi512, "stream1">, %arg4: memref<2560x64xi512>, %arg5: memref<1xi512, "stream1">, %arg6: memref<1xi512, "stream1">, %arg7: memref<1xi512, "stream1">, %arg8: memref<1xi512, "stream1">, %arg9: memref<1xi512, "stream1">, %arg10: memref<1xi512, "stream1">, %arg11: memref<1xi512, "stream1">, %arg12: memref<1xi512, "stream1">, %arg13: memref<1xi512, "stream1">, %arg14: memref<1xi512, "stream1">, %arg15: memref<1xi512, "stream1">, %arg16: memref<1xi512, "stream1">, %arg17: memref<1xi512, "stream1">, %arg18: memref<1xi512, "stream1">, %arg19: memref<1xi512, "stream1">, %arg20: memref<1xi512, "stream1">, %arg21: memref<1xi512, "stream1">, %arg22: memref<1xi512, "stream1">, %arg23: memref<1xi512, "stream1">, %arg24: memref<1xi512, "stream1">, %arg25: memref<1xi512, "stream1">, %arg26: memref<1xi512, "stream1">, %arg27: memref<1xi512, "stream1">, %arg28: memref<1xi512, "stream1">, %arg29: memref<1xi512, "stream1">, %arg30: memref<1xi512, "stream1">, %arg31: memref<1xi512, "stream1">, %arg32: memref<1xi512, "stream1">, %arg33: memref<1xi512, "stream1">, %arg34: memref<1xi512, "stream1">, %arg35: memref<1xi512, "stream1">, %arg36: memref<1xi512, "stream1">, %arg37: memref<1xi512, "stream1">, %arg38: memref<1xi512, "stream1">, %arg39: memref<1xi512, "stream1">, %arg40: memref<1xi512, "stream1">, %arg41: memref<1xi512, "stream1">, %arg42: memref<1xi512, "stream1">, %arg43: memref<1xi512, "stream1">, %arg44: memref<1xi512, "stream1">, %arg45: memref<1xi512, "stream1">, %arg46: memref<1xi512, "stream1">, %arg47: memref<1xi512, "stream1">, %arg48: memref<1xi512, "stream1">, %arg49: memref<1xi512, "stream1">, %arg50: memref<1xi512, "stream1">, %arg51: memref<1xi512, "stream1">, %arg52: memref<1xi512, "stream1">, %arg53: memref<1xi512, "stream1">, %arg54: memref<1xi512, "stream1">, %arg55: memref<1xi512, "stream1">, %arg56: memref<1xi512, "stream1">, %arg57: memref<1xi512, "stream1">, %arg58: memref<1xi512, "stream1">, %arg59: memref<1xi512, "stream1">, %arg60: memref<1xi512, "stream1">, %arg61: memref<1xi512, "stream1">, %arg62: memref<1xi512, "stream1">, %arg63: memref<1xi512, "stream1">, %arg64: memref<1xi512, "stream1">, %arg65: memref<1xi512, "stream1">, %arg66: memref<1xi512, "stream1">, %arg67: memref<1xi512, "stream1">, %arg68: memref<1xi512, "stream1">, %arg69: memref<1xi512, "stream1">, %arg70: memref<1xi512, "stream1">, %arg71: memref<1xi512, "stream1">, %arg72: memref<1xi512, "stream1">, %arg73: memref<1xi512, "stream1">, %arg74: memref<1xi512, "stream1">, %arg75: memref<1xi512, "stream1">, %arg76: memref<1xi512, "stream1">, %arg77: memref<1xi512, "stream1">, %arg78: memref<1xi512, "stream1">, %arg79: memref<1xi512, "stream1">, %arg80: memref<1xi512, "stream1">) attributes {adf.pl, inline = false} {
    call @store0(%arg0, %arg1, %arg2, %arg3, %arg4, %arg5, %arg6, %arg7, %arg8, %arg9, %arg10, %arg11, %arg12, %arg13, %arg14, %arg15, %arg16, %arg17, %arg18, %arg19, %arg20, %arg21, %arg22, %arg23, %arg24, %arg25, %arg26, %arg27, %arg28, %arg29, %arg30, %arg31, %arg32, %arg33, %arg34, %arg35, %arg36, %arg37, %arg38, %arg39, %arg40, %arg41, %arg42, %arg43, %arg44, %arg45, %arg46, %arg47, %arg48, %arg49, %arg50, %arg51, %arg52, %arg53, %arg54, %arg55, %arg56, %arg57, %arg58, %arg59, %arg60, %arg61, %arg62, %arg63, %arg64, %arg65, %arg66, %arg67, %arg68, %arg69, %arg70, %arg71, %arg72, %arg73, %arg74, %arg75, %arg76, %arg77, %arg78, %arg79, %arg80) {template = 0 : index} : (memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<2560x64xi512>, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">) -> ()
    return
  }
  func.func @load0(%arg0: memref<1xi512, "stream1">, %arg1: memref<1xi512, "stream1">, %arg2: memref<1xi512, "stream1">, %arg3: memref<1xi512, "stream1">, %arg4: memref<1xi512, "stream1">, %arg5: memref<1xi512, "stream1">, %arg6: memref<1xi512, "stream1">, %arg7: memref<1xi512, "stream1">, %arg8: memref<1xi512, "stream1">, %arg9: memref<1xi512, "stream1">, %arg10: memref<1xi512, "stream1">, %arg11: memref<1xi512, "stream1">, %arg12: memref<1xi512, "stream1">, %arg13: memref<1xi512, "stream1">, %arg14: memref<1xi512, "stream1">, %arg15: memref<1xi512, "stream1">, %arg16: memref<1xi512, "stream1">, %arg17: memref<1xi512, "stream1">, %arg18: memref<1xi512, "stream1">, %arg19: memref<1xi512, "stream1">, %arg20: memref<1xi512, "stream1">, %arg21: memref<1xi512, "stream1">, %arg22: memref<1xi512, "stream1">, %arg23: memref<1xi512, "stream1">, %arg24: memref<1xi512, "stream1">, %arg25: memref<1xi512, "stream1">, %arg26: memref<1xi512, "stream1">, %arg27: memref<1xi512, "stream1">, %arg28: memref<1xi512, "stream1">, %arg29: memref<1xi512, "stream1">, %arg30: memref<1xi512, "stream1">, %arg31: memref<1xi512, "stream1">, %arg32: memref<1xi512, "stream1">, %arg33: memref<1xi512, "stream1">, %arg34: memref<1xi512, "stream1">, %arg35: memref<1xi512, "stream1">, %arg36: memref<1xi512, "stream1">, %arg37: memref<1xi512, "stream1">, %arg38: memref<1xi512, "stream1">, %arg39: memref<2560x1024xi512>, %arg40: memref<1xi512, "stream1">) attributes {adf.pl, inline = false, load, mem_idx = [39 : i32], mem_type = [i8], template} {
    %c3 = arith.constant 3 : index
    %c2 = arith.constant 2 : index
    %c1 = arith.constant 1 : index
    affine.for %arg41 = 0 to 1 {
      affine.for %arg42 = 0 to 1 {
        affine.for %arg43 = 0 to 256 {
          affine.for %arg44 = 0 to 8 {
            affine.for %arg45 = 0 to 32 {
              affine.for %arg46 = 0 to 1 {
                affine.for %arg47 = 0 to 4 {
                  %0 = affine.load %arg39[%arg45 + %arg44 * 320 + %arg41 * 2560, %arg47 + %arg46 * 4 + %arg43 * 4] : memref<2560x1024xi512>
                  %1 = arith.cmpi slt, %arg47, %c1 : index
                  scf.if %1 {
                    affine.store %0, %arg27[0] : memref<1xi512, "stream1">
                  } else {
                    %2 = arith.cmpi slt, %arg47, %c2 : index
                    scf.if %2 {
                      affine.store %0, %arg15[0] : memref<1xi512, "stream1">
                    } else {
                      %3 = arith.cmpi slt, %arg47, %c3 : index
                      scf.if %3 {
                        affine.store %0, %arg31[0] : memref<1xi512, "stream1">
                      } else {
                        affine.store %0, %arg5[0] : memref<1xi512, "stream1">
                      }
                    }
                  }
                } {pipeline_ii = 1 : index}
              }
            }
          } {merge}
          affine.for %arg44 = 0 to 8 {
            affine.for %arg45 = 0 to 32 {
              affine.for %arg46 = 0 to 1 {
                affine.for %arg47 = 0 to 4 {
                  %0 = affine.load %arg39[%arg45 + %arg44 * 320 + %arg41 * 2560 + 32, %arg47 + %arg46 * 4 + %arg43 * 4] : memref<2560x1024xi512>
                  %1 = arith.cmpi slt, %arg47, %c1 : index
                  scf.if %1 {
                    affine.store %0, %arg1[0] : memref<1xi512, "stream1">
                  } else {
                    %2 = arith.cmpi slt, %arg47, %c2 : index
                    scf.if %2 {
                      affine.store %0, %arg8[0] : memref<1xi512, "stream1">
                    } else {
                      %3 = arith.cmpi slt, %arg47, %c3 : index
                      scf.if %3 {
                        affine.store %0, %arg23[0] : memref<1xi512, "stream1">
                      } else {
                        affine.store %0, %arg13[0] : memref<1xi512, "stream1">
                      }
                    }
                  }
                } {pipeline_ii = 1 : index}
              }
            }
          } {merge}
          affine.for %arg44 = 0 to 8 {
            affine.for %arg45 = 0 to 32 {
              affine.for %arg46 = 0 to 1 {
                affine.for %arg47 = 0 to 4 {
                  %0 = affine.load %arg39[%arg45 + %arg44 * 320 + %arg41 * 2560 + 64, %arg47 + %arg46 * 4 + %arg43 * 4] : memref<2560x1024xi512>
                  %1 = arith.cmpi slt, %arg47, %c1 : index
                  scf.if %1 {
                    affine.store %0, %arg11[0] : memref<1xi512, "stream1">
                  } else {
                    %2 = arith.cmpi slt, %arg47, %c2 : index
                    scf.if %2 {
                      affine.store %0, %arg18[0] : memref<1xi512, "stream1">
                    } else {
                      %3 = arith.cmpi slt, %arg47, %c3 : index
                      scf.if %3 {
                        affine.store %0, %arg6[0] : memref<1xi512, "stream1">
                      } else {
                        affine.store %0, %arg28[0] : memref<1xi512, "stream1">
                      }
                    }
                  }
                } {pipeline_ii = 1 : index}
              }
            }
          } {merge}
          affine.for %arg44 = 0 to 8 {
            affine.for %arg45 = 0 to 32 {
              affine.for %arg46 = 0 to 1 {
                affine.for %arg47 = 0 to 4 {
                  %0 = affine.load %arg39[%arg45 + %arg44 * 320 + %arg41 * 2560 + 96, %arg47 + %arg46 * 4 + %arg43 * 4] : memref<2560x1024xi512>
                  %1 = arith.cmpi slt, %arg47, %c1 : index
                  scf.if %1 {
                    affine.store %0, %arg30[0] : memref<1xi512, "stream1">
                  } else {
                    %2 = arith.cmpi slt, %arg47, %c2 : index
                    scf.if %2 {
                      affine.store %0, %arg19[0] : memref<1xi512, "stream1">
                    } else {
                      %3 = arith.cmpi slt, %arg47, %c3 : index
                      scf.if %3 {
                        affine.store %0, %arg10[0] : memref<1xi512, "stream1">
                      } else {
                        affine.store %0, %arg14[0] : memref<1xi512, "stream1">
                      }
                    }
                  }
                } {pipeline_ii = 1 : index}
              }
            }
          } {merge}
          affine.for %arg44 = 0 to 8 {
            affine.for %arg45 = 0 to 32 {
              affine.for %arg46 = 0 to 1 {
                affine.for %arg47 = 0 to 4 {
                  %0 = affine.load %arg39[%arg45 + %arg44 * 320 + %arg41 * 2560 + 128, %arg47 + %arg46 * 4 + %arg43 * 4] : memref<2560x1024xi512>
                  %1 = arith.cmpi slt, %arg47, %c1 : index
                  scf.if %1 {
                    affine.store %0, %arg26[0] : memref<1xi512, "stream1">
                  } else {
                    %2 = arith.cmpi slt, %arg47, %c2 : index
                    scf.if %2 {
                      affine.store %0, %arg21[0] : memref<1xi512, "stream1">
                    } else {
                      %3 = arith.cmpi slt, %arg47, %c3 : index
                      scf.if %3 {
                        affine.store %0, %arg37[0] : memref<1xi512, "stream1">
                      } else {
                        affine.store %0, %arg25[0] : memref<1xi512, "stream1">
                      }
                    }
                  }
                } {pipeline_ii = 1 : index}
              }
            }
          } {merge}
          affine.for %arg44 = 0 to 8 {
            affine.for %arg45 = 0 to 32 {
              affine.for %arg46 = 0 to 1 {
                affine.for %arg47 = 0 to 4 {
                  %0 = affine.load %arg39[%arg45 + %arg44 * 320 + %arg41 * 2560 + 160, %arg47 + %arg46 * 4 + %arg43 * 4] : memref<2560x1024xi512>
                  %1 = arith.cmpi slt, %arg47, %c1 : index
                  scf.if %1 {
                    affine.store %0, %arg38[0] : memref<1xi512, "stream1">
                  } else {
                    %2 = arith.cmpi slt, %arg47, %c2 : index
                    scf.if %2 {
                      affine.store %0, %arg7[0] : memref<1xi512, "stream1">
                    } else {
                      %3 = arith.cmpi slt, %arg47, %c3 : index
                      scf.if %3 {
                        affine.store %0, %arg16[0] : memref<1xi512, "stream1">
                      } else {
                        affine.store %0, %arg4[0] : memref<1xi512, "stream1">
                      }
                    }
                  }
                } {pipeline_ii = 1 : index}
              }
            }
          } {merge}
          affine.for %arg44 = 0 to 8 {
            affine.for %arg45 = 0 to 32 {
              affine.for %arg46 = 0 to 1 {
                affine.for %arg47 = 0 to 4 {
                  %0 = affine.load %arg39[%arg45 + %arg44 * 320 + %arg41 * 2560 + 192, %arg47 + %arg46 * 4 + %arg43 * 4] : memref<2560x1024xi512>
                  %1 = arith.cmpi slt, %arg47, %c1 : index
                  scf.if %1 {
                    affine.store %0, %arg12[0] : memref<1xi512, "stream1">
                  } else {
                    %2 = arith.cmpi slt, %arg47, %c2 : index
                    scf.if %2 {
                      affine.store %0, %arg3[0] : memref<1xi512, "stream1">
                    } else {
                      %3 = arith.cmpi slt, %arg47, %c3 : index
                      scf.if %3 {
                        affine.store %0, %arg17[0] : memref<1xi512, "stream1">
                      } else {
                        affine.store %0, %arg9[0] : memref<1xi512, "stream1">
                      }
                    }
                  }
                } {pipeline_ii = 1 : index}
              }
            }
          } {merge}
          affine.for %arg44 = 0 to 8 {
            affine.for %arg45 = 0 to 32 {
              affine.for %arg46 = 0 to 1 {
                affine.for %arg47 = 0 to 4 {
                  %0 = affine.load %arg39[%arg45 + %arg44 * 320 + %arg41 * 2560 + 224, %arg47 + %arg46 * 4 + %arg43 * 4] : memref<2560x1024xi512>
                  %1 = arith.cmpi slt, %arg47, %c1 : index
                  scf.if %1 {
                    affine.store %0, %arg0[0] : memref<1xi512, "stream1">
                  } else {
                    %2 = arith.cmpi slt, %arg47, %c2 : index
                    scf.if %2 {
                      affine.store %0, %arg2[0] : memref<1xi512, "stream1">
                    } else {
                      %3 = arith.cmpi slt, %arg47, %c3 : index
                      scf.if %3 {
                        affine.store %0, %arg32[0] : memref<1xi512, "stream1">
                      } else {
                        affine.store %0, %arg29[0] : memref<1xi512, "stream1">
                      }
                    }
                  }
                } {pipeline_ii = 1 : index}
              }
            }
          } {merge}
          affine.for %arg44 = 0 to 8 {
            affine.for %arg45 = 0 to 32 {
              affine.for %arg46 = 0 to 1 {
                affine.for %arg47 = 0 to 4 {
                  %0 = affine.load %arg39[%arg45 + %arg44 * 320 + %arg41 * 2560 + 256, %arg47 + %arg46 * 4 + %arg43 * 4] : memref<2560x1024xi512>
                  %1 = arith.cmpi slt, %arg47, %c1 : index
                  scf.if %1 {
                    affine.store %0, %arg33[0] : memref<1xi512, "stream1">
                  } else {
                    %2 = arith.cmpi slt, %arg47, %c2 : index
                    scf.if %2 {
                      affine.store %0, %arg20[0] : memref<1xi512, "stream1">
                    } else {
                      %3 = arith.cmpi slt, %arg47, %c3 : index
                      scf.if %3 {
                        affine.store %0, %arg40[0] : memref<1xi512, "stream1">
                      } else {
                        affine.store %0, %arg34[0] : memref<1xi512, "stream1">
                      }
                    }
                  }
                } {pipeline_ii = 1 : index}
              }
            }
          } {merge}
          affine.for %arg44 = 0 to 8 {
            affine.for %arg45 = 0 to 32 {
              affine.for %arg46 = 0 to 1 {
                affine.for %arg47 = 0 to 4 {
                  %0 = affine.load %arg39[%arg45 + %arg44 * 320 + %arg41 * 2560 + 288, %arg47 + %arg46 * 4 + %arg43 * 4] : memref<2560x1024xi512>
                  %1 = arith.cmpi slt, %arg47, %c1 : index
                  scf.if %1 {
                    affine.store %0, %arg36[0] : memref<1xi512, "stream1">
                  } else {
                    %2 = arith.cmpi slt, %arg47, %c2 : index
                    scf.if %2 {
                      affine.store %0, %arg35[0] : memref<1xi512, "stream1">
                    } else {
                      %3 = arith.cmpi slt, %arg47, %c3 : index
                      scf.if %3 {
                        affine.store %0, %arg22[0] : memref<1xi512, "stream1">
                      } else {
                        affine.store %0, %arg24[0] : memref<1xi512, "stream1">
                      }
                    }
                  }
                } {pipeline_ii = 1 : index}
              }
            }
          } {merge}
        } {Array_Partition, reduction}
      }
    }
    return
  }
  func.func @load0_top(%arg0: memref<1xi512, "stream1">, %arg1: memref<1xi512, "stream1">, %arg2: memref<1xi512, "stream1">, %arg3: memref<1xi512, "stream1">, %arg4: memref<1xi512, "stream1">, %arg5: memref<1xi512, "stream1">, %arg6: memref<1xi512, "stream1">, %arg7: memref<1xi512, "stream1">, %arg8: memref<1xi512, "stream1">, %arg9: memref<1xi512, "stream1">, %arg10: memref<1xi512, "stream1">, %arg11: memref<1xi512, "stream1">, %arg12: memref<1xi512, "stream1">, %arg13: memref<1xi512, "stream1">, %arg14: memref<1xi512, "stream1">, %arg15: memref<1xi512, "stream1">, %arg16: memref<1xi512, "stream1">, %arg17: memref<1xi512, "stream1">, %arg18: memref<1xi512, "stream1">, %arg19: memref<1xi512, "stream1">, %arg20: memref<1xi512, "stream1">, %arg21: memref<1xi512, "stream1">, %arg22: memref<1xi512, "stream1">, %arg23: memref<1xi512, "stream1">, %arg24: memref<1xi512, "stream1">, %arg25: memref<1xi512, "stream1">, %arg26: memref<1xi512, "stream1">, %arg27: memref<1xi512, "stream1">, %arg28: memref<1xi512, "stream1">, %arg29: memref<1xi512, "stream1">, %arg30: memref<1xi512, "stream1">, %arg31: memref<1xi512, "stream1">, %arg32: memref<1xi512, "stream1">, %arg33: memref<1xi512, "stream1">, %arg34: memref<1xi512, "stream1">, %arg35: memref<1xi512, "stream1">, %arg36: memref<1xi512, "stream1">, %arg37: memref<1xi512, "stream1">, %arg38: memref<1xi512, "stream1">, %arg39: memref<2560x1024xi512>, %arg40: memref<1xi512, "stream1">) attributes {adf.pl, inline = false} {
    call @load0(%arg0, %arg1, %arg2, %arg3, %arg4, %arg5, %arg6, %arg7, %arg8, %arg9, %arg10, %arg11, %arg12, %arg13, %arg14, %arg15, %arg16, %arg17, %arg18, %arg19, %arg20, %arg21, %arg22, %arg23, %arg24, %arg25, %arg26, %arg27, %arg28, %arg29, %arg30, %arg31, %arg32, %arg33, %arg34, %arg35, %arg36, %arg37, %arg38, %arg39, %arg40) {template = 0 : index} : (memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<2560x1024xi512>, memref<1xi512, "stream1">) -> ()
    return
  }
  func.func @load0_39(%arg0: memref<1xi512, "stream1">, %arg1: memref<1xi128, "stream">) attributes {adf.pl, inline = false, load, template} {
    affine.for %arg2 = 0 to 1 {
      affine.for %arg3 = 0 to 1 {
        affine.for %arg4 = 0 to 256 {
          affine.for %arg5 = 0 to 8 {
            affine.for %arg6 = 0 to 32 {
              affine.for %arg7 = 0 to 1 {
                affine.for %arg8 = 0 to 1 {
                  %0 = affine.load %arg0[0] : memref<1xi512, "stream1">
                  affine.for %arg9 = 0 to 4 {
                    %1 = affine.apply #map(%arg9)
                    %2 = affine.apply #map1(%arg9)
                    %3 = adf.get_slice(%0 : i512, %1, %2) -> i128
                    affine.store %3, %arg1[0] : memref<1xi128, "stream">
                  } {pipeline_ii = 1 : index}
                } {pipeline_ii = 4 : index}
              }
            }
          }
        }
      }
    }
    return
  }
  func.func @load0_39_top(%arg0: memref<1xi512, "stream1">, %arg1: memref<1xi128, "stream">, %arg2: memref<1xi512, "stream1">, %arg3: memref<1xi128, "stream">, %arg4: memref<1xi512, "stream1">, %arg5: memref<1xi128, "stream">, %arg6: memref<1xi512, "stream1">, %arg7: memref<1xi128, "stream">, %arg8: memref<1xi512, "stream1">, %arg9: memref<1xi128, "stream">, %arg10: memref<1xi512, "stream1">, %arg11: memref<1xi128, "stream">, %arg12: memref<1xi512, "stream1">, %arg13: memref<1xi128, "stream">, %arg14: memref<1xi512, "stream1">, %arg15: memref<1xi128, "stream">, %arg16: memref<1xi512, "stream1">, %arg17: memref<1xi128, "stream">, %arg18: memref<1xi512, "stream1">, %arg19: memref<1xi128, "stream">, %arg20: memref<1xi512, "stream1">, %arg21: memref<1xi128, "stream">, %arg22: memref<1xi512, "stream1">, %arg23: memref<1xi128, "stream">, %arg24: memref<1xi512, "stream1">, %arg25: memref<1xi128, "stream">, %arg26: memref<1xi512, "stream1">, %arg27: memref<1xi128, "stream">, %arg28: memref<1xi512, "stream1">, %arg29: memref<1xi128, "stream">, %arg30: memref<1xi512, "stream1">, %arg31: memref<1xi128, "stream">, %arg32: memref<1xi512, "stream1">, %arg33: memref<1xi128, "stream">, %arg34: memref<1xi512, "stream1">, %arg35: memref<1xi128, "stream">, %arg36: memref<1xi512, "stream1">, %arg37: memref<1xi128, "stream">, %arg38: memref<1xi512, "stream1">, %arg39: memref<1xi128, "stream">, %arg40: memref<1xi512, "stream1">, %arg41: memref<1xi128, "stream">, %arg42: memref<1xi512, "stream1">, %arg43: memref<1xi128, "stream">, %arg44: memref<1xi512, "stream1">, %arg45: memref<1xi128, "stream">, %arg46: memref<1xi512, "stream1">, %arg47: memref<1xi128, "stream">, %arg48: memref<1xi512, "stream1">, %arg49: memref<1xi128, "stream">, %arg50: memref<1xi512, "stream1">, %arg51: memref<1xi128, "stream">, %arg52: memref<1xi512, "stream1">, %arg53: memref<1xi128, "stream">, %arg54: memref<1xi512, "stream1">, %arg55: memref<1xi128, "stream">, %arg56: memref<1xi512, "stream1">, %arg57: memref<1xi128, "stream">, %arg58: memref<1xi512, "stream1">, %arg59: memref<1xi128, "stream">, %arg60: memref<1xi512, "stream1">, %arg61: memref<1xi128, "stream">, %arg62: memref<1xi512, "stream1">, %arg63: memref<1xi128, "stream">, %arg64: memref<1xi512, "stream1">, %arg65: memref<1xi128, "stream">, %arg66: memref<1xi512, "stream1">, %arg67: memref<1xi128, "stream">, %arg68: memref<1xi512, "stream1">, %arg69: memref<1xi128, "stream">, %arg70: memref<1xi512, "stream1">, %arg71: memref<1xi128, "stream">, %arg72: memref<1xi512, "stream1">, %arg73: memref<1xi128, "stream">, %arg74: memref<1xi512, "stream1">, %arg75: memref<1xi128, "stream">, %arg76: memref<1xi512, "stream1">, %arg77: memref<1xi128, "stream">, %arg78: memref<1xi512, "stream1">, %arg79: memref<1xi128, "stream">) attributes {adf.pl, inline = false} {
    call @load0_39(%arg0, %arg1) {template = 0 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load0_39(%arg2, %arg3) {template = 1 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load0_39(%arg4, %arg5) {template = 2 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load0_39(%arg6, %arg7) {template = 3 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load0_39(%arg8, %arg9) {template = 4 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load0_39(%arg10, %arg11) {template = 5 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load0_39(%arg12, %arg13) {template = 6 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load0_39(%arg14, %arg15) {template = 7 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load0_39(%arg16, %arg17) {template = 8 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load0_39(%arg18, %arg19) {template = 9 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load0_39(%arg20, %arg21) {template = 10 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load0_39(%arg22, %arg23) {template = 11 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load0_39(%arg24, %arg25) {template = 12 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load0_39(%arg26, %arg27) {template = 13 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load0_39(%arg28, %arg29) {template = 14 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load0_39(%arg30, %arg31) {template = 15 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load0_39(%arg32, %arg33) {template = 16 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load0_39(%arg34, %arg35) {template = 17 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load0_39(%arg36, %arg37) {template = 18 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load0_39(%arg38, %arg39) {template = 19 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load0_39(%arg40, %arg41) {template = 20 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load0_39(%arg42, %arg43) {template = 21 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load0_39(%arg44, %arg45) {template = 22 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load0_39(%arg46, %arg47) {template = 23 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load0_39(%arg48, %arg49) {template = 24 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load0_39(%arg50, %arg51) {template = 25 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load0_39(%arg52, %arg53) {template = 26 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load0_39(%arg54, %arg55) {template = 27 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load0_39(%arg56, %arg57) {template = 28 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load0_39(%arg58, %arg59) {template = 29 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load0_39(%arg60, %arg61) {template = 30 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load0_39(%arg62, %arg63) {template = 31 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load0_39(%arg64, %arg65) {template = 32 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load0_39(%arg66, %arg67) {template = 33 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load0_39(%arg68, %arg69) {template = 34 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load0_39(%arg70, %arg71) {template = 35 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load0_39(%arg72, %arg73) {template = 36 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load0_39(%arg74, %arg75) {template = 37 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load0_39(%arg76, %arg77) {template = 38 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load0_39(%arg78, %arg79) {template = 39 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    return
  }
  func.func @load1(%arg0: memref<1xi512, "stream1">, %arg1: memref<1xi512, "stream1">, %arg2: memref<1xi512, "stream1">, %arg3: memref<1xi512, "stream1">, %arg4: memref<1xi512, "stream1">, %arg5: memref<1xi512, "stream1">, %arg6: memref<65536x64xi512>, %arg7: memref<1xi512, "stream1">, %arg8: memref<1xi512, "stream1">, %arg9: memref<1xi512, "stream1">, %arg10: memref<1xi512, "stream1">, %arg11: memref<1xi512, "stream1">, %arg12: memref<1xi512, "stream1">, %arg13: memref<1xi512, "stream1">, %arg14: memref<1xi512, "stream1">, %arg15: memref<1xi512, "stream1">, %arg16: memref<1xi512, "stream1">, %arg17: memref<1xi512, "stream1">, %arg18: memref<1xi512, "stream1">, %arg19: memref<1xi512, "stream1">, %arg20: memref<1xi512, "stream1">, %arg21: memref<1xi512, "stream1">, %arg22: memref<1xi512, "stream1">, %arg23: memref<1xi512, "stream1">, %arg24: memref<1xi512, "stream1">, %arg25: memref<1xi512, "stream1">, %arg26: memref<1xi512, "stream1">, %arg27: memref<1xi512, "stream1">, %arg28: memref<1xi512, "stream1">, %arg29: memref<1xi512, "stream1">, %arg30: memref<1xi512, "stream1">, %arg31: memref<1xi512, "stream1">, %arg32: memref<1xi512, "stream1">) attributes {adf.pl, inline = false, load, mem_idx = [6 : i32], mem_type = [i8], template} {
    %c7 = arith.constant 7 : index
    %c6 = arith.constant 6 : index
    %c5 = arith.constant 5 : index
    %c4 = arith.constant 4 : index
    %c3 = arith.constant 3 : index
    %c2 = arith.constant 2 : index
    %c1 = arith.constant 1 : index
    affine.for %arg33 = 0 to 1 {
      affine.for %arg34 = 0 to 1 {
        affine.for %arg35 = 0 to 256 {
          affine.for %arg36 = 0 to 1 {
            affine.for %arg37 = 0 to 64 {
              affine.for %arg38 = 0 to 8 {
                affine.for %arg39 = 0 to 8 {
                  %0 = affine.load %arg6[%arg37 + %arg36 * 256 + %arg35 * 256, %arg39 + %arg38 * 8 + %arg34 * 64] : memref<65536x64xi512>
                  %1 = arith.cmpi slt, %arg39, %c1 : index
                  scf.if %1 {
                    affine.store %0, %arg12[0] : memref<1xi512, "stream1">
                  } else {
                    %2 = arith.cmpi slt, %arg39, %c2 : index
                    scf.if %2 {
                      affine.store %0, %arg14[0] : memref<1xi512, "stream1">
                    } else {
                      %3 = arith.cmpi slt, %arg39, %c3 : index
                      scf.if %3 {
                        affine.store %0, %arg4[0] : memref<1xi512, "stream1">
                      } else {
                        %4 = arith.cmpi slt, %arg39, %c4 : index
                        scf.if %4 {
                          affine.store %0, %arg25[0] : memref<1xi512, "stream1">
                        } else {
                          %5 = arith.cmpi slt, %arg39, %c5 : index
                          scf.if %5 {
                            affine.store %0, %arg3[0] : memref<1xi512, "stream1">
                          } else {
                            %6 = arith.cmpi slt, %arg39, %c6 : index
                            scf.if %6 {
                              affine.store %0, %arg20[0] : memref<1xi512, "stream1">
                            } else {
                              %7 = arith.cmpi slt, %arg39, %c7 : index
                              scf.if %7 {
                                affine.store %0, %arg32[0] : memref<1xi512, "stream1">
                              } else {
                                affine.store %0, %arg1[0] : memref<1xi512, "stream1">
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                } {pipeline_ii = 1 : index}
              }
            }
          } {merge}
          affine.for %arg36 = 0 to 1 {
            affine.for %arg37 = 0 to 64 {
              affine.for %arg38 = 0 to 8 {
                affine.for %arg39 = 0 to 8 {
                  %0 = affine.load %arg6[%arg37 + %arg36 * 256 + %arg35 * 256 + 64, %arg39 + %arg38 * 8 + %arg34 * 64] : memref<65536x64xi512>
                  %1 = arith.cmpi slt, %arg39, %c1 : index
                  scf.if %1 {
                    affine.store %0, %arg26[0] : memref<1xi512, "stream1">
                  } else {
                    %2 = arith.cmpi slt, %arg39, %c2 : index
                    scf.if %2 {
                      affine.store %0, %arg9[0] : memref<1xi512, "stream1">
                    } else {
                      %3 = arith.cmpi slt, %arg39, %c3 : index
                      scf.if %3 {
                        affine.store %0, %arg13[0] : memref<1xi512, "stream1">
                      } else {
                        %4 = arith.cmpi slt, %arg39, %c4 : index
                        scf.if %4 {
                          affine.store %0, %arg16[0] : memref<1xi512, "stream1">
                        } else {
                          %5 = arith.cmpi slt, %arg39, %c5 : index
                          scf.if %5 {
                            affine.store %0, %arg0[0] : memref<1xi512, "stream1">
                          } else {
                            %6 = arith.cmpi slt, %arg39, %c6 : index
                            scf.if %6 {
                              affine.store %0, %arg18[0] : memref<1xi512, "stream1">
                            } else {
                              %7 = arith.cmpi slt, %arg39, %c7 : index
                              scf.if %7 {
                                affine.store %0, %arg11[0] : memref<1xi512, "stream1">
                              } else {
                                affine.store %0, %arg27[0] : memref<1xi512, "stream1">
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                } {pipeline_ii = 1 : index}
              }
            }
          } {merge}
          affine.for %arg36 = 0 to 1 {
            affine.for %arg37 = 0 to 64 {
              affine.for %arg38 = 0 to 8 {
                affine.for %arg39 = 0 to 8 {
                  %0 = affine.load %arg6[%arg37 + %arg36 * 256 + %arg35 * 256 + 128, %arg39 + %arg38 * 8 + %arg34 * 64] : memref<65536x64xi512>
                  %1 = arith.cmpi slt, %arg39, %c1 : index
                  scf.if %1 {
                    affine.store %0, %arg21[0] : memref<1xi512, "stream1">
                  } else {
                    %2 = arith.cmpi slt, %arg39, %c2 : index
                    scf.if %2 {
                      affine.store %0, %arg7[0] : memref<1xi512, "stream1">
                    } else {
                      %3 = arith.cmpi slt, %arg39, %c3 : index
                      scf.if %3 {
                        affine.store %0, %arg30[0] : memref<1xi512, "stream1">
                      } else {
                        %4 = arith.cmpi slt, %arg39, %c4 : index
                        scf.if %4 {
                          affine.store %0, %arg17[0] : memref<1xi512, "stream1">
                        } else {
                          %5 = arith.cmpi slt, %arg39, %c5 : index
                          scf.if %5 {
                            affine.store %0, %arg19[0] : memref<1xi512, "stream1">
                          } else {
                            %6 = arith.cmpi slt, %arg39, %c6 : index
                            scf.if %6 {
                              affine.store %0, %arg15[0] : memref<1xi512, "stream1">
                            } else {
                              %7 = arith.cmpi slt, %arg39, %c7 : index
                              scf.if %7 {
                                affine.store %0, %arg31[0] : memref<1xi512, "stream1">
                              } else {
                                affine.store %0, %arg8[0] : memref<1xi512, "stream1">
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                } {pipeline_ii = 1 : index}
              }
            }
          } {merge}
          affine.for %arg36 = 0 to 1 {
            affine.for %arg37 = 0 to 64 {
              affine.for %arg38 = 0 to 8 {
                affine.for %arg39 = 0 to 8 {
                  %0 = affine.load %arg6[%arg37 + %arg36 * 256 + %arg35 * 256 + 192, %arg39 + %arg38 * 8 + %arg34 * 64] : memref<65536x64xi512>
                  %1 = arith.cmpi slt, %arg39, %c1 : index
                  scf.if %1 {
                    affine.store %0, %arg23[0] : memref<1xi512, "stream1">
                  } else {
                    %2 = arith.cmpi slt, %arg39, %c2 : index
                    scf.if %2 {
                      affine.store %0, %arg10[0] : memref<1xi512, "stream1">
                    } else {
                      %3 = arith.cmpi slt, %arg39, %c3 : index
                      scf.if %3 {
                        affine.store %0, %arg28[0] : memref<1xi512, "stream1">
                      } else {
                        %4 = arith.cmpi slt, %arg39, %c4 : index
                        scf.if %4 {
                          affine.store %0, %arg2[0] : memref<1xi512, "stream1">
                        } else {
                          %5 = arith.cmpi slt, %arg39, %c5 : index
                          scf.if %5 {
                            affine.store %0, %arg24[0] : memref<1xi512, "stream1">
                          } else {
                            %6 = arith.cmpi slt, %arg39, %c6 : index
                            scf.if %6 {
                              affine.store %0, %arg22[0] : memref<1xi512, "stream1">
                            } else {
                              %7 = arith.cmpi slt, %arg39, %c7 : index
                              scf.if %7 {
                                affine.store %0, %arg5[0] : memref<1xi512, "stream1">
                              } else {
                                affine.store %0, %arg29[0] : memref<1xi512, "stream1">
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                } {pipeline_ii = 1 : index}
              }
            }
          } {merge}
        } {Array_Partition, reduction}
      }
    }
    return
  }
  func.func @load1_top(%arg0: memref<1xi512, "stream1">, %arg1: memref<1xi512, "stream1">, %arg2: memref<1xi512, "stream1">, %arg3: memref<1xi512, "stream1">, %arg4: memref<1xi512, "stream1">, %arg5: memref<1xi512, "stream1">, %arg6: memref<65536x64xi512>, %arg7: memref<1xi512, "stream1">, %arg8: memref<1xi512, "stream1">, %arg9: memref<1xi512, "stream1">, %arg10: memref<1xi512, "stream1">, %arg11: memref<1xi512, "stream1">, %arg12: memref<1xi512, "stream1">, %arg13: memref<1xi512, "stream1">, %arg14: memref<1xi512, "stream1">, %arg15: memref<1xi512, "stream1">, %arg16: memref<1xi512, "stream1">, %arg17: memref<1xi512, "stream1">, %arg18: memref<1xi512, "stream1">, %arg19: memref<1xi512, "stream1">, %arg20: memref<1xi512, "stream1">, %arg21: memref<1xi512, "stream1">, %arg22: memref<1xi512, "stream1">, %arg23: memref<1xi512, "stream1">, %arg24: memref<1xi512, "stream1">, %arg25: memref<1xi512, "stream1">, %arg26: memref<1xi512, "stream1">, %arg27: memref<1xi512, "stream1">, %arg28: memref<1xi512, "stream1">, %arg29: memref<1xi512, "stream1">, %arg30: memref<1xi512, "stream1">, %arg31: memref<1xi512, "stream1">, %arg32: memref<1xi512, "stream1">) attributes {adf.pl, inline = false} {
    call @load1(%arg0, %arg1, %arg2, %arg3, %arg4, %arg5, %arg6, %arg7, %arg8, %arg9, %arg10, %arg11, %arg12, %arg13, %arg14, %arg15, %arg16, %arg17, %arg18, %arg19, %arg20, %arg21, %arg22, %arg23, %arg24, %arg25, %arg26, %arg27, %arg28, %arg29, %arg30, %arg31, %arg32) {template = 0 : index} : (memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<65536x64xi512>, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">) -> ()
    return
  }
  func.func @load1_31(%arg0: memref<1xi512, "stream1">, %arg1: memref<1xi128, "stream">) attributes {adf.pl, inline = false, load, template} {
    affine.for %arg2 = 0 to 1 {
      affine.for %arg3 = 0 to 1 {
        affine.for %arg4 = 0 to 256 {
          affine.for %arg5 = 0 to 1 {
            affine.for %arg6 = 0 to 64 {
              affine.for %arg7 = 0 to 8 {
                affine.for %arg8 = 0 to 1 {
                  %0 = affine.load %arg0[0] : memref<1xi512, "stream1">
                  affine.for %arg9 = 0 to 4 {
                    %1 = affine.apply #map(%arg9)
                    %2 = affine.apply #map1(%arg9)
                    %3 = adf.get_slice(%0 : i512, %1, %2) -> i128
                    affine.store %3, %arg1[0] : memref<1xi128, "stream">
                  } {pipeline_ii = 1 : index}
                } {pipeline_ii = 4 : index}
              }
            }
          }
        }
      }
    }
    return
  }
  func.func @load1_31_top(%arg0: memref<1xi512, "stream1">, %arg1: memref<1xi128, "stream">, %arg2: memref<1xi512, "stream1">, %arg3: memref<1xi128, "stream">, %arg4: memref<1xi512, "stream1">, %arg5: memref<1xi128, "stream">, %arg6: memref<1xi512, "stream1">, %arg7: memref<1xi128, "stream">, %arg8: memref<1xi512, "stream1">, %arg9: memref<1xi128, "stream">, %arg10: memref<1xi512, "stream1">, %arg11: memref<1xi128, "stream">, %arg12: memref<1xi512, "stream1">, %arg13: memref<1xi128, "stream">, %arg14: memref<1xi512, "stream1">, %arg15: memref<1xi128, "stream">, %arg16: memref<1xi512, "stream1">, %arg17: memref<1xi128, "stream">, %arg18: memref<1xi512, "stream1">, %arg19: memref<1xi128, "stream">, %arg20: memref<1xi512, "stream1">, %arg21: memref<1xi128, "stream">, %arg22: memref<1xi512, "stream1">, %arg23: memref<1xi128, "stream">, %arg24: memref<1xi512, "stream1">, %arg25: memref<1xi128, "stream">, %arg26: memref<1xi512, "stream1">, %arg27: memref<1xi128, "stream">, %arg28: memref<1xi512, "stream1">, %arg29: memref<1xi128, "stream">, %arg30: memref<1xi512, "stream1">, %arg31: memref<1xi128, "stream">, %arg32: memref<1xi512, "stream1">, %arg33: memref<1xi128, "stream">, %arg34: memref<1xi512, "stream1">, %arg35: memref<1xi128, "stream">, %arg36: memref<1xi512, "stream1">, %arg37: memref<1xi128, "stream">, %arg38: memref<1xi512, "stream1">, %arg39: memref<1xi128, "stream">, %arg40: memref<1xi512, "stream1">, %arg41: memref<1xi128, "stream">, %arg42: memref<1xi512, "stream1">, %arg43: memref<1xi128, "stream">, %arg44: memref<1xi512, "stream1">, %arg45: memref<1xi128, "stream">, %arg46: memref<1xi512, "stream1">, %arg47: memref<1xi128, "stream">, %arg48: memref<1xi512, "stream1">, %arg49: memref<1xi128, "stream">, %arg50: memref<1xi512, "stream1">, %arg51: memref<1xi128, "stream">, %arg52: memref<1xi512, "stream1">, %arg53: memref<1xi128, "stream">, %arg54: memref<1xi512, "stream1">, %arg55: memref<1xi128, "stream">, %arg56: memref<1xi512, "stream1">, %arg57: memref<1xi128, "stream">, %arg58: memref<1xi512, "stream1">, %arg59: memref<1xi128, "stream">, %arg60: memref<1xi512, "stream1">, %arg61: memref<1xi128, "stream">, %arg62: memref<1xi512, "stream1">, %arg63: memref<1xi128, "stream">) attributes {adf.pl, inline = false} {
    call @load1_31(%arg0, %arg1) {template = 0 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load1_31(%arg2, %arg3) {template = 1 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load1_31(%arg4, %arg5) {template = 2 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load1_31(%arg6, %arg7) {template = 3 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load1_31(%arg8, %arg9) {template = 4 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load1_31(%arg10, %arg11) {template = 5 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load1_31(%arg12, %arg13) {template = 6 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load1_31(%arg14, %arg15) {template = 7 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load1_31(%arg16, %arg17) {template = 8 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load1_31(%arg18, %arg19) {template = 9 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load1_31(%arg20, %arg21) {template = 10 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load1_31(%arg22, %arg23) {template = 11 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load1_31(%arg24, %arg25) {template = 12 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load1_31(%arg26, %arg27) {template = 13 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load1_31(%arg28, %arg29) {template = 14 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load1_31(%arg30, %arg31) {template = 15 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load1_31(%arg32, %arg33) {template = 16 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load1_31(%arg34, %arg35) {template = 17 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load1_31(%arg36, %arg37) {template = 18 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load1_31(%arg38, %arg39) {template = 19 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load1_31(%arg40, %arg41) {template = 20 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load1_31(%arg42, %arg43) {template = 21 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load1_31(%arg44, %arg45) {template = 22 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load1_31(%arg46, %arg47) {template = 23 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load1_31(%arg48, %arg49) {template = 24 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load1_31(%arg50, %arg51) {template = 25 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load1_31(%arg52, %arg53) {template = 26 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load1_31(%arg54, %arg55) {template = 27 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load1_31(%arg56, %arg57) {template = 28 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load1_31(%arg58, %arg59) {template = 29 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load1_31(%arg60, %arg61) {template = 30 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load1_31(%arg62, %arg63) {template = 31 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    return
  }
  func.func @gemm_pl(%arg0: memref<2560x1024xi512>, %arg1: memref<65536x64xi512>, %arg2: memref<2560x64xi512>, %arg3: memref<1xi128, "plio">, %arg4: memref<1xi128, "plio">, %arg5: memref<1xi128, "plio">, %arg6: memref<1xi128, "plio">, %arg7: memref<1xi128, "plio">, %arg8: memref<1xi128, "plio">, %arg9: memref<1xi128, "plio">, %arg10: memref<1xi128, "plio">, %arg11: memref<1xi128, "plio">, %arg12: memref<1xi128, "plio">, %arg13: memref<1xi128, "plio">, %arg14: memref<1xi128, "plio">, %arg15: memref<1xi128, "plio">, %arg16: memref<1xi128, "plio">, %arg17: memref<1xi128, "plio">, %arg18: memref<1xi128, "plio">, %arg19: memref<1xi128, "plio">, %arg20: memref<1xi128, "plio">, %arg21: memref<1xi128, "plio">, %arg22: memref<1xi128, "plio">, %arg23: memref<1xi128, "plio">, %arg24: memref<1xi128, "plio">, %arg25: memref<1xi128, "plio">, %arg26: memref<1xi128, "plio">, %arg27: memref<1xi128, "plio">, %arg28: memref<1xi128, "plio">, %arg29: memref<1xi128, "plio">, %arg30: memref<1xi128, "plio">, %arg31: memref<1xi128, "plio">, %arg32: memref<1xi128, "plio">, %arg33: memref<1xi128, "plio">, %arg34: memref<1xi128, "plio">, %arg35: memref<1xi128, "plio">, %arg36: memref<1xi128, "plio">, %arg37: memref<1xi128, "plio">, %arg38: memref<1xi128, "plio">, %arg39: memref<1xi128, "plio">, %arg40: memref<1xi128, "plio">, %arg41: memref<1xi128, "plio">, %arg42: memref<1xi128, "plio">, %arg43: memref<1xi128, "plio">, %arg44: memref<1xi128, "plio">, %arg45: memref<1xi128, "plio">, %arg46: memref<1xi128, "plio">, %arg47: memref<1xi128, "plio">, %arg48: memref<1xi128, "plio">, %arg49: memref<1xi128, "plio">, %arg50: memref<1xi128, "plio">, %arg51: memref<1xi128, "plio">, %arg52: memref<1xi128, "plio">, %arg53: memref<1xi128, "plio">, %arg54: memref<1xi128, "plio">, %arg55: memref<1xi128, "plio">, %arg56: memref<1xi128, "plio">, %arg57: memref<1xi128, "plio">, %arg58: memref<1xi128, "plio">, %arg59: memref<1xi128, "plio">, %arg60: memref<1xi128, "plio">, %arg61: memref<1xi128, "plio">, %arg62: memref<1xi128, "plio">, %arg63: memref<1xi128, "plio">, %arg64: memref<1xi128, "plio">, %arg65: memref<1xi128, "plio">, %arg66: memref<1xi128, "plio">, %arg67: memref<1xi128, "plio">, %arg68: memref<1xi128, "plio">, %arg69: memref<1xi128, "plio">, %arg70: memref<1xi128, "plio">, %arg71: memref<1xi128, "plio">, %arg72: memref<1xi128, "plio">, %arg73: memref<1xi128, "plio">, %arg74: memref<1xi128, "plio">, %arg75: memref<1xi128, "plio">, %arg76: memref<1xi128, "plio">, %arg77: memref<1xi128, "plio">, %arg78: memref<1xi128, "plio">, %arg79: memref<1xi128, "plio">, %arg80: memref<1xi128, "plio">, %arg81: memref<1xi128, "plio">, %arg82: memref<1xi128, "plio">, %arg83: memref<1xi128, "plio">, %arg84: memref<1xi128, "plio">, %arg85: memref<1xi128, "plio">, %arg86: memref<1xi128, "plio">, %arg87: memref<1xi128, "plio">, %arg88: memref<1xi128, "plio">, %arg89: memref<1xi128, "plio">, %arg90: memref<1xi128, "plio">, %arg91: memref<1xi128, "plio">, %arg92: memref<1xi128, "plio">, %arg93: memref<1xi128, "plio">, %arg94: memref<1xi128, "plio">, %arg95: memref<1xi128, "plio">, %arg96: memref<1xi128, "plio">, %arg97: memref<1xi128, "plio">, %arg98: memref<1xi128, "plio">, %arg99: memref<1xi128, "plio">, %arg100: memref<1xi128, "plio">, %arg101: memref<1xi128, "plio">, %arg102: memref<1xi128, "plio">, %arg103: memref<1xi128, "plio">, %arg104: memref<1xi128, "plio">, %arg105: memref<1xi128, "plio">, %arg106: memref<1xi128, "plio">, %arg107: memref<1xi128, "plio">, %arg108: memref<1xi128, "plio">, %arg109: memref<1xi128, "plio">, %arg110: memref<1xi128, "plio">, %arg111: memref<1xi128, "plio">, %arg112: memref<1xi128, "plio">, %arg113: memref<1xi128, "plio">, %arg114: memref<1xi128, "plio">, %arg115: memref<1xi128, "plio">, %arg116: memref<1xi128, "plio">, %arg117: memref<1xi128, "plio">, %arg118: memref<1xi128, "plio">, %arg119: memref<1xi128, "plio">, %arg120: memref<1xi128, "plio">, %arg121: memref<1xi128, "plio">, %arg122: memref<1xi128, "plio">, %arg123: memref<1xi128, "plio">, %arg124: memref<1xi128, "plio">, %arg125: memref<1xi128, "plio">, %arg126: memref<1xi128, "plio">, %arg127: memref<1xi128, "plio">, %arg128: memref<1xi128, "plio">, %arg129: memref<1xi128, "plio">, %arg130: memref<1xi128, "plio">, %arg131: memref<1xi128, "plio">, %arg132: memref<1xi128, "plio">, %arg133: memref<1xi128, "plio">, %arg134: memref<1xi128, "plio">, %arg135: memref<1xi128, "plio">, %arg136: memref<1xi128, "plio">, %arg137: memref<1xi128, "plio">, %arg138: memref<1xi128, "plio">, %arg139: memref<1xi128, "plio">, %arg140: memref<1xi128, "plio">, %arg141: memref<1xi128, "plio">, %arg142: memref<1xi128, "plio">, %arg143: memref<1xi128, "plio">, %arg144: memref<1xi128, "plio">, %arg145: memref<1xi128, "plio">, %arg146: memref<1xi128, "plio">, %arg147: memref<1xi128, "plio">, %arg148: memref<1xi128, "plio">, %arg149: memref<1xi128, "plio">, %arg150: memref<1xi128, "plio">, %arg151: memref<1xi128, "plio">, %arg152: memref<1xi128, "plio">, %arg153: memref<1xi128, "plio">, %arg154: memref<1xi128, "plio">) attributes {adf.pl = true, dataflow, inline = false, mem_idx = [0 : i32, 1 : i32, 2 : i32], mem_type = [i8, i8, i8]} {
    %alloc = memref.alloc() : memref<1xi128, "stream">
    %alloc_0 = memref.alloc() : memref<1xi128, "stream">
    %alloc_1 = memref.alloc() : memref<1xi128, "stream">
    %alloc_2 = memref.alloc() : memref<1xi128, "stream">
    %alloc_3 = memref.alloc() : memref<1xi128, "stream">
    %alloc_4 = memref.alloc() : memref<1xi128, "stream">
    %alloc_5 = memref.alloc() : memref<1xi128, "stream">
    %alloc_6 = memref.alloc() : memref<1xi128, "stream">
    %alloc_7 = memref.alloc() : memref<1xi128, "stream">
    %alloc_8 = memref.alloc() : memref<1xi128, "stream">
    %alloc_9 = memref.alloc() : memref<1xi128, "stream">
    %alloc_10 = memref.alloc() : memref<1xi128, "stream">
    %alloc_11 = memref.alloc() : memref<1xi128, "stream">
    %alloc_12 = memref.alloc() : memref<1xi128, "stream">
    %alloc_13 = memref.alloc() : memref<1xi128, "stream">
    %alloc_14 = memref.alloc() : memref<1xi128, "stream">
    %alloc_15 = memref.alloc() : memref<1xi128, "stream">
    %alloc_16 = memref.alloc() : memref<1xi128, "stream">
    %alloc_17 = memref.alloc() : memref<1xi128, "stream">
    %alloc_18 = memref.alloc() : memref<1xi128, "stream">
    %alloc_19 = memref.alloc() : memref<1xi128, "stream">
    %alloc_20 = memref.alloc() : memref<1xi128, "stream">
    %alloc_21 = memref.alloc() : memref<1xi128, "stream">
    %alloc_22 = memref.alloc() : memref<1xi128, "stream">
    %alloc_23 = memref.alloc() : memref<1xi128, "stream">
    %alloc_24 = memref.alloc() : memref<1xi128, "stream">
    %alloc_25 = memref.alloc() : memref<1xi128, "stream">
    %alloc_26 = memref.alloc() : memref<1xi128, "stream">
    %alloc_27 = memref.alloc() : memref<1xi128, "stream">
    %alloc_28 = memref.alloc() : memref<1xi128, "stream">
    %alloc_29 = memref.alloc() : memref<1xi128, "stream">
    %alloc_30 = memref.alloc() : memref<1xi128, "stream">
    %alloc_31 = memref.alloc() : memref<1xi128, "stream">
    %alloc_32 = memref.alloc() : memref<1xi128, "stream">
    %alloc_33 = memref.alloc() : memref<1xi128, "stream">
    %alloc_34 = memref.alloc() : memref<1xi128, "stream">
    %alloc_35 = memref.alloc() : memref<1xi128, "stream">
    %alloc_36 = memref.alloc() : memref<1xi128, "stream">
    %alloc_37 = memref.alloc() : memref<1xi128, "stream">
    %alloc_38 = memref.alloc() : memref<1xi128, "stream">
    %alloc_39 = memref.alloc() : memref<1xi128, "stream">
    %alloc_40 = memref.alloc() : memref<1xi128, "stream">
    %alloc_41 = memref.alloc() : memref<1xi128, "stream">
    %alloc_42 = memref.alloc() : memref<1xi128, "stream">
    %alloc_43 = memref.alloc() : memref<1xi128, "stream">
    %alloc_44 = memref.alloc() : memref<1xi128, "stream">
    %alloc_45 = memref.alloc() : memref<1xi128, "stream">
    %alloc_46 = memref.alloc() : memref<1xi128, "stream">
    %alloc_47 = memref.alloc() : memref<1xi128, "stream">
    %alloc_48 = memref.alloc() : memref<1xi128, "stream">
    %alloc_49 = memref.alloc() : memref<1xi128, "stream">
    %alloc_50 = memref.alloc() : memref<1xi128, "stream">
    %alloc_51 = memref.alloc() : memref<1xi128, "stream">
    %alloc_52 = memref.alloc() : memref<1xi128, "stream">
    %alloc_53 = memref.alloc() : memref<1xi128, "stream">
    %alloc_54 = memref.alloc() : memref<1xi128, "stream">
    %alloc_55 = memref.alloc() : memref<1xi128, "stream">
    %alloc_56 = memref.alloc() : memref<1xi128, "stream">
    %alloc_57 = memref.alloc() : memref<1xi128, "stream">
    %alloc_58 = memref.alloc() : memref<1xi128, "stream">
    %alloc_59 = memref.alloc() : memref<1xi128, "stream">
    %alloc_60 = memref.alloc() : memref<1xi128, "stream">
    %alloc_61 = memref.alloc() : memref<1xi128, "stream">
    %alloc_62 = memref.alloc() : memref<1xi128, "stream">
    %alloc_63 = memref.alloc() : memref<1xi128, "stream">
    %alloc_64 = memref.alloc() : memref<1xi128, "stream">
    %alloc_65 = memref.alloc() : memref<1xi128, "stream">
    %alloc_66 = memref.alloc() : memref<1xi128, "stream">
    %alloc_67 = memref.alloc() : memref<1xi128, "stream">
    %alloc_68 = memref.alloc() : memref<1xi128, "stream">
    %alloc_69 = memref.alloc() : memref<1xi128, "stream">
    %alloc_70 = memref.alloc() : memref<1xi128, "stream">
    %alloc_71 = memref.alloc() : memref<1xi128, "stream">
    %alloc_72 = memref.alloc() : memref<1xi128, "stream">
    %alloc_73 = memref.alloc() : memref<1xi128, "stream">
    %alloc_74 = memref.alloc() : memref<1xi128, "stream">
    %alloc_75 = memref.alloc() : memref<1xi128, "stream">
    %alloc_76 = memref.alloc() : memref<1xi128, "stream">
    %alloc_77 = memref.alloc() : memref<1xi128, "stream">
    %alloc_78 = memref.alloc() : memref<1xi128, "stream">
    %alloc_79 = memref.alloc() : memref<1xi128, "stream">
    %alloc_80 = memref.alloc() : memref<1xi128, "stream">
    %alloc_81 = memref.alloc() : memref<1xi128, "stream">
    %alloc_82 = memref.alloc() : memref<1xi128, "stream">
    %alloc_83 = memref.alloc() : memref<1xi128, "stream">
    %alloc_84 = memref.alloc() : memref<1xi128, "stream">
    %alloc_85 = memref.alloc() : memref<1xi128, "stream">
    %alloc_86 = memref.alloc() : memref<1xi128, "stream">
    %alloc_87 = memref.alloc() : memref<1xi128, "stream">
    %alloc_88 = memref.alloc() : memref<1xi128, "stream">
    %alloc_89 = memref.alloc() : memref<1xi128, "stream">
    %alloc_90 = memref.alloc() : memref<1xi128, "stream">
    %alloc_91 = memref.alloc() : memref<1xi128, "stream">
    %alloc_92 = memref.alloc() : memref<1xi128, "stream">
    %alloc_93 = memref.alloc() : memref<1xi128, "stream">
    %alloc_94 = memref.alloc() : memref<1xi128, "stream">
    %alloc_95 = memref.alloc() : memref<1xi128, "stream">
    %alloc_96 = memref.alloc() : memref<1xi128, "stream">
    %alloc_97 = memref.alloc() : memref<1xi128, "stream">
    %alloc_98 = memref.alloc() : memref<1xi128, "stream">
    %alloc_99 = memref.alloc() : memref<1xi128, "stream">
    %alloc_100 = memref.alloc() : memref<1xi128, "stream">
    %alloc_101 = memref.alloc() : memref<1xi128, "stream">
    %alloc_102 = memref.alloc() : memref<1xi128, "stream">
    %alloc_103 = memref.alloc() : memref<1xi128, "stream">
    %alloc_104 = memref.alloc() : memref<1xi128, "stream">
    %alloc_105 = memref.alloc() : memref<1xi128, "stream">
    %alloc_106 = memref.alloc() : memref<1xi128, "stream">
    %alloc_107 = memref.alloc() : memref<1xi128, "stream">
    %alloc_108 = memref.alloc() : memref<1xi128, "stream">
    %alloc_109 = memref.alloc() : memref<1xi128, "stream">
    %alloc_110 = memref.alloc() : memref<1xi128, "stream">
    %alloc_111 = memref.alloc() : memref<1xi128, "stream">
    %alloc_112 = memref.alloc() : memref<1xi128, "stream">
    %alloc_113 = memref.alloc() : memref<1xi128, "stream">
    %alloc_114 = memref.alloc() : memref<1xi128, "stream">
    %alloc_115 = memref.alloc() : memref<1xi128, "stream">
    %alloc_116 = memref.alloc() : memref<1xi128, "stream">
    %alloc_117 = memref.alloc() : memref<1xi128, "stream">
    %alloc_118 = memref.alloc() : memref<1xi128, "stream">
    %alloc_119 = memref.alloc() : memref<1xi128, "stream">
    %alloc_120 = memref.alloc() : memref<1xi128, "stream">
    %alloc_121 = memref.alloc() : memref<1xi128, "stream">
    %alloc_122 = memref.alloc() : memref<1xi128, "stream">
    %alloc_123 = memref.alloc() : memref<1xi128, "stream">
    %alloc_124 = memref.alloc() : memref<1xi128, "stream">
    %alloc_125 = memref.alloc() : memref<1xi128, "stream">
    %alloc_126 = memref.alloc() : memref<1xi128, "stream">
    %alloc_127 = memref.alloc() : memref<1xi128, "stream">
    %alloc_128 = memref.alloc() : memref<1xi128, "stream">
    %alloc_129 = memref.alloc() : memref<1xi128, "stream">
    %alloc_130 = memref.alloc() : memref<1xi128, "stream">
    %alloc_131 = memref.alloc() : memref<1xi128, "stream">
    %alloc_132 = memref.alloc() : memref<1xi128, "stream">
    %alloc_133 = memref.alloc() : memref<1xi128, "stream">
    %alloc_134 = memref.alloc() : memref<1xi128, "stream">
    %alloc_135 = memref.alloc() : memref<1xi128, "stream">
    %alloc_136 = memref.alloc() : memref<1xi128, "stream">
    %alloc_137 = memref.alloc() : memref<1xi128, "stream">
    %alloc_138 = memref.alloc() : memref<1xi128, "stream">
    %alloc_139 = memref.alloc() : memref<1xi128, "stream">
    %alloc_140 = memref.alloc() : memref<1xi128, "stream">
    %alloc_141 = memref.alloc() : memref<1xi128, "stream">
    %alloc_142 = memref.alloc() : memref<1xi128, "stream">
    %alloc_143 = memref.alloc() : memref<1xi128, "stream">
    %alloc_144 = memref.alloc() : memref<1xi128, "stream">
    %alloc_145 = memref.alloc() : memref<1xi128, "stream">
    %alloc_146 = memref.alloc() : memref<1xi128, "stream">
    %alloc_147 = memref.alloc() : memref<1xi128, "stream">
    %alloc_148 = memref.alloc() : memref<1xi128, "stream">
    %alloc_149 = memref.alloc() : memref<1xi128, "stream">
    %alloc_150 = memref.alloc() : memref<1xi128, "stream">
    %alloc_151 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_152 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_153 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_154 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_155 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_156 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_157 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_158 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_159 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_160 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_161 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_162 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_163 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_164 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_165 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_166 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_167 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_168 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_169 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_170 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_171 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_172 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_173 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_174 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_175 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_176 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_177 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_178 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_179 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_180 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_181 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_182 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_183 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_184 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_185 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_186 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_187 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_188 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_189 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_190 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_191 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_192 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_193 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_194 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_195 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_196 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_197 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_198 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_199 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_200 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_201 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_202 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_203 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_204 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_205 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_206 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_207 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_208 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_209 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_210 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_211 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_212 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_213 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_214 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_215 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_216 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_217 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_218 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_219 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_220 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_221 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_222 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_223 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_224 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_225 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_226 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_227 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_228 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_229 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_230 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_231 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_232 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_233 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_234 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_235 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_236 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_237 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_238 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_239 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_240 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_241 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_242 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_243 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_244 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_245 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_246 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_247 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_248 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_249 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_250 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_251 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_252 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_253 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_254 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_255 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_256 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_257 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_258 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_259 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_260 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_261 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_262 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_263 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_264 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_265 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_266 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_267 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_268 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_269 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_270 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_271 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_272 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_273 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_274 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_275 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_276 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_277 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_278 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_279 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_280 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_281 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_282 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_283 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_284 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_285 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_286 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_287 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_288 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_289 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_290 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_291 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_292 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_293 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_294 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_295 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_296 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_297 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_298 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_299 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_300 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_301 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_302 = memref.alloc() : memref<1xi512, "stream1">
    call @receive13_top(%alloc_12, %arg59, %alloc_1, %arg119, %alloc_11, %arg101, %alloc_50, %arg84, %alloc, %arg73, %alloc_60, %arg31, %alloc_55, %arg145, %alloc_71, %arg97, %alloc_61, %arg24, %alloc_30, %arg30, %alloc_44, %arg23, %alloc_20, %arg93, %alloc_58, %arg88, %alloc_16, %arg120, %alloc_51, %arg7, %alloc_68, %arg50, %alloc_46, %arg46, %alloc_59, %arg113, %alloc_39, %arg44, %alloc_74, %arg17, %alloc_7, %arg35, %alloc_47, %arg121, %alloc_13, %arg12, %alloc_0, %arg110, %alloc_21, %arg58, %alloc_36, %arg56, %alloc_32, %arg129, %alloc_45, %arg43, %alloc_15, %arg111, %alloc_34, %arg96, %alloc_27, %arg28, %alloc_5, %arg153, %alloc_6, %arg63, %alloc_66, %arg150, %alloc_64, %arg149, %alloc_75, %arg8, %alloc_29, %arg118, %alloc_35, %arg26) : (memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send29_top(%alloc_121, %arg48, %alloc_129, %arg19, %alloc_128, %arg99, %alloc_133, %arg45, %alloc_124, %arg42, %alloc_120, %arg138, %alloc_118, %arg70, %alloc_130, %arg10, %alloc_126, %arg3, %alloc_147, %arg38, %alloc_131, %arg115, %alloc_122, %arg116, %alloc_142, %arg81, %alloc_137, %arg105, %alloc_123, %arg6, %alloc_138, %arg79, %alloc_135, %arg13, %alloc_134, %arg114, %alloc_125, %arg64, %alloc_132, %arg18, %alloc_119, %arg94, %alloc_143, %arg144, %alloc_127, %arg16, %alloc_139, %arg102, %alloc_141, %arg82, %alloc_115, %arg47, %alloc_140, %arg134, %alloc_116, %arg124, %alloc_136, %arg90, %alloc_117, %arg4, %alloc_145, %arg67, %alloc_149, %arg69) : (memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send39_top(%alloc_111, %arg49, %alloc_90, %arg72, %alloc_104, %arg103, %alloc_91, %arg95, %alloc_107, %arg5, %alloc_79, %arg143, %alloc_82, %arg37, %alloc_102, %arg54, %alloc_144, %arg15, %alloc_101, %arg89, %alloc_97, %arg131, %alloc_100, %arg33, %alloc_112, %arg83, %alloc_108, %arg117, %alloc_148, %arg141, %alloc_86, %arg133, %alloc_93, %arg80, %alloc_95, %arg25, %alloc_96, %arg106, %alloc_94, %arg98, %alloc_89, %arg146, %alloc_80, %arg20, %alloc_150, %arg148, %alloc_146, %arg85, %alloc_105, %arg139, %alloc_103, %arg87, %alloc_85, %arg128, %alloc_114, %arg86, %alloc_110, %arg71, %alloc_83, %arg100, %alloc_106, %arg9, %alloc_99, %arg41, %alloc_81, %arg52, %alloc_92, %arg68, %alloc_98, %arg55, %alloc_84, %arg14, %alloc_88, %arg76, %alloc_109, %arg74, %alloc_87, %arg140, %alloc_113, %arg53) : (memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @receive27_top(%arg32, %alloc_26, %arg34, %alloc_41, %arg39, %alloc_43, %arg137, %alloc_72, %arg132, %alloc_62, %arg57, %alloc_9, %arg91, %alloc_23, %arg109, %alloc_52, %arg29, %alloc_57, %arg147, %alloc_42, %arg154, %alloc_28, %arg62, %alloc_73, %arg36, %alloc_53, %arg11, %alloc_76, %arg104, %alloc_49, %arg65, %alloc_78, %arg130, %alloc_54, %arg27, %alloc_38, %arg142, %alloc_17, %arg122, %alloc_70, %arg21, %alloc_8, %arg127, %alloc_14, %arg123, %alloc_19, %arg125, %alloc_18, %arg151, %alloc_37, %arg108, %alloc_40, %arg112, %alloc_48, %arg77, %alloc_69, %arg51, %alloc_4, %arg60, %alloc_77, %arg61, %alloc_2, %arg136, %alloc_65, %arg107, %alloc_10, %arg66, %alloc_33, %arg75, %alloc_56, %arg126, %alloc_22, %arg135, %alloc_67, %arg78, %alloc_63, %arg22, %alloc_24, %arg92, %alloc_3, %arg152, %alloc_25, %arg40, %alloc_31) : (memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @store0_0_top(%alloc, %alloc_151, %alloc_0, %alloc_152, %alloc_1, %alloc_153, %alloc_2, %alloc_154, %alloc_3, %alloc_155, %alloc_4, %alloc_156, %alloc_5, %alloc_157, %alloc_6, %alloc_158, %alloc_7, %alloc_159, %alloc_8, %alloc_160, %alloc_9, %alloc_161, %alloc_10, %alloc_162, %alloc_11, %alloc_163, %alloc_12, %alloc_164, %alloc_13, %alloc_165, %alloc_14, %alloc_166, %alloc_15, %alloc_167, %alloc_16, %alloc_168, %alloc_17, %alloc_169, %alloc_18, %alloc_170, %alloc_19, %alloc_171, %alloc_20, %alloc_172, %alloc_21, %alloc_173, %alloc_22, %alloc_174, %alloc_23, %alloc_175, %alloc_24, %alloc_176, %alloc_25, %alloc_177, %alloc_26, %alloc_178, %alloc_27, %alloc_179, %alloc_28, %alloc_180, %alloc_29, %alloc_181, %alloc_30, %alloc_182, %alloc_31, %alloc_183, %alloc_32, %alloc_184, %alloc_33, %alloc_185, %alloc_34, %alloc_186, %alloc_35, %alloc_187, %alloc_36, %alloc_188, %alloc_37, %alloc_189, %alloc_38, %alloc_190, %alloc_39, %alloc_191, %alloc_40, %alloc_192, %alloc_41, %alloc_193, %alloc_42, %alloc_194, %alloc_43, %alloc_195, %alloc_44, %alloc_196, %alloc_45, %alloc_197, %alloc_46, %alloc_198, %alloc_47, %alloc_199, %alloc_48, %alloc_200, %alloc_49, %alloc_201, %alloc_50, %alloc_202, %alloc_51, %alloc_203, %alloc_52, %alloc_204, %alloc_53, %alloc_205, %alloc_54, %alloc_206, %alloc_55, %alloc_207, %alloc_56, %alloc_208, %alloc_57, %alloc_209, %alloc_58, %alloc_210, %alloc_59, %alloc_211, %alloc_60, %alloc_212, %alloc_61, %alloc_213, %alloc_62, %alloc_214, %alloc_63, %alloc_215, %alloc_64, %alloc_216, %alloc_65, %alloc_217, %alloc_66, %alloc_218, %alloc_67, %alloc_219, %alloc_68, %alloc_220, %alloc_69, %alloc_221, %alloc_70, %alloc_222, %alloc_71, %alloc_223, %alloc_72, %alloc_224, %alloc_73, %alloc_225, %alloc_74, %alloc_226, %alloc_75, %alloc_227, %alloc_76, %alloc_228, %alloc_77, %alloc_229, %alloc_78, %alloc_230) : (memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_top(%alloc_184, %alloc_182, %alloc_167, %alloc_154, %arg2, %alloc_164, %alloc_192, %alloc_188, %alloc_210, %alloc_218, %alloc_213, %alloc_169, %alloc_157, %alloc_199, %alloc_198, %alloc_181, %alloc_196, %alloc_208, %alloc_205, %alloc_225, %alloc_180, %alloc_203, %alloc_168, %alloc_171, %alloc_173, %alloc_222, %alloc_201, %alloc_212, %alloc_204, %alloc_158, %alloc_183, %alloc_215, %alloc_211, %alloc_151, %alloc_163, %alloc_220, %alloc_228, %alloc_230, %alloc_202, %alloc_177, %alloc_226, %alloc_153, %alloc_187, %alloc_193, %alloc_216, %alloc_217, %alloc_178, %alloc_175, %alloc_159, %alloc_170, %alloc_224, %alloc_206, %alloc_162, %alloc_227, %alloc_229, %alloc_165, %alloc_189, %alloc_166, %alloc_160, %alloc_191, %alloc_197, %alloc_209, %alloc_194, %alloc_190, %alloc_223, %alloc_207, %alloc_219, %alloc_174, %alloc_200, %alloc_195, %alloc_155, %alloc_221, %alloc_152, %alloc_179, %alloc_161, %alloc_176, %alloc_186, %alloc_185, %alloc_214, %alloc_156, %alloc_172) : (memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<2560x64xi512>, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">) -> ()
    call @load0_top(%alloc_242, %alloc_266, %alloc_241, %alloc_245, %alloc_247, %alloc_267, %alloc_260, %alloc_249, %alloc_265, %alloc_243, %alloc_256, %alloc_262, %alloc_246, %alloc_263, %alloc_255, %alloc_269, %alloc_248, %alloc_244, %alloc_261, %alloc_257, %alloc_237, %alloc_253, %alloc_232, %alloc_264, %alloc_231, %alloc_251, %alloc_254, %alloc_270, %alloc_259, %alloc_239, %alloc_258, %alloc_268, %alloc_240, %alloc_238, %alloc_235, %alloc_233, %alloc_234, %alloc_252, %alloc_250, %arg0, %alloc_236) : (memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<2560x1024xi512>, memref<1xi512, "stream1">) -> ()
    call @load0_39_top(%alloc_270, %alloc_150, %alloc_269, %alloc_148, %alloc_268, %alloc_146, %alloc_267, %alloc_144, %alloc_266, %alloc_114, %alloc_265, %alloc_113, %alloc_264, %alloc_112, %alloc_263, %alloc_111, %alloc_262, %alloc_110, %alloc_261, %alloc_109, %alloc_260, %alloc_108, %alloc_259, %alloc_107, %alloc_258, %alloc_106, %alloc_257, %alloc_105, %alloc_256, %alloc_104, %alloc_255, %alloc_103, %alloc_254, %alloc_102, %alloc_253, %alloc_101, %alloc_252, %alloc_100, %alloc_251, %alloc_99, %alloc_250, %alloc_98, %alloc_249, %alloc_97, %alloc_248, %alloc_96, %alloc_247, %alloc_95, %alloc_246, %alloc_94, %alloc_245, %alloc_93, %alloc_244, %alloc_92, %alloc_243, %alloc_91, %alloc_242, %alloc_90, %alloc_241, %alloc_89, %alloc_240, %alloc_88, %alloc_239, %alloc_87, %alloc_238, %alloc_86, %alloc_237, %alloc_85, %alloc_236, %alloc_84, %alloc_235, %alloc_83, %alloc_234, %alloc_82, %alloc_233, %alloc_81, %alloc_232, %alloc_80, %alloc_231, %alloc_79) : (memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load1_top(%alloc_285, %alloc_274, %alloc_287, %alloc_286, %alloc_294, %alloc_275, %arg1, %alloc_296, %alloc_272, %alloc_297, %alloc_295, %alloc_277, %alloc_302, %alloc_293, %alloc_298, %alloc_280, %alloc_289, %alloc_288, %alloc_281, %alloc_284, %alloc_282, %alloc_300, %alloc_279, %alloc_299, %alloc_283, %alloc_290, %alloc_301, %alloc_273, %alloc_291, %alloc_271, %alloc_292, %alloc_276, %alloc_278) : (memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<65536x64xi512>, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">) -> ()
    call @load1_31_top(%alloc_302, %alloc_149, %alloc_301, %alloc_147, %alloc_300, %alloc_145, %alloc_299, %alloc_143, %alloc_298, %alloc_142, %alloc_297, %alloc_141, %alloc_296, %alloc_140, %alloc_295, %alloc_139, %alloc_294, %alloc_138, %alloc_293, %alloc_137, %alloc_292, %alloc_136, %alloc_291, %alloc_135, %alloc_290, %alloc_134, %alloc_289, %alloc_133, %alloc_288, %alloc_132, %alloc_287, %alloc_131, %alloc_286, %alloc_130, %alloc_285, %alloc_129, %alloc_284, %alloc_128, %alloc_283, %alloc_127, %alloc_282, %alloc_126, %alloc_281, %alloc_125, %alloc_280, %alloc_124, %alloc_279, %alloc_123, %alloc_278, %alloc_122, %alloc_277, %alloc_121, %alloc_276, %alloc_120, %alloc_275, %alloc_119, %alloc_274, %alloc_118, %alloc_273, %alloc_117, %alloc_272, %alloc_116, %alloc_271, %alloc_115) : (memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    return
  }
  func.func @gemm(%arg0: memref<2560x1024xi512>, %arg1: memref<65536x64xi512>, %arg2: memref<2560x64xi512>, %arg3: memref<1xi128, "plio">, %arg4: memref<1xi128, "plio">, %arg5: memref<1xi128, "plio">, %arg6: memref<1xi128, "plio">, %arg7: memref<1xi128, "plio">, %arg8: memref<1xi128, "plio">, %arg9: memref<1xi128, "plio">, %arg10: memref<1xi128, "plio">, %arg11: memref<1xi128, "plio">, %arg12: memref<1xi128, "plio">, %arg13: memref<1xi128, "plio">, %arg14: memref<1xi128, "plio">, %arg15: memref<1xi128, "plio">, %arg16: memref<1xi128, "plio">, %arg17: memref<1xi128, "plio">, %arg18: memref<1xi128, "plio">, %arg19: memref<1xi128, "plio">, %arg20: memref<1xi128, "plio">, %arg21: memref<1xi128, "plio">, %arg22: memref<1xi128, "plio">, %arg23: memref<1xi128, "plio">, %arg24: memref<1xi128, "plio">, %arg25: memref<1xi128, "plio">, %arg26: memref<1xi128, "plio">, %arg27: memref<1xi128, "plio">, %arg28: memref<1xi128, "plio">, %arg29: memref<1xi128, "plio">, %arg30: memref<1xi128, "plio">, %arg31: memref<1xi128, "plio">, %arg32: memref<1xi128, "plio">, %arg33: memref<1xi128, "plio">, %arg34: memref<1xi128, "plio">, %arg35: memref<1xi128, "plio">, %arg36: memref<1xi128, "plio">, %arg37: memref<1xi128, "plio">, %arg38: memref<1xi128, "plio">, %arg39: memref<1xi128, "plio">, %arg40: memref<1xi128, "plio">, %arg41: memref<1xi128, "plio">, %arg42: memref<1xi128, "plio">, %arg43: memref<1xi128, "plio">, %arg44: memref<1xi128, "plio">, %arg45: memref<1xi128, "plio">, %arg46: memref<1xi128, "plio">, %arg47: memref<1xi128, "plio">, %arg48: memref<1xi128, "plio">, %arg49: memref<1xi128, "plio">, %arg50: memref<1xi128, "plio">, %arg51: memref<1xi128, "plio">, %arg52: memref<1xi128, "plio">, %arg53: memref<1xi128, "plio">, %arg54: memref<1xi128, "plio">, %arg55: memref<1xi128, "plio">, %arg56: memref<1xi128, "plio">, %arg57: memref<1xi128, "plio">, %arg58: memref<1xi128, "plio">, %arg59: memref<1xi128, "plio">, %arg60: memref<1xi128, "plio">, %arg61: memref<1xi128, "plio">, %arg62: memref<1xi128, "plio">, %arg63: memref<1xi128, "plio">, %arg64: memref<1xi128, "plio">, %arg65: memref<1xi128, "plio">, %arg66: memref<1xi128, "plio">, %arg67: memref<1xi128, "plio">, %arg68: memref<1xi128, "plio">, %arg69: memref<1xi128, "plio">, %arg70: memref<1xi128, "plio">, %arg71: memref<1xi128, "plio">, %arg72: memref<1xi128, "plio">, %arg73: memref<1xi128, "plio">, %arg74: memref<1xi128, "plio">, %arg75: memref<1xi128, "plio">, %arg76: memref<1xi128, "plio">, %arg77: memref<1xi128, "plio">, %arg78: memref<1xi128, "plio">, %arg79: memref<1xi128, "plio">, %arg80: memref<1xi128, "plio">, %arg81: memref<1xi128, "plio">, %arg82: memref<1xi128, "plio">, %arg83: memref<1xi128, "plio">, %arg84: memref<1xi128, "plio">, %arg85: memref<1xi128, "plio">, %arg86: memref<1xi128, "plio">, %arg87: memref<1xi128, "plio">, %arg88: memref<1xi128, "plio">, %arg89: memref<1xi128, "plio">, %arg90: memref<1xi128, "plio">, %arg91: memref<1xi128, "plio">, %arg92: memref<1xi128, "plio">, %arg93: memref<1xi128, "plio">, %arg94: memref<1xi128, "plio">, %arg95: memref<1xi128, "plio">, %arg96: memref<1xi128, "plio">, %arg97: memref<1xi128, "plio">, %arg98: memref<1xi128, "plio">, %arg99: memref<1xi128, "plio">, %arg100: memref<1xi128, "plio">, %arg101: memref<1xi128, "plio">, %arg102: memref<1xi128, "plio">, %arg103: memref<1xi128, "plio">, %arg104: memref<1xi128, "plio">, %arg105: memref<1xi128, "plio">, %arg106: memref<1xi128, "plio">, %arg107: memref<1xi128, "plio">, %arg108: memref<1xi128, "plio">, %arg109: memref<1xi128, "plio">, %arg110: memref<1xi128, "plio">, %arg111: memref<1xi128, "plio">, %arg112: memref<1xi128, "plio">, %arg113: memref<1xi128, "plio">, %arg114: memref<1xi128, "plio">, %arg115: memref<1xi128, "plio">, %arg116: memref<1xi128, "plio">, %arg117: memref<1xi128, "plio">, %arg118: memref<1xi128, "plio">, %arg119: memref<1xi128, "plio">, %arg120: memref<1xi128, "plio">, %arg121: memref<1xi128, "plio">, %arg122: memref<1xi128, "plio">, %arg123: memref<1xi128, "plio">, %arg124: memref<1xi128, "plio">, %arg125: memref<1xi128, "plio">, %arg126: memref<1xi128, "plio">, %arg127: memref<1xi128, "plio">, %arg128: memref<1xi128, "plio">, %arg129: memref<1xi128, "plio">, %arg130: memref<1xi128, "plio">, %arg131: memref<1xi128, "plio">, %arg132: memref<1xi128, "plio">, %arg133: memref<1xi128, "plio">, %arg134: memref<1xi128, "plio">, %arg135: memref<1xi128, "plio">, %arg136: memref<1xi128, "plio">, %arg137: memref<1xi128, "plio">, %arg138: memref<1xi128, "plio">, %arg139: memref<1xi128, "plio">, %arg140: memref<1xi128, "plio">, %arg141: memref<1xi128, "plio">, %arg142: memref<1xi128, "plio">, %arg143: memref<1xi128, "plio">, %arg144: memref<1xi128, "plio">, %arg145: memref<1xi128, "plio">, %arg146: memref<1xi128, "plio">, %arg147: memref<1xi128, "plio">, %arg148: memref<1xi128, "plio">, %arg149: memref<1xi128, "plio">, %arg150: memref<1xi128, "plio">, %arg151: memref<1xi128, "plio">, %arg152: memref<1xi128, "plio">, %arg153: memref<1xi128, "plio">, %arg154: memref<1xi128, "plio">) attributes {adf.func, gmio = false, plio = true} {
    %0 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%0, %arg65) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %1 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%1, %arg60) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %2 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%2, %arg11) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %3 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%3, %arg8) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %4 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%4, %arg17) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %5 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%5, %arg62) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %6 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%6, %arg137) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %7 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%7, %arg97) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %8 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg143, %8) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %9 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg20, %9) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %10 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg52, %10) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %11 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg37, %11) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %12 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%12, %arg122) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %13 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%13, %arg77) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %14 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%14, %arg50) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %15 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%15, %arg135) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %16 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%16, %arg150) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %17 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%17, %arg136) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %18 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%18, %arg149) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %19 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%19, %arg78) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %20 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg100, %20) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %21 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg14, %21) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %22 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg128, %22) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %23 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg133, %23) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %24 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%24, %arg132) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %25 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%25, %arg24) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %26 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%26, %arg31) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %27 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%27, %arg113) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %28 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%28, %arg88) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %29 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%29, %arg29) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %30 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%30, %arg75) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %31 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%31, %arg145) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %32 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg140, %32) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %33 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg76, %33) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %34 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg146, %34) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %35 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg72, %35) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %36 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%36, %arg130) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %37 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%37, %arg36) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %38 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%38, %arg109) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %39 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%39, %arg7) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %40 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%40, %arg84) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %41 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%41, %arg104) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %42 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%42, %arg112) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %43 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%43, %arg121) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %44 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg95, %44) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %45 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg68, %45) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %46 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg80, %46) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %47 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg98, %47) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %48 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%48, %arg46) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %49 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%49, %arg43) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %50 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%50, %arg23) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %51 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%51, %arg39) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %52 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%52, %arg147) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %53 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%53, %arg34) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %54 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%54, %arg108) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %55 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%55, %arg44) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %56 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg25, %56) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %57 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg106, %57) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %58 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg131, %58) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %59 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg55, %59) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %60 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%60, %arg27) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %61 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%61, %arg151) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %62 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%62, %arg56) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %63 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%63, %arg26) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %64 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%64, %arg96) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %65 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%65, %arg66) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %66 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%66, %arg129) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %67 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%67, %arg40) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %68 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg41, %68) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %69 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg33, %69) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %70 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg89, %70) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %71 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg54, %71) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %72 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%72, %arg30) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %73 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%73, %arg118) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %74 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%74, %arg154) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %75 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%75, %arg28) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %76 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%76, %arg32) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %77 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%77, %arg152) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %78 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%78, %arg22) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %79 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%79, %arg91) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %80 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg87, %80) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %81 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg103, %81) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %82 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg139, %82) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %83 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg9, %83) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %84 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%84, %arg126) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %85 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%85, %arg58) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %86 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%86, %arg93) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %87 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%87, %arg123) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %88 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%88, %arg125) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %89 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%89, %arg142) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %90 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%90, %arg120) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %91 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%91, %arg111) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %92 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg5, %92) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %93 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg117, %93) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %94 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg74, %94) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %95 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg71, %95) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %96 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%96, %arg127) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %97 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%97, %arg12) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %98 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%98, %arg59) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %99 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%99, %arg101) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %100 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%100, %arg107) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %101 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%101, %arg57) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %102 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%102, %arg21) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %103 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%103, %arg35) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %104 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg49, %104) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %105 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg83, %105) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %106 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg53, %106) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %107 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg86, %107) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %108 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%108, %arg63) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %109 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg47, %109) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %110 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg124, %110) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %111 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg4, %111) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %112 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg70, %112) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %113 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%113, %arg153) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %114 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg94, %114) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %115 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg138, %115) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %116 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg48, %116) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %117 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg116, %117) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %118 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%118, %arg51) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %119 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg6, %119) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %120 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg42, %120) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %121 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg64, %121) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %122 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg3, %122) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %123 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%123, %arg92) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %124 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg16, %124) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %125 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg99, %125) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %126 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg19, %126) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %127 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg10, %127) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %128 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%128, %arg61) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %129 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg115, %129) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %130 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg18, %130) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %131 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg45, %131) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %132 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg114, %132) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %133 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%133, %arg119) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %134 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg13, %134) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %135 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg90, %135) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %136 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg105, %136) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %137 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg79, %137) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %138 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%138, %arg110) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %139 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg102, %139) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %140 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg134, %140) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %141 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg82, %141) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %142 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg81, %142) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %143 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%143, %arg73) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %144 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg144, %144) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %145 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg15, %145) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %146 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg67, %146) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %147 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg85, %147) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %148 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg38, %148) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %149 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg141, %149) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %150 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg69, %150) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %151 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg148, %151) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    adf.cell.launch @adf_cell0 {
      func.call @adf_cell0(%151, %150, %149, %148, %147, %146, %145, %144, %143, %142, %141, %140, %139, %138, %137, %136, %135, %134, %133, %132, %131, %130, %129, %128, %127, %126, %125, %124, %123, %122, %121, %120, %119, %118, %117, %116, %115, %114, %113, %112, %111, %110, %109, %108, %107, %106, %105, %104, %103, %102, %101, %100, %99, %98, %97, %96, %95, %94, %93, %92, %91, %90, %89, %88, %87, %86, %85, %84, %83, %82, %81, %80, %79, %78, %77, %76, %75, %74, %73, %72, %71, %70, %69, %68, %67, %66, %65, %64, %63, %62, %61, %60, %59, %58, %57, %56, %55, %54, %53, %52, %51, %50, %49, %48, %47, %46, %45, %44, %43, %42, %41, %40, %39, %38, %37, %36, %35, %34, %33, %32, %31, %30, %29, %28, %27, %26, %25, %24, %23, %22, %21, %20, %19, %18, %17, %16, %15, %14, %13, %12, %11, %10, %9, %8, %7, %6, %5, %4, %3, %2, %1, %0) {adf.cell} : (!adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<Out, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<Out, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<Out, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<Out, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<Out, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<Out, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<Out, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<Out, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>) -> ()
      adf.cell.launch.end
    }
    adf.pl.launch @gemm_pl {
      func.call @gemm_pl(%arg0, %arg1, %arg2, %arg3, %arg4, %arg5, %arg6, %arg7, %arg8, %arg9, %arg10, %arg11, %arg12, %arg13, %arg14, %arg15, %arg16, %arg17, %arg18, %arg19, %arg20, %arg21, %arg22, %arg23, %arg24, %arg25, %arg26, %arg27, %arg28, %arg29, %arg30, %arg31, %arg32, %arg33, %arg34, %arg35, %arg36, %arg37, %arg38, %arg39, %arg40, %arg41, %arg42, %arg43, %arg44, %arg45, %arg46, %arg47, %arg48, %arg49, %arg50, %arg51, %arg52, %arg53, %arg54, %arg55, %arg56, %arg57, %arg58, %arg59, %arg60, %arg61, %arg62, %arg63, %arg64, %arg65, %arg66, %arg67, %arg68, %arg69, %arg70, %arg71, %arg72, %arg73, %arg74, %arg75, %arg76, %arg77, %arg78, %arg79, %arg80, %arg81, %arg82, %arg83, %arg84, %arg85, %arg86, %arg87, %arg88, %arg89, %arg90, %arg91, %arg92, %arg93, %arg94, %arg95, %arg96, %arg97, %arg98, %arg99, %arg100, %arg101, %arg102, %arg103, %arg104, %arg105, %arg106, %arg107, %arg108, %arg109, %arg110, %arg111, %arg112, %arg113, %arg114, %arg115, %arg116, %arg117, %arg118, %arg119, %arg120, %arg121, %arg122, %arg123, %arg124, %arg125, %arg126, %arg127, %arg128, %arg129, %arg130, %arg131, %arg132, %arg133, %arg134, %arg135, %arg136, %arg137, %arg138, %arg139, %arg140, %arg141, %arg142, %arg143, %arg144, %arg145, %arg146, %arg147, %arg148, %arg149, %arg150, %arg151, %arg152, %arg153, %arg154) {adf.pl} : (memref<2560x1024xi512>, memref<65536x64xi512>, memref<2560x64xi512>, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">) -> ()
      adf.pl.launch.wait
    }
    return
  }
  func.func @top(%arg0: memref<2560x1024xi512>, %arg1: memref<65536x64xi512>, %arg2: memref<2560x64xi512>, %arg3: memref<1xi128, "plio">, %arg4: memref<1xi128, "plio">, %arg5: memref<1xi128, "plio">, %arg6: memref<1xi128, "plio">, %arg7: memref<1xi128, "plio">, %arg8: memref<1xi128, "plio">, %arg9: memref<1xi128, "plio">, %arg10: memref<1xi128, "plio">, %arg11: memref<1xi128, "plio">, %arg12: memref<1xi128, "plio">, %arg13: memref<1xi128, "plio">, %arg14: memref<1xi128, "plio">, %arg15: memref<1xi128, "plio">, %arg16: memref<1xi128, "plio">, %arg17: memref<1xi128, "plio">, %arg18: memref<1xi128, "plio">, %arg19: memref<1xi128, "plio">, %arg20: memref<1xi128, "plio">, %arg21: memref<1xi128, "plio">, %arg22: memref<1xi128, "plio">, %arg23: memref<1xi128, "plio">, %arg24: memref<1xi128, "plio">, %arg25: memref<1xi128, "plio">, %arg26: memref<1xi128, "plio">, %arg27: memref<1xi128, "plio">, %arg28: memref<1xi128, "plio">, %arg29: memref<1xi128, "plio">, %arg30: memref<1xi128, "plio">, %arg31: memref<1xi128, "plio">, %arg32: memref<1xi128, "plio">, %arg33: memref<1xi128, "plio">, %arg34: memref<1xi128, "plio">, %arg35: memref<1xi128, "plio">, %arg36: memref<1xi128, "plio">, %arg37: memref<1xi128, "plio">, %arg38: memref<1xi128, "plio">, %arg39: memref<1xi128, "plio">, %arg40: memref<1xi128, "plio">, %arg41: memref<1xi128, "plio">, %arg42: memref<1xi128, "plio">, %arg43: memref<1xi128, "plio">, %arg44: memref<1xi128, "plio">, %arg45: memref<1xi128, "plio">, %arg46: memref<1xi128, "plio">, %arg47: memref<1xi128, "plio">, %arg48: memref<1xi128, "plio">, %arg49: memref<1xi128, "plio">, %arg50: memref<1xi128, "plio">, %arg51: memref<1xi128, "plio">, %arg52: memref<1xi128, "plio">, %arg53: memref<1xi128, "plio">, %arg54: memref<1xi128, "plio">, %arg55: memref<1xi128, "plio">, %arg56: memref<1xi128, "plio">, %arg57: memref<1xi128, "plio">, %arg58: memref<1xi128, "plio">, %arg59: memref<1xi128, "plio">, %arg60: memref<1xi128, "plio">, %arg61: memref<1xi128, "plio">, %arg62: memref<1xi128, "plio">, %arg63: memref<1xi128, "plio">, %arg64: memref<1xi128, "plio">, %arg65: memref<1xi128, "plio">, %arg66: memref<1xi128, "plio">, %arg67: memref<1xi128, "plio">, %arg68: memref<1xi128, "plio">, %arg69: memref<1xi128, "plio">, %arg70: memref<1xi128, "plio">, %arg71: memref<1xi128, "plio">, %arg72: memref<1xi128, "plio">, %arg73: memref<1xi128, "plio">, %arg74: memref<1xi128, "plio">, %arg75: memref<1xi128, "plio">, %arg76: memref<1xi128, "plio">, %arg77: memref<1xi128, "plio">, %arg78: memref<1xi128, "plio">, %arg79: memref<1xi128, "plio">, %arg80: memref<1xi128, "plio">, %arg81: memref<1xi128, "plio">, %arg82: memref<1xi128, "plio">, %arg83: memref<1xi128, "plio">, %arg84: memref<1xi128, "plio">, %arg85: memref<1xi128, "plio">, %arg86: memref<1xi128, "plio">, %arg87: memref<1xi128, "plio">, %arg88: memref<1xi128, "plio">, %arg89: memref<1xi128, "plio">, %arg90: memref<1xi128, "plio">, %arg91: memref<1xi128, "plio">, %arg92: memref<1xi128, "plio">, %arg93: memref<1xi128, "plio">, %arg94: memref<1xi128, "plio">, %arg95: memref<1xi128, "plio">, %arg96: memref<1xi128, "plio">, %arg97: memref<1xi128, "plio">, %arg98: memref<1xi128, "plio">, %arg99: memref<1xi128, "plio">, %arg100: memref<1xi128, "plio">, %arg101: memref<1xi128, "plio">, %arg102: memref<1xi128, "plio">, %arg103: memref<1xi128, "plio">, %arg104: memref<1xi128, "plio">, %arg105: memref<1xi128, "plio">, %arg106: memref<1xi128, "plio">, %arg107: memref<1xi128, "plio">, %arg108: memref<1xi128, "plio">, %arg109: memref<1xi128, "plio">, %arg110: memref<1xi128, "plio">, %arg111: memref<1xi128, "plio">, %arg112: memref<1xi128, "plio">, %arg113: memref<1xi128, "plio">, %arg114: memref<1xi128, "plio">, %arg115: memref<1xi128, "plio">, %arg116: memref<1xi128, "plio">, %arg117: memref<1xi128, "plio">, %arg118: memref<1xi128, "plio">, %arg119: memref<1xi128, "plio">, %arg120: memref<1xi128, "plio">, %arg121: memref<1xi128, "plio">, %arg122: memref<1xi128, "plio">, %arg123: memref<1xi128, "plio">, %arg124: memref<1xi128, "plio">, %arg125: memref<1xi128, "plio">, %arg126: memref<1xi128, "plio">, %arg127: memref<1xi128, "plio">, %arg128: memref<1xi128, "plio">, %arg129: memref<1xi128, "plio">, %arg130: memref<1xi128, "plio">, %arg131: memref<1xi128, "plio">, %arg132: memref<1xi128, "plio">, %arg133: memref<1xi128, "plio">, %arg134: memref<1xi128, "plio">, %arg135: memref<1xi128, "plio">, %arg136: memref<1xi128, "plio">, %arg137: memref<1xi128, "plio">, %arg138: memref<1xi128, "plio">, %arg139: memref<1xi128, "plio">, %arg140: memref<1xi128, "plio">, %arg141: memref<1xi128, "plio">, %arg142: memref<1xi128, "plio">, %arg143: memref<1xi128, "plio">, %arg144: memref<1xi128, "plio">, %arg145: memref<1xi128, "plio">, %arg146: memref<1xi128, "plio">, %arg147: memref<1xi128, "plio">, %arg148: memref<1xi128, "plio">, %arg149: memref<1xi128, "plio">, %arg150: memref<1xi128, "plio">, %arg151: memref<1xi128, "plio">, %arg152: memref<1xi128, "plio">, %arg153: memref<1xi128, "plio">, %arg154: memref<1xi128, "plio">) attributes {outArgs = [2 : i32], top_func = "plio"} {
    call @gemm_pl(%arg0, %arg1, %arg2, %arg3, %arg4, %arg5, %arg6, %arg7, %arg8, %arg9, %arg10, %arg11, %arg12, %arg13, %arg14, %arg15, %arg16, %arg17, %arg18, %arg19, %arg20, %arg21, %arg22, %arg23, %arg24, %arg25, %arg26, %arg27, %arg28, %arg29, %arg30, %arg31, %arg32, %arg33, %arg34, %arg35, %arg36, %arg37, %arg38, %arg39, %arg40, %arg41, %arg42, %arg43, %arg44, %arg45, %arg46, %arg47, %arg48, %arg49, %arg50, %arg51, %arg52, %arg53, %arg54, %arg55, %arg56, %arg57, %arg58, %arg59, %arg60, %arg61, %arg62, %arg63, %arg64, %arg65, %arg66, %arg67, %arg68, %arg69, %arg70, %arg71, %arg72, %arg73, %arg74, %arg75, %arg76, %arg77, %arg78, %arg79, %arg80, %arg81, %arg82, %arg83, %arg84, %arg85, %arg86, %arg87, %arg88, %arg89, %arg90, %arg91, %arg92, %arg93, %arg94, %arg95, %arg96, %arg97, %arg98, %arg99, %arg100, %arg101, %arg102, %arg103, %arg104, %arg105, %arg106, %arg107, %arg108, %arg109, %arg110, %arg111, %arg112, %arg113, %arg114, %arg115, %arg116, %arg117, %arg118, %arg119, %arg120, %arg121, %arg122, %arg123, %arg124, %arg125, %arg126, %arg127, %arg128, %arg129, %arg130, %arg131, %arg132, %arg133, %arg134, %arg135, %arg136, %arg137, %arg138, %arg139, %arg140, %arg141, %arg142, %arg143, %arg144, %arg145, %arg146, %arg147, %arg148, %arg149, %arg150, %arg151, %arg152, %arg153, %arg154) : (memref<2560x1024xi512>, memref<65536x64xi512>, memref<2560x64xi512>, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">) -> ()
    return
  }
  func.func @gemm_host(%arg0: memref<2560x65536xi8>, %arg1: memref<65536x4096xi8>, %arg2: memref<2560x4096xi8>) attributes {origin_func = "gemm"} {
    affine.for %arg3 = 0 to 2560 {
      affine.for %arg4 = 0 to 4096 {
        affine.for %arg5 = 0 to 65536 {
          %0 = affine.load %arg0[%arg3, %arg5] : memref<2560x65536xi8>
          %1 = affine.load %arg1[%arg5, %arg4] : memref<65536x4096xi8>
          %2 = arith.muli %0, %1 : i8
          %3 = affine.load %arg2[%arg3, %arg4] : memref<2560x4096xi8>
          %4 = arith.addi %3, %2 : i8
          affine.store %4, %arg2[%arg3, %arg4] : memref<2560x4096xi8>
        } {reduction}
      }
    }
    return
  }
  func.func @top_host(%arg0: memref<2560x65536xi8>, %arg1: memref<65536x4096xi8>, %arg2: memref<2560x4096xi8>) attributes {origin_func = "top", outArgs = [2 : i32], top_host} {
    call @gemm_host(%arg0, %arg1, %arg2) {origin_func = "gemm"} : (memref<2560x65536xi8>, memref<65536x4096xi8>, memref<2560x4096xi8>) -> ()
    return
  }
}

