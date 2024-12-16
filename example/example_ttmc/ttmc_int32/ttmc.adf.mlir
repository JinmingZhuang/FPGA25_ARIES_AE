#map = affine_map<(d0) -> (d0 * 128 + 127)>
#map1 = affine_map<(d0) -> (d0 * 128)>
module {
  func.func @kernel_ttmc0(%arg0: memref<2x16x32xi32, 2>, %arg1: memref<16x16xi32, 2>, %arg2: memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2> attributes {adf.kernel, edge_kernel} {
    %c0_i32 = arith.constant 0 : i32
    %alloc = memref.alloc() : memref<2x16x16xi32, 2>
    affine.for %arg3 = 0 to 2 {
      affine.for %arg4 = 0 to 16 {
        affine.for %arg5 = 0 to 16 {
          affine.store %c0_i32, %alloc[%arg3, %arg4, %arg5] : memref<2x16x16xi32, 2>
        }
      }
    }
    affine.for %arg3 = 0 to 2 {
      affine.for %arg4 = 0 to 16 {
        affine.for %arg5 = 0 to 16 {
          affine.for %arg6 = 0 to 16 {
            affine.for %arg7 = 0 to 32 {
              %0 = affine.load %arg0[%arg3, %arg6, %arg7] : memref<2x16x32xi32, 2>
              %1 = affine.load %arg1[%arg6, %arg4] : memref<16x16xi32, 2>
              %2 = affine.load %arg2[%arg7, %arg5] : memref<32x16xi32, 2>
              %3 = arith.muli %0, %1 : i32
              %4 = arith.muli %3, %2 : i32
              %5 = affine.load %alloc[%arg3, %arg4, %arg5] : memref<2x16x16xi32, 2>
              %6 = arith.addi %5, %4 : i32
              affine.store %6, %alloc[%arg3, %arg4, %arg5] : memref<2x16x16xi32, 2>
            }
          }
        }
      }
    }
    return %alloc : memref<2x16x16xi32, 2>
  }
  func.func @kernel_ttmc(%arg0: memref<2x16x32xi32, 2>, %arg1: memref<16x16xi32, 2>, %arg2: memref<32x16xi32, 2>, %arg3: memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2> attributes {adf.kernel} {
    %alloc = memref.alloc() : memref<2x16x16xi32, 2>
    affine.for %arg4 = 0 to 2 {
      affine.for %arg5 = 0 to 16 {
        affine.for %arg6 = 0 to 16 {
          %0 = affine.load %arg3[%arg4, %arg5, %arg6] : memref<2x16x16xi32, 2>
          affine.store %0, %alloc[%arg4, %arg5, %arg6] : memref<2x16x16xi32, 2>
          affine.for %arg7 = 0 to 16 {
            affine.for %arg8 = 0 to 32 {
              %1 = affine.load %arg0[%arg4, %arg7, %arg8] : memref<2x16x32xi32, 2>
              %2 = affine.load %arg1[%arg7, %arg5] : memref<16x16xi32, 2>
              %3 = affine.load %arg2[%arg8, %arg6] : memref<32x16xi32, 2>
              %4 = arith.muli %1, %2 : i32
              %5 = arith.muli %4, %3 : i32
              %6 = affine.load %alloc[%arg4, %arg5, %arg6] : memref<2x16x16xi32, 2>
              %7 = arith.addi %6, %5 : i32
              affine.store %7, %alloc[%arg4, %arg5, %arg6] : memref<2x16x16xi32, 2>
            }
          }
        }
      }
    }
    return %alloc : memref<2x16x16xi32, 2>
  }
  func.func @adf_cell0(%arg0: !adf.plio<In, 128>, %arg1: !adf.plio<In, 128>, %arg2: !adf.plio<In, 128>, %arg3: !adf.plio<In, 128>, %arg4: !adf.plio<In, 128>, %arg5: !adf.plio<Out, 128>, %arg6: !adf.plio<In, 128>, %arg7: !adf.plio<In, 128>, %arg8: !adf.plio<Out, 128>, %arg9: !adf.plio<In, 128>, %arg10: !adf.plio<In, 128>, %arg11: !adf.plio<Out, 128>, %arg12: !adf.plio<In, 128>, %arg13: !adf.plio<In, 128>, %arg14: !adf.plio<Out, 128>, %arg15: !adf.plio<In, 128>, %arg16: !adf.plio<In, 128>, %arg17: !adf.plio<Out, 128>, %arg18: !adf.plio<In, 128>, %arg19: !adf.plio<In, 128>, %arg20: !adf.plio<Out, 128>, %arg21: !adf.plio<In, 128>, %arg22: !adf.plio<In, 128>, %arg23: !adf.plio<Out, 128>, %arg24: !adf.plio<In, 128>, %arg25: !adf.plio<In, 128>, %arg26: !adf.plio<Out, 128>, %arg27: !adf.plio<In, 128>, %arg28: !adf.plio<In, 128>, %arg29: !adf.plio<Out, 128>, %arg30: !adf.plio<In, 128>, %arg31: !adf.plio<In, 128>, %arg32: !adf.plio<Out, 128>, %arg33: !adf.plio<In, 128>, %arg34: !adf.plio<In, 128>, %arg35: !adf.plio<Out, 128>, %arg36: !adf.plio<In, 128>, %arg37: !adf.plio<In, 128>, %arg38: !adf.plio<Out, 128>, %arg39: !adf.plio<In, 128>, %arg40: !adf.plio<Out, 128>, %arg41: !adf.plio<Out, 128>, %arg42: !adf.plio<Out, 128>, %arg43: !adf.plio<Out, 128>, %arg44: !adf.plio<Out, 128>, %arg45: !adf.plio<Out, 128>, %arg46: !adf.plio<Out, 128>, %arg47: !adf.plio<Out, 128>, %arg48: !adf.plio<Out, 128>, %arg49: !adf.plio<Out, 128>, %arg50: !adf.plio<Out, 128>, %arg51: !adf.plio<Out, 128>, %arg52: !adf.plio<In, 128>, %arg53: !adf.plio<Out, 128>, %arg54: !adf.plio<Out, 128>, %arg55: !adf.plio<Out, 128>, %arg56: !adf.plio<Out, 128>, %arg57: !adf.plio<Out, 128>, %arg58: !adf.plio<Out, 128>, %arg59: !adf.plio<Out, 128>, %arg60: !adf.plio<Out, 128>, %arg61: !adf.plio<Out, 128>, %arg62: !adf.plio<Out, 128>, %arg63: !adf.plio<Out, 128>, %arg64: !adf.plio<Out, 128>, %arg65: !adf.plio<In, 128>, %arg66: !adf.plio<Out, 128>, %arg67: !adf.plio<Out, 128>, %arg68: !adf.plio<Out, 128>, %arg69: !adf.plio<Out, 128>, %arg70: !adf.plio<Out, 128>, %arg71: !adf.plio<Out, 128>, %arg72: !adf.plio<Out, 128>, %arg73: !adf.plio<Out, 128>, %arg74: !adf.plio<Out, 128>, %arg75: !adf.plio<Out, 128>, %arg76: !adf.plio<Out, 128>, %arg77: !adf.plio<Out, 128>, %arg78: !adf.plio<In, 128>, %arg79: !adf.plio<Out, 128>, %arg80: !adf.plio<Out, 128>, %arg81: !adf.plio<Out, 128>, %arg82: !adf.plio<Out, 128>, %arg83: !adf.plio<Out, 128>, %arg84: !adf.plio<Out, 128>, %arg85: !adf.plio<Out, 128>, %arg86: !adf.plio<Out, 128>, %arg87: !adf.plio<Out, 128>, %arg88: !adf.plio<Out, 128>, %arg89: !adf.plio<Out, 128>, %arg90: !adf.plio<Out, 128>, %arg91: !adf.plio<In, 128>, %arg92: !adf.plio<Out, 128>, %arg93: !adf.plio<Out, 128>, %arg94: !adf.plio<Out, 128>, %arg95: !adf.plio<Out, 128>, %arg96: !adf.plio<Out, 128>, %arg97: !adf.plio<Out, 128>, %arg98: !adf.plio<Out, 128>, %arg99: !adf.plio<Out, 128>, %arg100: !adf.plio<Out, 128>, %arg101: !adf.plio<Out, 128>, %arg102: !adf.plio<Out, 128>, %arg103: !adf.plio<Out, 128>, %arg104: !adf.plio<In, 128>, %arg105: !adf.plio<Out, 128>, %arg106: !adf.plio<Out, 128>, %arg107: !adf.plio<Out, 128>, %arg108: !adf.plio<Out, 128>, %arg109: !adf.plio<Out, 128>, %arg110: !adf.plio<Out, 128>, %arg111: !adf.plio<Out, 128>, %arg112: !adf.plio<Out, 128>, %arg113: !adf.plio<Out, 128>, %arg114: !adf.plio<Out, 128>, %arg115: !adf.plio<Out, 128>, %arg116: !adf.plio<Out, 128>, %arg117: !adf.plio<In, 128>, %arg118: !adf.plio<Out, 128>, %arg119: !adf.plio<Out, 128>, %arg120: !adf.plio<Out, 128>, %arg121: !adf.plio<Out, 128>, %arg122: !adf.plio<Out, 128>, %arg123: !adf.plio<Out, 128>, %arg124: !adf.plio<Out, 128>, %arg125: !adf.plio<Out, 128>, %arg126: !adf.plio<Out, 128>, %arg127: !adf.plio<Out, 128>, %arg128: !adf.plio<Out, 128>, %arg129: !adf.plio<Out, 128>) attributes {adf.cell, tripCount = [2 : index, 12 : index, 8 : index]} {
    %c48 = arith.constant 48 : index
    %c47 = arith.constant 47 : index
    %c44 = arith.constant 44 : index
    %c43 = arith.constant 43 : index
    %c40 = arith.constant 40 : index
    %c39 = arith.constant 39 : index
    %c36 = arith.constant 36 : index
    %c35 = arith.constant 35 : index
    %c32 = arith.constant 32 : index
    %c31 = arith.constant 31 : index
    %c28 = arith.constant 28 : index
    %c27 = arith.constant 27 : index
    %c24 = arith.constant 24 : index
    %c23 = arith.constant 23 : index
    %c20 = arith.constant 20 : index
    %c19 = arith.constant 19 : index
    %c16 = arith.constant 16 : index
    %c15 = arith.constant 15 : index
    %c12 = arith.constant 12 : index
    %c11 = arith.constant 11 : index
    %c8 = arith.constant 8 : index
    %c7 = arith.constant 7 : index
    %c4 = arith.constant 4 : index
    %c3 = arith.constant 3 : index
    %c46 = arith.constant 46 : index
    %c45 = arith.constant 45 : index
    %c42 = arith.constant 42 : index
    %c41 = arith.constant 41 : index
    %c38 = arith.constant 38 : index
    %c37 = arith.constant 37 : index
    %c34 = arith.constant 34 : index
    %c33 = arith.constant 33 : index
    %c30 = arith.constant 30 : index
    %c29 = arith.constant 29 : index
    %c26 = arith.constant 26 : index
    %c25 = arith.constant 25 : index
    %c22 = arith.constant 22 : index
    %c21 = arith.constant 21 : index
    %c18 = arith.constant 18 : index
    %c17 = arith.constant 17 : index
    %c14 = arith.constant 14 : index
    %c13 = arith.constant 13 : index
    %c10 = arith.constant 10 : index
    %c9 = arith.constant 9 : index
    %c6 = arith.constant 6 : index
    %c5 = arith.constant 5 : index
    %c2 = arith.constant 2 : index
    %c12288 = arith.constant 12288 : index
    %c4096 = arith.constant 4096 : index
    %c24576 = arith.constant 24576 : index
    %c16384 = arith.constant 16384 : index
    %c8192 = arith.constant 8192 : index
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    adf.config.plio(%arg5, 250) {"col, chl" = [6 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg8, 250) {"col, chl" = [6 : index, 2 : index]} : <Out, 128>
    adf.config.plio(%arg11, 250) {"col, chl" = [9 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg14, 250) {"col, chl" = [13 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg17, 250) {"col, chl" = [17 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg20, 250) {"col, chl" = [21 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg23, 250) {"col, chl" = [25 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg26, 250) {"col, chl" = [29 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg29, 250) {"col, chl" = [33 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg32, 250) {"col, chl" = [37 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg35, 250) {"col, chl" = [41 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg1, 250) {"col, chl" = [23 : index, 4 : index]} : <In, 128>
    adf.config.plio(%arg38, 250) {"col, chl" = [44 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg40, 250) {"col, chl" = [6 : index, 0 : index]} : <Out, 128>
    adf.config.plio(%arg41, 250) {"col, chl" = [7 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg42, 250) {"col, chl" = [9 : index, 2 : index]} : <Out, 128>
    adf.config.plio(%arg43, 250) {"col, chl" = [13 : index, 2 : index]} : <Out, 128>
    adf.config.plio(%arg44, 250) {"col, chl" = [17 : index, 2 : index]} : <Out, 128>
    adf.config.plio(%arg45, 250) {"col, chl" = [21 : index, 2 : index]} : <Out, 128>
    adf.config.plio(%arg46, 250) {"col, chl" = [25 : index, 2 : index]} : <Out, 128>
    adf.config.plio(%arg47, 250) {"col, chl" = [29 : index, 2 : index]} : <Out, 128>
    adf.config.plio(%arg48, 250) {"col, chl" = [33 : index, 2 : index]} : <Out, 128>
    adf.config.plio(%arg49, 250) {"col, chl" = [37 : index, 2 : index]} : <Out, 128>
    adf.config.plio(%arg50, 250) {"col, chl" = [41 : index, 2 : index]} : <Out, 128>
    adf.config.plio(%arg39, 250) {"col, chl" = [23 : index, 2 : index]} : <In, 128>
    adf.config.plio(%arg51, 250) {"col, chl" = [44 : index, 2 : index]} : <Out, 128>
    adf.config.plio(%arg53, 250) {"col, chl" = [7 : index, 2 : index]} : <Out, 128>
    adf.config.plio(%arg54, 250) {"col, chl" = [7 : index, 0 : index]} : <Out, 128>
    adf.config.plio(%arg55, 250) {"col, chl" = [9 : index, 0 : index]} : <Out, 128>
    adf.config.plio(%arg56, 250) {"col, chl" = [13 : index, 0 : index]} : <Out, 128>
    adf.config.plio(%arg57, 250) {"col, chl" = [17 : index, 0 : index]} : <Out, 128>
    adf.config.plio(%arg58, 250) {"col, chl" = [21 : index, 0 : index]} : <Out, 128>
    adf.config.plio(%arg59, 250) {"col, chl" = [25 : index, 0 : index]} : <Out, 128>
    adf.config.plio(%arg60, 250) {"col, chl" = [29 : index, 0 : index]} : <Out, 128>
    adf.config.plio(%arg61, 250) {"col, chl" = [33 : index, 0 : index]} : <Out, 128>
    adf.config.plio(%arg62, 250) {"col, chl" = [37 : index, 0 : index]} : <Out, 128>
    adf.config.plio(%arg63, 250) {"col, chl" = [41 : index, 0 : index]} : <Out, 128>
    adf.config.plio(%arg52, 250) {"col, chl" = [23 : index, 0 : index]} : <In, 128>
    adf.config.plio(%arg64, 250) {"col, chl" = [44 : index, 0 : index]} : <Out, 128>
    adf.config.plio(%arg66, 250) {"col, chl" = [8 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg67, 250) {"col, chl" = [8 : index, 2 : index]} : <Out, 128>
    adf.config.plio(%arg68, 250) {"col, chl" = [8 : index, 0 : index]} : <Out, 128>
    adf.config.plio(%arg69, 250) {"col, chl" = [12 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg70, 250) {"col, chl" = [16 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg71, 250) {"col, chl" = [20 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg72, 250) {"col, chl" = [24 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg73, 250) {"col, chl" = [28 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg74, 250) {"col, chl" = [32 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg75, 250) {"col, chl" = [36 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg76, 250) {"col, chl" = [40 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg65, 250) {"col, chl" = [22 : index, 4 : index]} : <In, 128>
    adf.config.plio(%arg77, 250) {"col, chl" = [43 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg79, 250) {"col, chl" = [10 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg80, 250) {"col, chl" = [10 : index, 2 : index]} : <Out, 128>
    adf.config.plio(%arg81, 250) {"col, chl" = [11 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg82, 250) {"col, chl" = [15 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg83, 250) {"col, chl" = [19 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg84, 250) {"col, chl" = [23 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg85, 250) {"col, chl" = [27 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg86, 250) {"col, chl" = [31 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg87, 250) {"col, chl" = [35 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg88, 250) {"col, chl" = [39 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg89, 250) {"col, chl" = [43 : index, 2 : index]} : <Out, 128>
    adf.config.plio(%arg78, 250) {"col, chl" = [25 : index, 4 : index]} : <In, 128>
    adf.config.plio(%arg90, 250) {"col, chl" = [43 : index, 0 : index]} : <Out, 128>
    adf.config.plio(%arg92, 250) {"col, chl" = [10 : index, 0 : index]} : <Out, 128>
    adf.config.plio(%arg93, 250) {"col, chl" = [11 : index, 2 : index]} : <Out, 128>
    adf.config.plio(%arg94, 250) {"col, chl" = [11 : index, 0 : index]} : <Out, 128>
    adf.config.plio(%arg95, 250) {"col, chl" = [15 : index, 2 : index]} : <Out, 128>
    adf.config.plio(%arg96, 250) {"col, chl" = [19 : index, 2 : index]} : <Out, 128>
    adf.config.plio(%arg97, 250) {"col, chl" = [23 : index, 2 : index]} : <Out, 128>
    adf.config.plio(%arg98, 250) {"col, chl" = [27 : index, 2 : index]} : <Out, 128>
    adf.config.plio(%arg99, 250) {"col, chl" = [31 : index, 2 : index]} : <Out, 128>
    adf.config.plio(%arg100, 250) {"col, chl" = [35 : index, 2 : index]} : <Out, 128>
    adf.config.plio(%arg101, 250) {"col, chl" = [39 : index, 2 : index]} : <Out, 128>
    adf.config.plio(%arg102, 250) {"col, chl" = [42 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg91, 250) {"col, chl" = [25 : index, 2 : index]} : <In, 128>
    adf.config.plio(%arg103, 250) {"col, chl" = [42 : index, 2 : index]} : <Out, 128>
    adf.config.plio(%arg105, 250) {"col, chl" = [12 : index, 2 : index]} : <Out, 128>
    adf.config.plio(%arg106, 250) {"col, chl" = [12 : index, 0 : index]} : <Out, 128>
    adf.config.plio(%arg107, 250) {"col, chl" = [14 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg108, 250) {"col, chl" = [15 : index, 0 : index]} : <Out, 128>
    adf.config.plio(%arg109, 250) {"col, chl" = [19 : index, 0 : index]} : <Out, 128>
    adf.config.plio(%arg110, 250) {"col, chl" = [23 : index, 0 : index]} : <Out, 128>
    adf.config.plio(%arg111, 250) {"col, chl" = [27 : index, 0 : index]} : <Out, 128>
    adf.config.plio(%arg112, 250) {"col, chl" = [31 : index, 0 : index]} : <Out, 128>
    adf.config.plio(%arg113, 250) {"col, chl" = [35 : index, 0 : index]} : <Out, 128>
    adf.config.plio(%arg114, 250) {"col, chl" = [39 : index, 0 : index]} : <Out, 128>
    adf.config.plio(%arg115, 250) {"col, chl" = [42 : index, 0 : index]} : <Out, 128>
    adf.config.plio(%arg104, 250) {"col, chl" = [25 : index, 0 : index]} : <In, 128>
    adf.config.plio(%arg116, 250) {"col, chl" = [40 : index, 2 : index]} : <Out, 128>
    adf.config.plio(%arg2, 250) {"col, chl" = [6 : index, 0 : index]} : <In, 128>
    adf.config.plio(%arg4, 250) {"col, chl" = [7 : index, 0 : index]} : <In, 128>
    adf.config.plio(%arg118, 250) {"col, chl" = [14 : index, 2 : index]} : <Out, 128>
    adf.config.plio(%arg6, 250) {"col, chl" = [8 : index, 2 : index]} : <In, 128>
    adf.config.plio(%arg7, 250) {"col, chl" = [8 : index, 0 : index]} : <In, 128>
    adf.config.plio(%arg119, 250) {"col, chl" = [14 : index, 0 : index]} : <Out, 128>
    adf.config.plio(%arg9, 250) {"col, chl" = [10 : index, 4 : index]} : <In, 128>
    adf.config.plio(%arg10, 250) {"col, chl" = [10 : index, 2 : index]} : <In, 128>
    adf.config.plio(%arg120, 250) {"col, chl" = [16 : index, 2 : index]} : <Out, 128>
    adf.config.plio(%arg12, 250) {"col, chl" = [14 : index, 4 : index]} : <In, 128>
    adf.config.plio(%arg13, 250) {"col, chl" = [14 : index, 2 : index]} : <In, 128>
    adf.config.plio(%arg121, 250) {"col, chl" = [16 : index, 0 : index]} : <Out, 128>
    adf.config.plio(%arg15, 250) {"col, chl" = [18 : index, 4 : index]} : <In, 128>
    adf.config.plio(%arg16, 250) {"col, chl" = [18 : index, 2 : index]} : <In, 128>
    adf.config.plio(%arg122, 250) {"col, chl" = [18 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg18, 250) {"col, chl" = [22 : index, 2 : index]} : <In, 128>
    adf.config.plio(%arg19, 250) {"col, chl" = [22 : index, 0 : index]} : <In, 128>
    adf.config.plio(%arg123, 250) {"col, chl" = [22 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg21, 250) {"col, chl" = [26 : index, 4 : index]} : <In, 128>
    adf.config.plio(%arg22, 250) {"col, chl" = [26 : index, 2 : index]} : <In, 128>
    adf.config.plio(%arg124, 250) {"col, chl" = [26 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg24, 250) {"col, chl" = [30 : index, 4 : index]} : <In, 128>
    adf.config.plio(%arg25, 250) {"col, chl" = [30 : index, 2 : index]} : <In, 128>
    adf.config.plio(%arg125, 250) {"col, chl" = [30 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg27, 250) {"col, chl" = [34 : index, 4 : index]} : <In, 128>
    adf.config.plio(%arg28, 250) {"col, chl" = [34 : index, 2 : index]} : <In, 128>
    adf.config.plio(%arg126, 250) {"col, chl" = [34 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg30, 250) {"col, chl" = [38 : index, 4 : index]} : <In, 128>
    adf.config.plio(%arg31, 250) {"col, chl" = [38 : index, 2 : index]} : <In, 128>
    adf.config.plio(%arg127, 250) {"col, chl" = [38 : index, 4 : index]} : <Out, 128>
    adf.config.plio(%arg33, 250) {"col, chl" = [42 : index, 2 : index]} : <In, 128>
    adf.config.plio(%arg34, 250) {"col, chl" = [42 : index, 0 : index]} : <In, 128>
    adf.config.plio(%arg128, 250) {"col, chl" = [40 : index, 0 : index]} : <Out, 128>
    adf.config.plio(%arg0, 250) {"col, chl" = [24 : index, 4 : index]} : <In, 128>
    adf.config.plio(%arg36, 250) {"col, chl" = [44 : index, 0 : index]} : <In, 128>
    adf.config.plio(%arg3, 250) {"col, chl" = [24 : index, 2 : index]} : <In, 128>
    adf.config.plio(%arg117, 250) {"col, chl" = [24 : index, 0 : index]} : <In, 128>
    adf.config.plio(%arg37, 250) {"col, chl" = [43 : index, 0 : index]} : <In, 128>
    adf.config.plio(%arg129, 250) {"col, chl" = [38 : index, 2 : index]} : <Out, 128>
    %0 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %0) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %1 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg1, %1) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %2 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg2, %2) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %3 = call @kernel_ttmc0(%0, %1, %2) {adf.kernel, "col, row" = [1 : index, 0 : index], ivs = [0 : index, 0 : index, 0 : index], kernel = 0 : index, kernel_ttmc0 = 0 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%3, %c1, %c0, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%1, %c1, %c0, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%2, %c1, %c1, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%0, %c1, %c1, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %4 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %4) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %5 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg1, %5) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %6 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg4, %6) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %7 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%3, %7) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %8 = call @kernel_ttmc(%4, %5, %6, %7) {adf.kernel, "col, row" = [1 : index, 1 : index], ivs = [1 : index, 0 : index, 0 : index], kernel_ttmc = 1 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%8, %c2, %c1, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%5, %c2, %c1, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%6, %c2, %c1, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%4, %c1, %c0, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%8, %arg5) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %9 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %9) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %10 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg1, %10) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %11 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg6, %11) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %12 = call @kernel_ttmc0(%9, %10, %11) {adf.kernel, "col, row" = [5 : index, 0 : index], ivs = [0 : index, 1 : index, 0 : index], kernel = 0 : index, kernel_ttmc0 = 2 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%12, %c5, %c0, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%10, %c5, %c0, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%11, %c5, %c1, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%9, %c5, %c1, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %13 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %13) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %14 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg1, %14) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %15 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg7, %15) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %16 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%12, %16) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %17 = call @kernel_ttmc(%13, %14, %15, %16) {adf.kernel, "col, row" = [5 : index, 1 : index], ivs = [1 : index, 1 : index, 0 : index], kernel_ttmc = 3 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%17, %c6, %c1, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%14, %c6, %c1, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%15, %c6, %c1, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%13, %c5, %c0, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%17, %arg8) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %18 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %18) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %19 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg1, %19) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %20 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg9, %20) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %21 = call @kernel_ttmc0(%18, %19, %20) {adf.kernel, "col, row" = [9 : index, 0 : index], ivs = [0 : index, 2 : index, 0 : index], kernel = 0 : index, kernel_ttmc0 = 4 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%21, %c9, %c0, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%19, %c9, %c0, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%20, %c9, %c1, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%18, %c9, %c1, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %22 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %22) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %23 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg1, %23) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %24 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg10, %24) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %25 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%21, %25) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %26 = call @kernel_ttmc(%22, %23, %24, %25) {adf.kernel, "col, row" = [9 : index, 1 : index], ivs = [1 : index, 2 : index, 0 : index], kernel_ttmc = 5 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%26, %c10, %c1, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%23, %c10, %c1, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%24, %c10, %c1, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%22, %c9, %c0, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%26, %arg11) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %27 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %27) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %28 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg1, %28) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %29 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg12, %29) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %30 = call @kernel_ttmc0(%27, %28, %29) {adf.kernel, "col, row" = [13 : index, 0 : index], ivs = [0 : index, 3 : index, 0 : index], kernel = 0 : index, kernel_ttmc0 = 6 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%30, %c13, %c0, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%28, %c13, %c0, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%29, %c13, %c1, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%27, %c13, %c1, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %31 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %31) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %32 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg1, %32) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %33 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg13, %33) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %34 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%30, %34) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %35 = call @kernel_ttmc(%31, %32, %33, %34) {adf.kernel, "col, row" = [13 : index, 1 : index], ivs = [1 : index, 3 : index, 0 : index], kernel_ttmc = 7 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%35, %c14, %c1, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%32, %c14, %c1, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%33, %c14, %c1, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%31, %c13, %c0, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%35, %arg14) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %36 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %36) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %37 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg1, %37) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %38 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg15, %38) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %39 = call @kernel_ttmc0(%36, %37, %38) {adf.kernel, "col, row" = [17 : index, 0 : index], ivs = [0 : index, 4 : index, 0 : index], kernel = 0 : index, kernel_ttmc0 = 8 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%39, %c17, %c0, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%37, %c17, %c0, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%38, %c17, %c1, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%36, %c17, %c1, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %40 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %40) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %41 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg1, %41) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %42 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg16, %42) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %43 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%39, %43) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %44 = call @kernel_ttmc(%40, %41, %42, %43) {adf.kernel, "col, row" = [17 : index, 1 : index], ivs = [1 : index, 4 : index, 0 : index], kernel_ttmc = 9 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%44, %c18, %c1, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%41, %c18, %c1, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%42, %c18, %c1, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%40, %c17, %c0, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%44, %arg17) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %45 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %45) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %46 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg1, %46) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %47 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg18, %47) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %48 = call @kernel_ttmc0(%45, %46, %47) {adf.kernel, "col, row" = [21 : index, 0 : index], ivs = [0 : index, 5 : index, 0 : index], kernel = 0 : index, kernel_ttmc0 = 10 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%48, %c21, %c0, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%46, %c21, %c0, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%47, %c21, %c1, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%45, %c21, %c1, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %49 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %49) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %50 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg1, %50) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %51 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg19, %51) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %52 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%48, %52) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %53 = call @kernel_ttmc(%49, %50, %51, %52) {adf.kernel, "col, row" = [21 : index, 1 : index], ivs = [1 : index, 5 : index, 0 : index], kernel_ttmc = 11 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%53, %c22, %c1, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%50, %c22, %c1, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%51, %c22, %c1, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%49, %c21, %c0, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%53, %arg20) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %54 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %54) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %55 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg1, %55) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %56 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg21, %56) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %57 = call @kernel_ttmc0(%54, %55, %56) {adf.kernel, "col, row" = [25 : index, 0 : index], ivs = [0 : index, 6 : index, 0 : index], kernel = 0 : index, kernel_ttmc0 = 12 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%57, %c25, %c0, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%55, %c25, %c0, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%56, %c25, %c1, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%54, %c25, %c1, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %58 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %58) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %59 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg1, %59) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %60 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg22, %60) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %61 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%57, %61) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %62 = call @kernel_ttmc(%58, %59, %60, %61) {adf.kernel, "col, row" = [25 : index, 1 : index], ivs = [1 : index, 6 : index, 0 : index], kernel_ttmc = 13 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%62, %c26, %c1, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%59, %c26, %c1, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%60, %c26, %c1, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%58, %c25, %c0, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%62, %arg23) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %63 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %63) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %64 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg1, %64) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %65 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg24, %65) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %66 = call @kernel_ttmc0(%63, %64, %65) {adf.kernel, "col, row" = [29 : index, 0 : index], ivs = [0 : index, 7 : index, 0 : index], kernel = 0 : index, kernel_ttmc0 = 14 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%66, %c29, %c0, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%64, %c29, %c0, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%65, %c29, %c1, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%63, %c29, %c1, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %67 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %67) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %68 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg1, %68) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %69 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg25, %69) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %70 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%66, %70) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %71 = call @kernel_ttmc(%67, %68, %69, %70) {adf.kernel, "col, row" = [29 : index, 1 : index], ivs = [1 : index, 7 : index, 0 : index], kernel_ttmc = 15 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%71, %c30, %c1, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%68, %c30, %c1, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%69, %c30, %c1, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%67, %c29, %c0, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%71, %arg26) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %72 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %72) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %73 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg1, %73) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %74 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg27, %74) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %75 = call @kernel_ttmc0(%72, %73, %74) {adf.kernel, "col, row" = [33 : index, 0 : index], ivs = [0 : index, 8 : index, 0 : index], kernel = 0 : index, kernel_ttmc0 = 16 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%75, %c33, %c0, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%73, %c33, %c0, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%74, %c33, %c1, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%72, %c33, %c1, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %76 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %76) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %77 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg1, %77) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %78 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg28, %78) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %79 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%75, %79) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %80 = call @kernel_ttmc(%76, %77, %78, %79) {adf.kernel, "col, row" = [33 : index, 1 : index], ivs = [1 : index, 8 : index, 0 : index], kernel_ttmc = 17 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%80, %c34, %c1, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%77, %c34, %c1, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%78, %c34, %c1, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%76, %c33, %c0, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%80, %arg29) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %81 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %81) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %82 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg1, %82) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %83 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg30, %83) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %84 = call @kernel_ttmc0(%81, %82, %83) {adf.kernel, "col, row" = [37 : index, 0 : index], ivs = [0 : index, 9 : index, 0 : index], kernel = 0 : index, kernel_ttmc0 = 18 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%84, %c37, %c0, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%82, %c37, %c0, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%83, %c37, %c1, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%81, %c37, %c1, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %85 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %85) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %86 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg1, %86) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %87 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg31, %87) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %88 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%84, %88) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %89 = call @kernel_ttmc(%85, %86, %87, %88) {adf.kernel, "col, row" = [37 : index, 1 : index], ivs = [1 : index, 9 : index, 0 : index], kernel_ttmc = 19 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%89, %c38, %c1, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%86, %c38, %c1, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%87, %c38, %c1, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%85, %c37, %c0, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%89, %arg32) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %90 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %90) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %91 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg1, %91) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %92 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg33, %92) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %93 = call @kernel_ttmc0(%90, %91, %92) {adf.kernel, "col, row" = [41 : index, 0 : index], ivs = [0 : index, 10 : index, 0 : index], kernel = 0 : index, kernel_ttmc0 = 20 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%93, %c41, %c0, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%91, %c41, %c0, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%92, %c41, %c1, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%90, %c41, %c1, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %94 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %94) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %95 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg1, %95) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %96 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg34, %96) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %97 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%93, %97) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %98 = call @kernel_ttmc(%94, %95, %96, %97) {adf.kernel, "col, row" = [41 : index, 1 : index], ivs = [1 : index, 10 : index, 0 : index], kernel_ttmc = 21 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%98, %c42, %c1, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%95, %c42, %c1, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%96, %c42, %c1, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%94, %c41, %c0, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%98, %arg35) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %99 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %99) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %100 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg1, %100) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %101 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg36, %101) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %102 = call @kernel_ttmc0(%99, %100, %101) {adf.kernel, "col, row" = [45 : index, 0 : index], ivs = [0 : index, 11 : index, 0 : index], kernel = 0 : index, kernel_ttmc0 = 22 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%102, %c45, %c0, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%100, %c45, %c0, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%101, %c45, %c1, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%99, %c45, %c1, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %103 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %103) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %104 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg1, %104) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %105 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg37, %105) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %106 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%102, %106) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %107 = call @kernel_ttmc(%103, %104, %105, %106) {adf.kernel, "col, row" = [45 : index, 1 : index], ivs = [1 : index, 11 : index, 0 : index], kernel_ttmc = 23 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%107, %c46, %c1, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%104, %c46, %c1, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%105, %c46, %c1, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%103, %c45, %c0, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%107, %arg38) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %108 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %108) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %109 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg39, %109) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %110 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg2, %110) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %111 = call @kernel_ttmc0(%108, %109, %110) {adf.kernel, "col, row" = [1 : index, 2 : index], ivs = [0 : index, 0 : index, 1 : index], kernel = 0 : index, kernel_ttmc0 = 24 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%111, %c1, %c2, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%109, %c1, %c2, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%110, %c1, %c3, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%108, %c1, %c3, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %112 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %112) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %113 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg39, %113) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %114 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg4, %114) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %115 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%111, %115) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %116 = call @kernel_ttmc(%112, %113, %114, %115) {adf.kernel, "col, row" = [1 : index, 3 : index], ivs = [1 : index, 0 : index, 1 : index], kernel_ttmc = 25 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%116, %c2, %c3, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%113, %c2, %c3, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%114, %c2, %c3, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%112, %c1, %c2, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%116, %arg40) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %117 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %117) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %118 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg39, %118) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %119 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg6, %119) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %120 = call @kernel_ttmc0(%117, %118, %119) {adf.kernel, "col, row" = [5 : index, 2 : index], ivs = [0 : index, 1 : index, 1 : index], kernel = 0 : index, kernel_ttmc0 = 26 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%120, %c5, %c2, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%118, %c5, %c2, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%119, %c5, %c3, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%117, %c5, %c3, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %121 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %121) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %122 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg39, %122) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %123 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg7, %123) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %124 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%120, %124) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %125 = call @kernel_ttmc(%121, %122, %123, %124) {adf.kernel, "col, row" = [5 : index, 3 : index], ivs = [1 : index, 1 : index, 1 : index], kernel_ttmc = 27 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%125, %c6, %c3, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%122, %c6, %c3, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%123, %c6, %c3, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%121, %c5, %c2, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%125, %arg41) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %126 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %126) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %127 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg39, %127) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %128 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg9, %128) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %129 = call @kernel_ttmc0(%126, %127, %128) {adf.kernel, "col, row" = [9 : index, 2 : index], ivs = [0 : index, 2 : index, 1 : index], kernel = 0 : index, kernel_ttmc0 = 28 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%129, %c9, %c2, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%127, %c9, %c2, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%128, %c9, %c3, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%126, %c9, %c3, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %130 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %130) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %131 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg39, %131) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %132 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg10, %132) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %133 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%129, %133) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %134 = call @kernel_ttmc(%130, %131, %132, %133) {adf.kernel, "col, row" = [9 : index, 3 : index], ivs = [1 : index, 2 : index, 1 : index], kernel_ttmc = 29 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%134, %c10, %c3, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%131, %c10, %c3, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%132, %c10, %c3, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%130, %c9, %c2, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%134, %arg42) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %135 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %135) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %136 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg39, %136) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %137 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg12, %137) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %138 = call @kernel_ttmc0(%135, %136, %137) {adf.kernel, "col, row" = [13 : index, 2 : index], ivs = [0 : index, 3 : index, 1 : index], kernel = 0 : index, kernel_ttmc0 = 30 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%138, %c13, %c2, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%136, %c13, %c2, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%137, %c13, %c3, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%135, %c13, %c3, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %139 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %139) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %140 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg39, %140) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %141 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg13, %141) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %142 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%138, %142) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %143 = call @kernel_ttmc(%139, %140, %141, %142) {adf.kernel, "col, row" = [13 : index, 3 : index], ivs = [1 : index, 3 : index, 1 : index], kernel_ttmc = 31 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%143, %c14, %c3, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%140, %c14, %c3, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%141, %c14, %c3, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%139, %c13, %c2, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%143, %arg43) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %144 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %144) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %145 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg39, %145) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %146 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg15, %146) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %147 = call @kernel_ttmc0(%144, %145, %146) {adf.kernel, "col, row" = [17 : index, 2 : index], ivs = [0 : index, 4 : index, 1 : index], kernel = 0 : index, kernel_ttmc0 = 32 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%147, %c17, %c2, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%145, %c17, %c2, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%146, %c17, %c3, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%144, %c17, %c3, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %148 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %148) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %149 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg39, %149) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %150 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg16, %150) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %151 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%147, %151) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %152 = call @kernel_ttmc(%148, %149, %150, %151) {adf.kernel, "col, row" = [17 : index, 3 : index], ivs = [1 : index, 4 : index, 1 : index], kernel_ttmc = 33 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%152, %c18, %c3, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%149, %c18, %c3, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%150, %c18, %c3, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%148, %c17, %c2, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%152, %arg44) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %153 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %153) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %154 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg39, %154) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %155 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg18, %155) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %156 = call @kernel_ttmc0(%153, %154, %155) {adf.kernel, "col, row" = [21 : index, 2 : index], ivs = [0 : index, 5 : index, 1 : index], kernel = 0 : index, kernel_ttmc0 = 34 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%156, %c21, %c2, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%154, %c21, %c2, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%155, %c21, %c3, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%153, %c21, %c3, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %157 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %157) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %158 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg39, %158) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %159 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg19, %159) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %160 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%156, %160) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %161 = call @kernel_ttmc(%157, %158, %159, %160) {adf.kernel, "col, row" = [21 : index, 3 : index], ivs = [1 : index, 5 : index, 1 : index], kernel_ttmc = 35 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%161, %c22, %c3, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%158, %c22, %c3, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%159, %c22, %c3, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%157, %c21, %c2, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%161, %arg45) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %162 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %162) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %163 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg39, %163) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %164 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg21, %164) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %165 = call @kernel_ttmc0(%162, %163, %164) {adf.kernel, "col, row" = [25 : index, 2 : index], ivs = [0 : index, 6 : index, 1 : index], kernel = 0 : index, kernel_ttmc0 = 36 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%165, %c25, %c2, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%163, %c25, %c2, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%164, %c25, %c3, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%162, %c25, %c3, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %166 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %166) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %167 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg39, %167) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %168 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg22, %168) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %169 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%165, %169) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %170 = call @kernel_ttmc(%166, %167, %168, %169) {adf.kernel, "col, row" = [25 : index, 3 : index], ivs = [1 : index, 6 : index, 1 : index], kernel_ttmc = 37 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%170, %c26, %c3, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%167, %c26, %c3, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%168, %c26, %c3, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%166, %c25, %c2, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%170, %arg46) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %171 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %171) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %172 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg39, %172) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %173 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg24, %173) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %174 = call @kernel_ttmc0(%171, %172, %173) {adf.kernel, "col, row" = [29 : index, 2 : index], ivs = [0 : index, 7 : index, 1 : index], kernel = 0 : index, kernel_ttmc0 = 38 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%174, %c29, %c2, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%172, %c29, %c2, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%173, %c29, %c3, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%171, %c29, %c3, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %175 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %175) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %176 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg39, %176) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %177 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg25, %177) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %178 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%174, %178) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %179 = call @kernel_ttmc(%175, %176, %177, %178) {adf.kernel, "col, row" = [29 : index, 3 : index], ivs = [1 : index, 7 : index, 1 : index], kernel_ttmc = 39 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%179, %c30, %c3, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%176, %c30, %c3, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%177, %c30, %c3, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%175, %c29, %c2, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%179, %arg47) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %180 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %180) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %181 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg39, %181) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %182 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg27, %182) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %183 = call @kernel_ttmc0(%180, %181, %182) {adf.kernel, "col, row" = [33 : index, 2 : index], ivs = [0 : index, 8 : index, 1 : index], kernel = 0 : index, kernel_ttmc0 = 40 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%183, %c33, %c2, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%181, %c33, %c2, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%182, %c33, %c3, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%180, %c33, %c3, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %184 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %184) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %185 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg39, %185) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %186 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg28, %186) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %187 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%183, %187) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %188 = call @kernel_ttmc(%184, %185, %186, %187) {adf.kernel, "col, row" = [33 : index, 3 : index], ivs = [1 : index, 8 : index, 1 : index], kernel_ttmc = 41 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%188, %c34, %c3, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%185, %c34, %c3, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%186, %c34, %c3, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%184, %c33, %c2, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%188, %arg48) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %189 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %189) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %190 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg39, %190) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %191 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg30, %191) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %192 = call @kernel_ttmc0(%189, %190, %191) {adf.kernel, "col, row" = [37 : index, 2 : index], ivs = [0 : index, 9 : index, 1 : index], kernel = 0 : index, kernel_ttmc0 = 42 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%192, %c37, %c2, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%190, %c37, %c2, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%191, %c37, %c3, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%189, %c37, %c3, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %193 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %193) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %194 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg39, %194) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %195 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg31, %195) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %196 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%192, %196) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %197 = call @kernel_ttmc(%193, %194, %195, %196) {adf.kernel, "col, row" = [37 : index, 3 : index], ivs = [1 : index, 9 : index, 1 : index], kernel_ttmc = 43 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%197, %c38, %c3, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%194, %c38, %c3, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%195, %c38, %c3, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%193, %c37, %c2, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%197, %arg49) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %198 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %198) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %199 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg39, %199) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %200 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg33, %200) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %201 = call @kernel_ttmc0(%198, %199, %200) {adf.kernel, "col, row" = [41 : index, 2 : index], ivs = [0 : index, 10 : index, 1 : index], kernel = 0 : index, kernel_ttmc0 = 44 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%201, %c41, %c2, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%199, %c41, %c2, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%200, %c41, %c3, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%198, %c41, %c3, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %202 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %202) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %203 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg39, %203) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %204 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg34, %204) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %205 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%201, %205) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %206 = call @kernel_ttmc(%202, %203, %204, %205) {adf.kernel, "col, row" = [41 : index, 3 : index], ivs = [1 : index, 10 : index, 1 : index], kernel_ttmc = 45 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%206, %c42, %c3, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%203, %c42, %c3, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%204, %c42, %c3, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%202, %c41, %c2, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%206, %arg50) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %207 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %207) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %208 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg39, %208) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %209 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg36, %209) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %210 = call @kernel_ttmc0(%207, %208, %209) {adf.kernel, "col, row" = [45 : index, 2 : index], ivs = [0 : index, 11 : index, 1 : index], kernel = 0 : index, kernel_ttmc0 = 46 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%210, %c45, %c2, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%208, %c45, %c2, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%209, %c45, %c3, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%207, %c45, %c3, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %211 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %211) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %212 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg39, %212) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %213 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg37, %213) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %214 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%210, %214) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %215 = call @kernel_ttmc(%211, %212, %213, %214) {adf.kernel, "col, row" = [45 : index, 3 : index], ivs = [1 : index, 11 : index, 1 : index], kernel_ttmc = 47 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%215, %c46, %c3, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%212, %c46, %c3, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%213, %c46, %c3, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%211, %c45, %c2, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%215, %arg51) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %216 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %216) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %217 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg52, %217) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %218 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg2, %218) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %219 = call @kernel_ttmc0(%216, %217, %218) {adf.kernel, "col, row" = [1 : index, 4 : index], ivs = [0 : index, 0 : index, 2 : index], kernel = 0 : index, kernel_ttmc0 = 48 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%219, %c1, %c4, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%217, %c1, %c4, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%218, %c1, %c5, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%216, %c1, %c5, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %220 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %220) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %221 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg52, %221) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %222 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg4, %222) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %223 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%219, %223) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %224 = call @kernel_ttmc(%220, %221, %222, %223) {adf.kernel, "col, row" = [1 : index, 5 : index], ivs = [1 : index, 0 : index, 2 : index], kernel_ttmc = 49 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%224, %c2, %c5, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%221, %c2, %c5, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%222, %c2, %c5, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%220, %c1, %c4, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%224, %arg53) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %225 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %225) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %226 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg52, %226) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %227 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg6, %227) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %228 = call @kernel_ttmc0(%225, %226, %227) {adf.kernel, "col, row" = [5 : index, 4 : index], ivs = [0 : index, 1 : index, 2 : index], kernel = 0 : index, kernel_ttmc0 = 50 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%228, %c5, %c4, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%226, %c5, %c4, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%227, %c5, %c5, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%225, %c5, %c5, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %229 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %229) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %230 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg52, %230) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %231 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg7, %231) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %232 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%228, %232) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %233 = call @kernel_ttmc(%229, %230, %231, %232) {adf.kernel, "col, row" = [5 : index, 5 : index], ivs = [1 : index, 1 : index, 2 : index], kernel_ttmc = 51 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%233, %c6, %c5, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%230, %c6, %c5, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%231, %c6, %c5, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%229, %c5, %c4, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%233, %arg54) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %234 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %234) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %235 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg52, %235) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %236 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg9, %236) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %237 = call @kernel_ttmc0(%234, %235, %236) {adf.kernel, "col, row" = [9 : index, 4 : index], ivs = [0 : index, 2 : index, 2 : index], kernel = 0 : index, kernel_ttmc0 = 52 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%237, %c9, %c4, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%235, %c9, %c4, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%236, %c9, %c5, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%234, %c9, %c5, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %238 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %238) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %239 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg52, %239) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %240 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg10, %240) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %241 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%237, %241) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %242 = call @kernel_ttmc(%238, %239, %240, %241) {adf.kernel, "col, row" = [9 : index, 5 : index], ivs = [1 : index, 2 : index, 2 : index], kernel_ttmc = 53 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%242, %c10, %c5, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%239, %c10, %c5, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%240, %c10, %c5, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%238, %c9, %c4, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%242, %arg55) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %243 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %243) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %244 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg52, %244) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %245 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg12, %245) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %246 = call @kernel_ttmc0(%243, %244, %245) {adf.kernel, "col, row" = [13 : index, 4 : index], ivs = [0 : index, 3 : index, 2 : index], kernel = 0 : index, kernel_ttmc0 = 54 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%246, %c13, %c4, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%244, %c13, %c4, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%245, %c13, %c5, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%243, %c13, %c5, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %247 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %247) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %248 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg52, %248) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %249 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg13, %249) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %250 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%246, %250) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %251 = call @kernel_ttmc(%247, %248, %249, %250) {adf.kernel, "col, row" = [13 : index, 5 : index], ivs = [1 : index, 3 : index, 2 : index], kernel_ttmc = 55 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%251, %c14, %c5, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%248, %c14, %c5, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%249, %c14, %c5, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%247, %c13, %c4, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%251, %arg56) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %252 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %252) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %253 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg52, %253) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %254 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg15, %254) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %255 = call @kernel_ttmc0(%252, %253, %254) {adf.kernel, "col, row" = [17 : index, 4 : index], ivs = [0 : index, 4 : index, 2 : index], kernel = 0 : index, kernel_ttmc0 = 56 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%255, %c17, %c4, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%253, %c17, %c4, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%254, %c17, %c5, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%252, %c17, %c5, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %256 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %256) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %257 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg52, %257) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %258 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg16, %258) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %259 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%255, %259) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %260 = call @kernel_ttmc(%256, %257, %258, %259) {adf.kernel, "col, row" = [17 : index, 5 : index], ivs = [1 : index, 4 : index, 2 : index], kernel_ttmc = 57 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%260, %c18, %c5, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%257, %c18, %c5, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%258, %c18, %c5, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%256, %c17, %c4, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%260, %arg57) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %261 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %261) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %262 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg52, %262) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %263 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg18, %263) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %264 = call @kernel_ttmc0(%261, %262, %263) {adf.kernel, "col, row" = [21 : index, 4 : index], ivs = [0 : index, 5 : index, 2 : index], kernel = 0 : index, kernel_ttmc0 = 58 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%264, %c21, %c4, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%262, %c21, %c4, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%263, %c21, %c5, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%261, %c21, %c5, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %265 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %265) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %266 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg52, %266) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %267 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg19, %267) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %268 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%264, %268) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %269 = call @kernel_ttmc(%265, %266, %267, %268) {adf.kernel, "col, row" = [21 : index, 5 : index], ivs = [1 : index, 5 : index, 2 : index], kernel_ttmc = 59 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%269, %c22, %c5, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%266, %c22, %c5, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%267, %c22, %c5, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%265, %c21, %c4, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%269, %arg58) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %270 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %270) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %271 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg52, %271) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %272 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg21, %272) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %273 = call @kernel_ttmc0(%270, %271, %272) {adf.kernel, "col, row" = [25 : index, 4 : index], ivs = [0 : index, 6 : index, 2 : index], kernel = 0 : index, kernel_ttmc0 = 60 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%273, %c25, %c4, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%271, %c25, %c4, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%272, %c25, %c5, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%270, %c25, %c5, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %274 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %274) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %275 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg52, %275) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %276 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg22, %276) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %277 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%273, %277) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %278 = call @kernel_ttmc(%274, %275, %276, %277) {adf.kernel, "col, row" = [25 : index, 5 : index], ivs = [1 : index, 6 : index, 2 : index], kernel_ttmc = 61 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%278, %c26, %c5, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%275, %c26, %c5, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%276, %c26, %c5, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%274, %c25, %c4, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%278, %arg59) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %279 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %279) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %280 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg52, %280) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %281 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg24, %281) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %282 = call @kernel_ttmc0(%279, %280, %281) {adf.kernel, "col, row" = [29 : index, 4 : index], ivs = [0 : index, 7 : index, 2 : index], kernel = 0 : index, kernel_ttmc0 = 62 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%282, %c29, %c4, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%280, %c29, %c4, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%281, %c29, %c5, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%279, %c29, %c5, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %283 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %283) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %284 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg52, %284) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %285 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg25, %285) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %286 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%282, %286) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %287 = call @kernel_ttmc(%283, %284, %285, %286) {adf.kernel, "col, row" = [29 : index, 5 : index], ivs = [1 : index, 7 : index, 2 : index], kernel_ttmc = 63 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%287, %c30, %c5, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%284, %c30, %c5, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%285, %c30, %c5, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%283, %c29, %c4, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%287, %arg60) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %288 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %288) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %289 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg52, %289) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %290 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg27, %290) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %291 = call @kernel_ttmc0(%288, %289, %290) {adf.kernel, "col, row" = [33 : index, 4 : index], ivs = [0 : index, 8 : index, 2 : index], kernel = 0 : index, kernel_ttmc0 = 64 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%291, %c33, %c4, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%289, %c33, %c4, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%290, %c33, %c5, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%288, %c33, %c5, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %292 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %292) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %293 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg52, %293) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %294 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg28, %294) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %295 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%291, %295) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %296 = call @kernel_ttmc(%292, %293, %294, %295) {adf.kernel, "col, row" = [33 : index, 5 : index], ivs = [1 : index, 8 : index, 2 : index], kernel_ttmc = 65 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%296, %c34, %c5, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%293, %c34, %c5, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%294, %c34, %c5, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%292, %c33, %c4, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%296, %arg61) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %297 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %297) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %298 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg52, %298) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %299 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg30, %299) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %300 = call @kernel_ttmc0(%297, %298, %299) {adf.kernel, "col, row" = [37 : index, 4 : index], ivs = [0 : index, 9 : index, 2 : index], kernel = 0 : index, kernel_ttmc0 = 66 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%300, %c37, %c4, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%298, %c37, %c4, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%299, %c37, %c5, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%297, %c37, %c5, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %301 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %301) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %302 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg52, %302) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %303 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg31, %303) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %304 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%300, %304) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %305 = call @kernel_ttmc(%301, %302, %303, %304) {adf.kernel, "col, row" = [37 : index, 5 : index], ivs = [1 : index, 9 : index, 2 : index], kernel_ttmc = 67 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%305, %c38, %c5, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%302, %c38, %c5, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%303, %c38, %c5, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%301, %c37, %c4, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%305, %arg62) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %306 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %306) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %307 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg52, %307) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %308 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg33, %308) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %309 = call @kernel_ttmc0(%306, %307, %308) {adf.kernel, "col, row" = [41 : index, 4 : index], ivs = [0 : index, 10 : index, 2 : index], kernel = 0 : index, kernel_ttmc0 = 68 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%309, %c41, %c4, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%307, %c41, %c4, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%308, %c41, %c5, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%306, %c41, %c5, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %310 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %310) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %311 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg52, %311) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %312 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg34, %312) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %313 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%309, %313) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %314 = call @kernel_ttmc(%310, %311, %312, %313) {adf.kernel, "col, row" = [41 : index, 5 : index], ivs = [1 : index, 10 : index, 2 : index], kernel_ttmc = 69 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%314, %c42, %c5, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%311, %c42, %c5, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%312, %c42, %c5, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%310, %c41, %c4, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%314, %arg63) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %315 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %315) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %316 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg52, %316) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %317 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg36, %317) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %318 = call @kernel_ttmc0(%315, %316, %317) {adf.kernel, "col, row" = [45 : index, 4 : index], ivs = [0 : index, 11 : index, 2 : index], kernel = 0 : index, kernel_ttmc0 = 70 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%318, %c45, %c4, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%316, %c45, %c4, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%317, %c45, %c5, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%315, %c45, %c5, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %319 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %319) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %320 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg52, %320) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %321 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg37, %321) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %322 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%318, %322) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %323 = call @kernel_ttmc(%319, %320, %321, %322) {adf.kernel, "col, row" = [45 : index, 5 : index], ivs = [1 : index, 11 : index, 2 : index], kernel_ttmc = 71 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%323, %c46, %c5, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%320, %c46, %c5, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%321, %c46, %c5, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%319, %c45, %c4, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%323, %arg64) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %324 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %324) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %325 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg65, %325) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %326 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg2, %326) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %327 = call @kernel_ttmc0(%324, %325, %326) {adf.kernel, "col, row" = [1 : index, 6 : index], ivs = [0 : index, 0 : index, 3 : index], kernel = 0 : index, kernel_ttmc0 = 72 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%327, %c1, %c6, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%325, %c1, %c6, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%326, %c1, %c7, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%324, %c1, %c7, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %328 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %328) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %329 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg65, %329) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %330 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg4, %330) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %331 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%327, %331) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %332 = call @kernel_ttmc(%328, %329, %330, %331) {adf.kernel, "col, row" = [1 : index, 7 : index], ivs = [1 : index, 0 : index, 3 : index], kernel_ttmc = 73 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%332, %c2, %c7, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%329, %c2, %c7, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%330, %c2, %c7, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%328, %c1, %c6, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%332, %arg66) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %333 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %333) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %334 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg65, %334) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %335 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg6, %335) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %336 = call @kernel_ttmc0(%333, %334, %335) {adf.kernel, "col, row" = [5 : index, 6 : index], ivs = [0 : index, 1 : index, 3 : index], kernel = 0 : index, kernel_ttmc0 = 74 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%336, %c5, %c6, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%334, %c5, %c6, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%335, %c5, %c7, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%333, %c5, %c7, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %337 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %337) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %338 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg65, %338) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %339 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg7, %339) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %340 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%336, %340) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %341 = call @kernel_ttmc(%337, %338, %339, %340) {adf.kernel, "col, row" = [5 : index, 7 : index], ivs = [1 : index, 1 : index, 3 : index], kernel_ttmc = 75 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%341, %c6, %c7, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%338, %c6, %c7, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%339, %c6, %c7, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%337, %c5, %c6, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%341, %arg67) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %342 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %342) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %343 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg65, %343) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %344 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg9, %344) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %345 = call @kernel_ttmc0(%342, %343, %344) {adf.kernel, "col, row" = [9 : index, 6 : index], ivs = [0 : index, 2 : index, 3 : index], kernel = 0 : index, kernel_ttmc0 = 76 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%345, %c9, %c6, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%343, %c9, %c6, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%344, %c9, %c7, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%342, %c9, %c7, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %346 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %346) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %347 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg65, %347) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %348 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg10, %348) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %349 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%345, %349) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %350 = call @kernel_ttmc(%346, %347, %348, %349) {adf.kernel, "col, row" = [9 : index, 7 : index], ivs = [1 : index, 2 : index, 3 : index], kernel_ttmc = 77 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%350, %c10, %c7, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%347, %c10, %c7, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%348, %c10, %c7, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%346, %c9, %c6, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%350, %arg68) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %351 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %351) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %352 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg65, %352) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %353 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg12, %353) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %354 = call @kernel_ttmc0(%351, %352, %353) {adf.kernel, "col, row" = [13 : index, 6 : index], ivs = [0 : index, 3 : index, 3 : index], kernel = 0 : index, kernel_ttmc0 = 78 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%354, %c13, %c6, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%352, %c13, %c6, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%353, %c13, %c7, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%351, %c13, %c7, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %355 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %355) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %356 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg65, %356) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %357 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg13, %357) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %358 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%354, %358) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %359 = call @kernel_ttmc(%355, %356, %357, %358) {adf.kernel, "col, row" = [13 : index, 7 : index], ivs = [1 : index, 3 : index, 3 : index], kernel_ttmc = 79 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%359, %c14, %c7, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%356, %c14, %c7, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%357, %c14, %c7, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%355, %c13, %c6, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%359, %arg69) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %360 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %360) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %361 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg65, %361) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %362 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg15, %362) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %363 = call @kernel_ttmc0(%360, %361, %362) {adf.kernel, "col, row" = [17 : index, 6 : index], ivs = [0 : index, 4 : index, 3 : index], kernel = 0 : index, kernel_ttmc0 = 80 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%363, %c17, %c6, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%361, %c17, %c6, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%362, %c17, %c7, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%360, %c17, %c7, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %364 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %364) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %365 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg65, %365) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %366 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg16, %366) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %367 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%363, %367) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %368 = call @kernel_ttmc(%364, %365, %366, %367) {adf.kernel, "col, row" = [17 : index, 7 : index], ivs = [1 : index, 4 : index, 3 : index], kernel_ttmc = 81 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%368, %c18, %c7, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%365, %c18, %c7, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%366, %c18, %c7, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%364, %c17, %c6, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%368, %arg70) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %369 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %369) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %370 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg65, %370) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %371 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg18, %371) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %372 = call @kernel_ttmc0(%369, %370, %371) {adf.kernel, "col, row" = [21 : index, 6 : index], ivs = [0 : index, 5 : index, 3 : index], kernel = 0 : index, kernel_ttmc0 = 82 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%372, %c21, %c6, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%370, %c21, %c6, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%371, %c21, %c7, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%369, %c21, %c7, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %373 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %373) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %374 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg65, %374) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %375 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg19, %375) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %376 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%372, %376) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %377 = call @kernel_ttmc(%373, %374, %375, %376) {adf.kernel, "col, row" = [21 : index, 7 : index], ivs = [1 : index, 5 : index, 3 : index], kernel_ttmc = 83 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%377, %c22, %c7, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%374, %c22, %c7, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%375, %c22, %c7, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%373, %c21, %c6, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%377, %arg71) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %378 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %378) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %379 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg65, %379) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %380 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg21, %380) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %381 = call @kernel_ttmc0(%378, %379, %380) {adf.kernel, "col, row" = [25 : index, 6 : index], ivs = [0 : index, 6 : index, 3 : index], kernel = 0 : index, kernel_ttmc0 = 84 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%381, %c25, %c6, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%379, %c25, %c6, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%380, %c25, %c7, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%378, %c25, %c7, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %382 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %382) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %383 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg65, %383) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %384 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg22, %384) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %385 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%381, %385) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %386 = call @kernel_ttmc(%382, %383, %384, %385) {adf.kernel, "col, row" = [25 : index, 7 : index], ivs = [1 : index, 6 : index, 3 : index], kernel_ttmc = 85 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%386, %c26, %c7, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%383, %c26, %c7, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%384, %c26, %c7, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%382, %c25, %c6, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%386, %arg72) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %387 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %387) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %388 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg65, %388) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %389 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg24, %389) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %390 = call @kernel_ttmc0(%387, %388, %389) {adf.kernel, "col, row" = [29 : index, 6 : index], ivs = [0 : index, 7 : index, 3 : index], kernel = 0 : index, kernel_ttmc0 = 86 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%390, %c29, %c6, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%388, %c29, %c6, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%389, %c29, %c7, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%387, %c29, %c7, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %391 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %391) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %392 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg65, %392) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %393 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg25, %393) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %394 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%390, %394) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %395 = call @kernel_ttmc(%391, %392, %393, %394) {adf.kernel, "col, row" = [29 : index, 7 : index], ivs = [1 : index, 7 : index, 3 : index], kernel_ttmc = 87 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%395, %c30, %c7, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%392, %c30, %c7, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%393, %c30, %c7, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%391, %c29, %c6, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%395, %arg73) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %396 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %396) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %397 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg65, %397) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %398 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg27, %398) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %399 = call @kernel_ttmc0(%396, %397, %398) {adf.kernel, "col, row" = [33 : index, 6 : index], ivs = [0 : index, 8 : index, 3 : index], kernel = 0 : index, kernel_ttmc0 = 88 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%399, %c33, %c6, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%397, %c33, %c6, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%398, %c33, %c7, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%396, %c33, %c7, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %400 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %400) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %401 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg65, %401) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %402 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg28, %402) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %403 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%399, %403) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %404 = call @kernel_ttmc(%400, %401, %402, %403) {adf.kernel, "col, row" = [33 : index, 7 : index], ivs = [1 : index, 8 : index, 3 : index], kernel_ttmc = 89 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%404, %c34, %c7, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%401, %c34, %c7, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%402, %c34, %c7, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%400, %c33, %c6, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%404, %arg74) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %405 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %405) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %406 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg65, %406) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %407 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg30, %407) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %408 = call @kernel_ttmc0(%405, %406, %407) {adf.kernel, "col, row" = [37 : index, 6 : index], ivs = [0 : index, 9 : index, 3 : index], kernel = 0 : index, kernel_ttmc0 = 90 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%408, %c37, %c6, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%406, %c37, %c6, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%407, %c37, %c7, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%405, %c37, %c7, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %409 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %409) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %410 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg65, %410) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %411 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg31, %411) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %412 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%408, %412) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %413 = call @kernel_ttmc(%409, %410, %411, %412) {adf.kernel, "col, row" = [37 : index, 7 : index], ivs = [1 : index, 9 : index, 3 : index], kernel_ttmc = 91 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%413, %c38, %c7, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%410, %c38, %c7, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%411, %c38, %c7, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%409, %c37, %c6, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%413, %arg75) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %414 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %414) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %415 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg65, %415) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %416 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg33, %416) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %417 = call @kernel_ttmc0(%414, %415, %416) {adf.kernel, "col, row" = [41 : index, 6 : index], ivs = [0 : index, 10 : index, 3 : index], kernel = 0 : index, kernel_ttmc0 = 92 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%417, %c41, %c6, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%415, %c41, %c6, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%416, %c41, %c7, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%414, %c41, %c7, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %418 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %418) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %419 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg65, %419) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %420 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg34, %420) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %421 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%417, %421) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %422 = call @kernel_ttmc(%418, %419, %420, %421) {adf.kernel, "col, row" = [41 : index, 7 : index], ivs = [1 : index, 10 : index, 3 : index], kernel_ttmc = 93 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%422, %c42, %c7, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%419, %c42, %c7, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%420, %c42, %c7, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%418, %c41, %c6, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%422, %arg76) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %423 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %423) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %424 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg65, %424) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %425 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg36, %425) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %426 = call @kernel_ttmc0(%423, %424, %425) {adf.kernel, "col, row" = [45 : index, 6 : index], ivs = [0 : index, 11 : index, 3 : index], kernel = 0 : index, kernel_ttmc0 = 94 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%426, %c45, %c6, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%424, %c45, %c6, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%425, %c45, %c7, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%423, %c45, %c7, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %427 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %427) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %428 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg65, %428) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %429 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg37, %429) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %430 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%426, %430) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %431 = call @kernel_ttmc(%427, %428, %429, %430) {adf.kernel, "col, row" = [45 : index, 7 : index], ivs = [1 : index, 11 : index, 3 : index], kernel_ttmc = 95 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%431, %c46, %c7, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%428, %c46, %c7, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%429, %c46, %c7, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%427, %c45, %c6, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%431, %arg77) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %432 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %432) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %433 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg78, %433) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %434 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg2, %434) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %435 = call @kernel_ttmc0(%432, %433, %434) {adf.kernel, "col, row" = [3 : index, 0 : index], ivs = [0 : index, 0 : index, 4 : index], kernel = 0 : index, kernel_ttmc0 = 96 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%435, %c3, %c0, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%433, %c3, %c0, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%434, %c3, %c1, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%432, %c3, %c1, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %436 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %436) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %437 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg78, %437) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %438 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg4, %438) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %439 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%435, %439) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %440 = call @kernel_ttmc(%436, %437, %438, %439) {adf.kernel, "col, row" = [3 : index, 1 : index], ivs = [1 : index, 0 : index, 4 : index], kernel_ttmc = 97 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%440, %c4, %c1, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%437, %c4, %c1, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%438, %c4, %c1, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%436, %c3, %c0, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%440, %arg79) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %441 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %441) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %442 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg78, %442) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %443 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg6, %443) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %444 = call @kernel_ttmc0(%441, %442, %443) {adf.kernel, "col, row" = [7 : index, 0 : index], ivs = [0 : index, 1 : index, 4 : index], kernel = 0 : index, kernel_ttmc0 = 98 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%444, %c7, %c0, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%442, %c7, %c0, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%443, %c7, %c1, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%441, %c7, %c1, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %445 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %445) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %446 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg78, %446) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %447 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg7, %447) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %448 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%444, %448) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %449 = call @kernel_ttmc(%445, %446, %447, %448) {adf.kernel, "col, row" = [7 : index, 1 : index], ivs = [1 : index, 1 : index, 4 : index], kernel_ttmc = 99 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%449, %c8, %c1, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%446, %c8, %c1, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%447, %c8, %c1, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%445, %c7, %c0, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%449, %arg80) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %450 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %450) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %451 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg78, %451) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %452 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg9, %452) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %453 = call @kernel_ttmc0(%450, %451, %452) {adf.kernel, "col, row" = [11 : index, 0 : index], ivs = [0 : index, 2 : index, 4 : index], kernel = 0 : index, kernel_ttmc0 = 100 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%453, %c11, %c0, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%451, %c11, %c0, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%452, %c11, %c1, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%450, %c11, %c1, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %454 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %454) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %455 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg78, %455) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %456 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg10, %456) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %457 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%453, %457) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %458 = call @kernel_ttmc(%454, %455, %456, %457) {adf.kernel, "col, row" = [11 : index, 1 : index], ivs = [1 : index, 2 : index, 4 : index], kernel_ttmc = 101 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%458, %c12, %c1, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%455, %c12, %c1, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%456, %c12, %c1, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%454, %c11, %c0, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%458, %arg81) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %459 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %459) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %460 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg78, %460) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %461 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg12, %461) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %462 = call @kernel_ttmc0(%459, %460, %461) {adf.kernel, "col, row" = [15 : index, 0 : index], ivs = [0 : index, 3 : index, 4 : index], kernel = 0 : index, kernel_ttmc0 = 102 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%462, %c15, %c0, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%460, %c15, %c0, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%461, %c15, %c1, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%459, %c15, %c1, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %463 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %463) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %464 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg78, %464) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %465 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg13, %465) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %466 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%462, %466) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %467 = call @kernel_ttmc(%463, %464, %465, %466) {adf.kernel, "col, row" = [15 : index, 1 : index], ivs = [1 : index, 3 : index, 4 : index], kernel_ttmc = 103 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%467, %c16, %c1, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%464, %c16, %c1, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%465, %c16, %c1, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%463, %c15, %c0, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%467, %arg82) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %468 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %468) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %469 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg78, %469) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %470 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg15, %470) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %471 = call @kernel_ttmc0(%468, %469, %470) {adf.kernel, "col, row" = [19 : index, 0 : index], ivs = [0 : index, 4 : index, 4 : index], kernel = 0 : index, kernel_ttmc0 = 104 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%471, %c19, %c0, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%469, %c19, %c0, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%470, %c19, %c1, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%468, %c19, %c1, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %472 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %472) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %473 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg78, %473) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %474 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg16, %474) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %475 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%471, %475) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %476 = call @kernel_ttmc(%472, %473, %474, %475) {adf.kernel, "col, row" = [19 : index, 1 : index], ivs = [1 : index, 4 : index, 4 : index], kernel_ttmc = 105 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%476, %c20, %c1, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%473, %c20, %c1, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%474, %c20, %c1, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%472, %c19, %c0, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%476, %arg83) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %477 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %477) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %478 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg78, %478) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %479 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg18, %479) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %480 = call @kernel_ttmc0(%477, %478, %479) {adf.kernel, "col, row" = [23 : index, 0 : index], ivs = [0 : index, 5 : index, 4 : index], kernel = 0 : index, kernel_ttmc0 = 106 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%480, %c23, %c0, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%478, %c23, %c0, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%479, %c23, %c1, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%477, %c23, %c1, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %481 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %481) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %482 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg78, %482) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %483 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg19, %483) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %484 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%480, %484) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %485 = call @kernel_ttmc(%481, %482, %483, %484) {adf.kernel, "col, row" = [23 : index, 1 : index], ivs = [1 : index, 5 : index, 4 : index], kernel_ttmc = 107 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%485, %c24, %c1, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%482, %c24, %c1, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%483, %c24, %c1, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%481, %c23, %c0, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%485, %arg84) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %486 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %486) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %487 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg78, %487) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %488 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg21, %488) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %489 = call @kernel_ttmc0(%486, %487, %488) {adf.kernel, "col, row" = [27 : index, 0 : index], ivs = [0 : index, 6 : index, 4 : index], kernel = 0 : index, kernel_ttmc0 = 108 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%489, %c27, %c0, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%487, %c27, %c0, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%488, %c27, %c1, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%486, %c27, %c1, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %490 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %490) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %491 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg78, %491) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %492 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg22, %492) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %493 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%489, %493) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %494 = call @kernel_ttmc(%490, %491, %492, %493) {adf.kernel, "col, row" = [27 : index, 1 : index], ivs = [1 : index, 6 : index, 4 : index], kernel_ttmc = 109 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%494, %c28, %c1, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%491, %c28, %c1, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%492, %c28, %c1, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%490, %c27, %c0, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%494, %arg85) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %495 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %495) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %496 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg78, %496) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %497 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg24, %497) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %498 = call @kernel_ttmc0(%495, %496, %497) {adf.kernel, "col, row" = [31 : index, 0 : index], ivs = [0 : index, 7 : index, 4 : index], kernel = 0 : index, kernel_ttmc0 = 110 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%498, %c31, %c0, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%496, %c31, %c0, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%497, %c31, %c1, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%495, %c31, %c1, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %499 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %499) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %500 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg78, %500) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %501 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg25, %501) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %502 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%498, %502) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %503 = call @kernel_ttmc(%499, %500, %501, %502) {adf.kernel, "col, row" = [31 : index, 1 : index], ivs = [1 : index, 7 : index, 4 : index], kernel_ttmc = 111 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%503, %c32, %c1, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%500, %c32, %c1, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%501, %c32, %c1, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%499, %c31, %c0, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%503, %arg86) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %504 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %504) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %505 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg78, %505) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %506 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg27, %506) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %507 = call @kernel_ttmc0(%504, %505, %506) {adf.kernel, "col, row" = [35 : index, 0 : index], ivs = [0 : index, 8 : index, 4 : index], kernel = 0 : index, kernel_ttmc0 = 112 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%507, %c35, %c0, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%505, %c35, %c0, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%506, %c35, %c1, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%504, %c35, %c1, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %508 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %508) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %509 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg78, %509) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %510 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg28, %510) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %511 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%507, %511) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %512 = call @kernel_ttmc(%508, %509, %510, %511) {adf.kernel, "col, row" = [35 : index, 1 : index], ivs = [1 : index, 8 : index, 4 : index], kernel_ttmc = 113 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%512, %c36, %c1, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%509, %c36, %c1, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%510, %c36, %c1, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%508, %c35, %c0, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%512, %arg87) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %513 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %513) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %514 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg78, %514) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %515 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg30, %515) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %516 = call @kernel_ttmc0(%513, %514, %515) {adf.kernel, "col, row" = [39 : index, 0 : index], ivs = [0 : index, 9 : index, 4 : index], kernel = 0 : index, kernel_ttmc0 = 114 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%516, %c39, %c0, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%514, %c39, %c0, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%515, %c39, %c1, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%513, %c39, %c1, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %517 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %517) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %518 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg78, %518) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %519 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg31, %519) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %520 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%516, %520) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %521 = call @kernel_ttmc(%517, %518, %519, %520) {adf.kernel, "col, row" = [39 : index, 1 : index], ivs = [1 : index, 9 : index, 4 : index], kernel_ttmc = 115 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%521, %c40, %c1, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%518, %c40, %c1, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%519, %c40, %c1, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%517, %c39, %c0, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%521, %arg88) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %522 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %522) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %523 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg78, %523) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %524 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg33, %524) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %525 = call @kernel_ttmc0(%522, %523, %524) {adf.kernel, "col, row" = [43 : index, 0 : index], ivs = [0 : index, 10 : index, 4 : index], kernel = 0 : index, kernel_ttmc0 = 116 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%525, %c43, %c0, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%523, %c43, %c0, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%524, %c43, %c1, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%522, %c43, %c1, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %526 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %526) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %527 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg78, %527) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %528 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg34, %528) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %529 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%525, %529) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %530 = call @kernel_ttmc(%526, %527, %528, %529) {adf.kernel, "col, row" = [43 : index, 1 : index], ivs = [1 : index, 10 : index, 4 : index], kernel_ttmc = 117 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%530, %c44, %c1, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%527, %c44, %c1, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%528, %c44, %c1, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%526, %c43, %c0, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%530, %arg89) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %531 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %531) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %532 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg78, %532) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %533 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg36, %533) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %534 = call @kernel_ttmc0(%531, %532, %533) {adf.kernel, "col, row" = [47 : index, 0 : index], ivs = [0 : index, 11 : index, 4 : index], kernel = 0 : index, kernel_ttmc0 = 118 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%534, %c47, %c0, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%532, %c47, %c0, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%533, %c47, %c1, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%531, %c47, %c1, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %535 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %535) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %536 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg78, %536) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %537 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg37, %537) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %538 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%534, %538) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %539 = call @kernel_ttmc(%535, %536, %537, %538) {adf.kernel, "col, row" = [47 : index, 1 : index], ivs = [1 : index, 11 : index, 4 : index], kernel_ttmc = 119 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%539, %c48, %c1, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%536, %c48, %c1, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%537, %c48, %c1, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%535, %c47, %c0, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%539, %arg90) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %540 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %540) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %541 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg91, %541) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %542 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg2, %542) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %543 = call @kernel_ttmc0(%540, %541, %542) {adf.kernel, "col, row" = [3 : index, 2 : index], ivs = [0 : index, 0 : index, 5 : index], kernel = 0 : index, kernel_ttmc0 = 120 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%543, %c3, %c2, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%541, %c3, %c2, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%542, %c3, %c3, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%540, %c3, %c3, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %544 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %544) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %545 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg91, %545) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %546 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg4, %546) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %547 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%543, %547) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %548 = call @kernel_ttmc(%544, %545, %546, %547) {adf.kernel, "col, row" = [3 : index, 3 : index], ivs = [1 : index, 0 : index, 5 : index], kernel_ttmc = 121 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%548, %c4, %c3, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%545, %c4, %c3, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%546, %c4, %c3, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%544, %c3, %c2, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%548, %arg92) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %549 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %549) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %550 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg91, %550) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %551 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg6, %551) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %552 = call @kernel_ttmc0(%549, %550, %551) {adf.kernel, "col, row" = [7 : index, 2 : index], ivs = [0 : index, 1 : index, 5 : index], kernel = 0 : index, kernel_ttmc0 = 122 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%552, %c7, %c2, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%550, %c7, %c2, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%551, %c7, %c3, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%549, %c7, %c3, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %553 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %553) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %554 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg91, %554) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %555 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg7, %555) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %556 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%552, %556) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %557 = call @kernel_ttmc(%553, %554, %555, %556) {adf.kernel, "col, row" = [7 : index, 3 : index], ivs = [1 : index, 1 : index, 5 : index], kernel_ttmc = 123 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%557, %c8, %c3, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%554, %c8, %c3, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%555, %c8, %c3, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%553, %c7, %c2, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%557, %arg93) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %558 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %558) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %559 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg91, %559) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %560 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg9, %560) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %561 = call @kernel_ttmc0(%558, %559, %560) {adf.kernel, "col, row" = [11 : index, 2 : index], ivs = [0 : index, 2 : index, 5 : index], kernel = 0 : index, kernel_ttmc0 = 124 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%561, %c11, %c2, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%559, %c11, %c2, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%560, %c11, %c3, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%558, %c11, %c3, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %562 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %562) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %563 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg91, %563) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %564 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg10, %564) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %565 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%561, %565) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %566 = call @kernel_ttmc(%562, %563, %564, %565) {adf.kernel, "col, row" = [11 : index, 3 : index], ivs = [1 : index, 2 : index, 5 : index], kernel_ttmc = 125 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%566, %c12, %c3, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%563, %c12, %c3, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%564, %c12, %c3, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%562, %c11, %c2, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%566, %arg94) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %567 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %567) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %568 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg91, %568) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %569 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg12, %569) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %570 = call @kernel_ttmc0(%567, %568, %569) {adf.kernel, "col, row" = [15 : index, 2 : index], ivs = [0 : index, 3 : index, 5 : index], kernel = 0 : index, kernel_ttmc0 = 126 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%570, %c15, %c2, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%568, %c15, %c2, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%569, %c15, %c3, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%567, %c15, %c3, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %571 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %571) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %572 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg91, %572) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %573 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg13, %573) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %574 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%570, %574) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %575 = call @kernel_ttmc(%571, %572, %573, %574) {adf.kernel, "col, row" = [15 : index, 3 : index], ivs = [1 : index, 3 : index, 5 : index], kernel_ttmc = 127 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%575, %c16, %c3, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%572, %c16, %c3, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%573, %c16, %c3, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%571, %c15, %c2, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%575, %arg95) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %576 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %576) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %577 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg91, %577) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %578 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg15, %578) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %579 = call @kernel_ttmc0(%576, %577, %578) {adf.kernel, "col, row" = [19 : index, 2 : index], ivs = [0 : index, 4 : index, 5 : index], kernel = 0 : index, kernel_ttmc0 = 128 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%579, %c19, %c2, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%577, %c19, %c2, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%578, %c19, %c3, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%576, %c19, %c3, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %580 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %580) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %581 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg91, %581) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %582 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg16, %582) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %583 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%579, %583) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %584 = call @kernel_ttmc(%580, %581, %582, %583) {adf.kernel, "col, row" = [19 : index, 3 : index], ivs = [1 : index, 4 : index, 5 : index], kernel_ttmc = 129 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%584, %c20, %c3, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%581, %c20, %c3, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%582, %c20, %c3, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%580, %c19, %c2, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%584, %arg96) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %585 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %585) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %586 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg91, %586) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %587 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg18, %587) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %588 = call @kernel_ttmc0(%585, %586, %587) {adf.kernel, "col, row" = [23 : index, 2 : index], ivs = [0 : index, 5 : index, 5 : index], kernel = 0 : index, kernel_ttmc0 = 130 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%588, %c23, %c2, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%586, %c23, %c2, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%587, %c23, %c3, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%585, %c23, %c3, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %589 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %589) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %590 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg91, %590) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %591 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg19, %591) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %592 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%588, %592) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %593 = call @kernel_ttmc(%589, %590, %591, %592) {adf.kernel, "col, row" = [23 : index, 3 : index], ivs = [1 : index, 5 : index, 5 : index], kernel_ttmc = 131 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%593, %c24, %c3, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%590, %c24, %c3, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%591, %c24, %c3, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%589, %c23, %c2, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%593, %arg97) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %594 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %594) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %595 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg91, %595) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %596 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg21, %596) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %597 = call @kernel_ttmc0(%594, %595, %596) {adf.kernel, "col, row" = [27 : index, 2 : index], ivs = [0 : index, 6 : index, 5 : index], kernel = 0 : index, kernel_ttmc0 = 132 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%597, %c27, %c2, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%595, %c27, %c2, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%596, %c27, %c3, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%594, %c27, %c3, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %598 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %598) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %599 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg91, %599) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %600 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg22, %600) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %601 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%597, %601) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %602 = call @kernel_ttmc(%598, %599, %600, %601) {adf.kernel, "col, row" = [27 : index, 3 : index], ivs = [1 : index, 6 : index, 5 : index], kernel_ttmc = 133 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%602, %c28, %c3, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%599, %c28, %c3, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%600, %c28, %c3, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%598, %c27, %c2, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%602, %arg98) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %603 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %603) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %604 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg91, %604) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %605 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg24, %605) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %606 = call @kernel_ttmc0(%603, %604, %605) {adf.kernel, "col, row" = [31 : index, 2 : index], ivs = [0 : index, 7 : index, 5 : index], kernel = 0 : index, kernel_ttmc0 = 134 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%606, %c31, %c2, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%604, %c31, %c2, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%605, %c31, %c3, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%603, %c31, %c3, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %607 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %607) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %608 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg91, %608) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %609 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg25, %609) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %610 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%606, %610) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %611 = call @kernel_ttmc(%607, %608, %609, %610) {adf.kernel, "col, row" = [31 : index, 3 : index], ivs = [1 : index, 7 : index, 5 : index], kernel_ttmc = 135 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%611, %c32, %c3, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%608, %c32, %c3, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%609, %c32, %c3, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%607, %c31, %c2, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%611, %arg99) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %612 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %612) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %613 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg91, %613) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %614 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg27, %614) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %615 = call @kernel_ttmc0(%612, %613, %614) {adf.kernel, "col, row" = [35 : index, 2 : index], ivs = [0 : index, 8 : index, 5 : index], kernel = 0 : index, kernel_ttmc0 = 136 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%615, %c35, %c2, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%613, %c35, %c2, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%614, %c35, %c3, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%612, %c35, %c3, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %616 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %616) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %617 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg91, %617) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %618 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg28, %618) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %619 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%615, %619) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %620 = call @kernel_ttmc(%616, %617, %618, %619) {adf.kernel, "col, row" = [35 : index, 3 : index], ivs = [1 : index, 8 : index, 5 : index], kernel_ttmc = 137 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%620, %c36, %c3, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%617, %c36, %c3, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%618, %c36, %c3, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%616, %c35, %c2, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%620, %arg100) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %621 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %621) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %622 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg91, %622) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %623 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg30, %623) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %624 = call @kernel_ttmc0(%621, %622, %623) {adf.kernel, "col, row" = [39 : index, 2 : index], ivs = [0 : index, 9 : index, 5 : index], kernel = 0 : index, kernel_ttmc0 = 138 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%624, %c39, %c2, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%622, %c39, %c2, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%623, %c39, %c3, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%621, %c39, %c3, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %625 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %625) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %626 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg91, %626) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %627 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg31, %627) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %628 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%624, %628) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %629 = call @kernel_ttmc(%625, %626, %627, %628) {adf.kernel, "col, row" = [39 : index, 3 : index], ivs = [1 : index, 9 : index, 5 : index], kernel_ttmc = 139 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%629, %c40, %c3, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%626, %c40, %c3, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%627, %c40, %c3, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%625, %c39, %c2, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%629, %arg101) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %630 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %630) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %631 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg91, %631) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %632 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg33, %632) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %633 = call @kernel_ttmc0(%630, %631, %632) {adf.kernel, "col, row" = [43 : index, 2 : index], ivs = [0 : index, 10 : index, 5 : index], kernel = 0 : index, kernel_ttmc0 = 140 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%633, %c43, %c2, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%631, %c43, %c2, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%632, %c43, %c3, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%630, %c43, %c3, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %634 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %634) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %635 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg91, %635) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %636 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg34, %636) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %637 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%633, %637) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %638 = call @kernel_ttmc(%634, %635, %636, %637) {adf.kernel, "col, row" = [43 : index, 3 : index], ivs = [1 : index, 10 : index, 5 : index], kernel_ttmc = 141 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%638, %c44, %c3, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%635, %c44, %c3, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%636, %c44, %c3, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%634, %c43, %c2, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%638, %arg102) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %639 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %639) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %640 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg91, %640) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %641 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg36, %641) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %642 = call @kernel_ttmc0(%639, %640, %641) {adf.kernel, "col, row" = [47 : index, 2 : index], ivs = [0 : index, 11 : index, 5 : index], kernel = 0 : index, kernel_ttmc0 = 142 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%642, %c47, %c2, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%640, %c47, %c2, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%641, %c47, %c3, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%639, %c47, %c3, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %643 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %643) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %644 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg91, %644) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %645 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg37, %645) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %646 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%642, %646) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %647 = call @kernel_ttmc(%643, %644, %645, %646) {adf.kernel, "col, row" = [47 : index, 3 : index], ivs = [1 : index, 11 : index, 5 : index], kernel_ttmc = 143 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%647, %c48, %c3, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%644, %c48, %c3, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%645, %c48, %c3, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%643, %c47, %c2, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%647, %arg103) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %648 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %648) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %649 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg104, %649) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %650 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg2, %650) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %651 = call @kernel_ttmc0(%648, %649, %650) {adf.kernel, "col, row" = [3 : index, 4 : index], ivs = [0 : index, 0 : index, 6 : index], kernel = 0 : index, kernel_ttmc0 = 144 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%651, %c3, %c4, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%649, %c3, %c4, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%650, %c3, %c5, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%648, %c3, %c5, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %652 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %652) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %653 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg104, %653) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %654 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg4, %654) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %655 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%651, %655) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %656 = call @kernel_ttmc(%652, %653, %654, %655) {adf.kernel, "col, row" = [3 : index, 5 : index], ivs = [1 : index, 0 : index, 6 : index], kernel_ttmc = 145 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%656, %c4, %c5, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%653, %c4, %c5, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%654, %c4, %c5, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%652, %c3, %c4, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%656, %arg105) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %657 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %657) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %658 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg104, %658) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %659 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg6, %659) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %660 = call @kernel_ttmc0(%657, %658, %659) {adf.kernel, "col, row" = [7 : index, 4 : index], ivs = [0 : index, 1 : index, 6 : index], kernel = 0 : index, kernel_ttmc0 = 146 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%660, %c7, %c4, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%658, %c7, %c4, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%659, %c7, %c5, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%657, %c7, %c5, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %661 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %661) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %662 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg104, %662) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %663 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg7, %663) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %664 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%660, %664) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %665 = call @kernel_ttmc(%661, %662, %663, %664) {adf.kernel, "col, row" = [7 : index, 5 : index], ivs = [1 : index, 1 : index, 6 : index], kernel_ttmc = 147 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%665, %c8, %c5, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%662, %c8, %c5, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%663, %c8, %c5, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%661, %c7, %c4, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%665, %arg106) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %666 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %666) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %667 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg104, %667) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %668 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg9, %668) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %669 = call @kernel_ttmc0(%666, %667, %668) {adf.kernel, "col, row" = [11 : index, 4 : index], ivs = [0 : index, 2 : index, 6 : index], kernel = 0 : index, kernel_ttmc0 = 148 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%669, %c11, %c4, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%667, %c11, %c4, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%668, %c11, %c5, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%666, %c11, %c5, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %670 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %670) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %671 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg104, %671) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %672 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg10, %672) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %673 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%669, %673) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %674 = call @kernel_ttmc(%670, %671, %672, %673) {adf.kernel, "col, row" = [11 : index, 5 : index], ivs = [1 : index, 2 : index, 6 : index], kernel_ttmc = 149 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%674, %c12, %c5, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%671, %c12, %c5, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%672, %c12, %c5, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%670, %c11, %c4, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%674, %arg107) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %675 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %675) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %676 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg104, %676) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %677 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg12, %677) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %678 = call @kernel_ttmc0(%675, %676, %677) {adf.kernel, "col, row" = [15 : index, 4 : index], ivs = [0 : index, 3 : index, 6 : index], kernel = 0 : index, kernel_ttmc0 = 150 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%678, %c15, %c4, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%676, %c15, %c4, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%677, %c15, %c5, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%675, %c15, %c5, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %679 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %679) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %680 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg104, %680) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %681 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg13, %681) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %682 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%678, %682) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %683 = call @kernel_ttmc(%679, %680, %681, %682) {adf.kernel, "col, row" = [15 : index, 5 : index], ivs = [1 : index, 3 : index, 6 : index], kernel_ttmc = 151 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%683, %c16, %c5, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%680, %c16, %c5, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%681, %c16, %c5, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%679, %c15, %c4, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%683, %arg108) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %684 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %684) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %685 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg104, %685) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %686 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg15, %686) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %687 = call @kernel_ttmc0(%684, %685, %686) {adf.kernel, "col, row" = [19 : index, 4 : index], ivs = [0 : index, 4 : index, 6 : index], kernel = 0 : index, kernel_ttmc0 = 152 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%687, %c19, %c4, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%685, %c19, %c4, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%686, %c19, %c5, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%684, %c19, %c5, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %688 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %688) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %689 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg104, %689) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %690 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg16, %690) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %691 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%687, %691) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %692 = call @kernel_ttmc(%688, %689, %690, %691) {adf.kernel, "col, row" = [19 : index, 5 : index], ivs = [1 : index, 4 : index, 6 : index], kernel_ttmc = 153 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%692, %c20, %c5, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%689, %c20, %c5, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%690, %c20, %c5, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%688, %c19, %c4, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%692, %arg109) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %693 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %693) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %694 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg104, %694) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %695 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg18, %695) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %696 = call @kernel_ttmc0(%693, %694, %695) {adf.kernel, "col, row" = [23 : index, 4 : index], ivs = [0 : index, 5 : index, 6 : index], kernel = 0 : index, kernel_ttmc0 = 154 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%696, %c23, %c4, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%694, %c23, %c4, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%695, %c23, %c5, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%693, %c23, %c5, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %697 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %697) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %698 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg104, %698) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %699 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg19, %699) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %700 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%696, %700) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %701 = call @kernel_ttmc(%697, %698, %699, %700) {adf.kernel, "col, row" = [23 : index, 5 : index], ivs = [1 : index, 5 : index, 6 : index], kernel_ttmc = 155 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%701, %c24, %c5, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%698, %c24, %c5, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%699, %c24, %c5, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%697, %c23, %c4, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%701, %arg110) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %702 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %702) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %703 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg104, %703) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %704 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg21, %704) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %705 = call @kernel_ttmc0(%702, %703, %704) {adf.kernel, "col, row" = [27 : index, 4 : index], ivs = [0 : index, 6 : index, 6 : index], kernel = 0 : index, kernel_ttmc0 = 156 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%705, %c27, %c4, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%703, %c27, %c4, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%704, %c27, %c5, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%702, %c27, %c5, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %706 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %706) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %707 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg104, %707) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %708 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg22, %708) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %709 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%705, %709) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %710 = call @kernel_ttmc(%706, %707, %708, %709) {adf.kernel, "col, row" = [27 : index, 5 : index], ivs = [1 : index, 6 : index, 6 : index], kernel_ttmc = 157 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%710, %c28, %c5, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%707, %c28, %c5, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%708, %c28, %c5, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%706, %c27, %c4, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%710, %arg111) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %711 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %711) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %712 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg104, %712) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %713 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg24, %713) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %714 = call @kernel_ttmc0(%711, %712, %713) {adf.kernel, "col, row" = [31 : index, 4 : index], ivs = [0 : index, 7 : index, 6 : index], kernel = 0 : index, kernel_ttmc0 = 158 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%714, %c31, %c4, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%712, %c31, %c4, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%713, %c31, %c5, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%711, %c31, %c5, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %715 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %715) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %716 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg104, %716) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %717 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg25, %717) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %718 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%714, %718) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %719 = call @kernel_ttmc(%715, %716, %717, %718) {adf.kernel, "col, row" = [31 : index, 5 : index], ivs = [1 : index, 7 : index, 6 : index], kernel_ttmc = 159 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%719, %c32, %c5, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%716, %c32, %c5, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%717, %c32, %c5, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%715, %c31, %c4, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%719, %arg112) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %720 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %720) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %721 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg104, %721) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %722 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg27, %722) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %723 = call @kernel_ttmc0(%720, %721, %722) {adf.kernel, "col, row" = [35 : index, 4 : index], ivs = [0 : index, 8 : index, 6 : index], kernel = 0 : index, kernel_ttmc0 = 160 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%723, %c35, %c4, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%721, %c35, %c4, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%722, %c35, %c5, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%720, %c35, %c5, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %724 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %724) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %725 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg104, %725) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %726 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg28, %726) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %727 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%723, %727) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %728 = call @kernel_ttmc(%724, %725, %726, %727) {adf.kernel, "col, row" = [35 : index, 5 : index], ivs = [1 : index, 8 : index, 6 : index], kernel_ttmc = 161 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%728, %c36, %c5, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%725, %c36, %c5, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%726, %c36, %c5, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%724, %c35, %c4, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%728, %arg113) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %729 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %729) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %730 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg104, %730) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %731 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg30, %731) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %732 = call @kernel_ttmc0(%729, %730, %731) {adf.kernel, "col, row" = [39 : index, 4 : index], ivs = [0 : index, 9 : index, 6 : index], kernel = 0 : index, kernel_ttmc0 = 162 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%732, %c39, %c4, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%730, %c39, %c4, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%731, %c39, %c5, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%729, %c39, %c5, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %733 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %733) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %734 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg104, %734) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %735 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg31, %735) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %736 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%732, %736) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %737 = call @kernel_ttmc(%733, %734, %735, %736) {adf.kernel, "col, row" = [39 : index, 5 : index], ivs = [1 : index, 9 : index, 6 : index], kernel_ttmc = 163 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%737, %c40, %c5, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%734, %c40, %c5, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%735, %c40, %c5, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%733, %c39, %c4, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%737, %arg114) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %738 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %738) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %739 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg104, %739) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %740 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg33, %740) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %741 = call @kernel_ttmc0(%738, %739, %740) {adf.kernel, "col, row" = [43 : index, 4 : index], ivs = [0 : index, 10 : index, 6 : index], kernel = 0 : index, kernel_ttmc0 = 164 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%741, %c43, %c4, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%739, %c43, %c4, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%740, %c43, %c5, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%738, %c43, %c5, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %742 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %742) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %743 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg104, %743) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %744 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg34, %744) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %745 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%741, %745) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %746 = call @kernel_ttmc(%742, %743, %744, %745) {adf.kernel, "col, row" = [43 : index, 5 : index], ivs = [1 : index, 10 : index, 6 : index], kernel_ttmc = 165 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%746, %c44, %c5, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%743, %c44, %c5, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%744, %c44, %c5, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%742, %c43, %c4, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%746, %arg115) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %747 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %747) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %748 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg104, %748) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %749 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg36, %749) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %750 = call @kernel_ttmc0(%747, %748, %749) {adf.kernel, "col, row" = [47 : index, 4 : index], ivs = [0 : index, 11 : index, 6 : index], kernel = 0 : index, kernel_ttmc0 = 166 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%750, %c47, %c4, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%748, %c47, %c4, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%749, %c47, %c5, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%747, %c47, %c5, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %751 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %751) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %752 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg104, %752) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %753 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg37, %753) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %754 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%750, %754) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %755 = call @kernel_ttmc(%751, %752, %753, %754) {adf.kernel, "col, row" = [47 : index, 5 : index], ivs = [1 : index, 11 : index, 6 : index], kernel_ttmc = 167 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%755, %c48, %c5, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%752, %c48, %c5, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%753, %c48, %c5, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%751, %c47, %c4, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%755, %arg116) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %756 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %756) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %757 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg117, %757) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %758 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg2, %758) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %759 = call @kernel_ttmc0(%756, %757, %758) {adf.kernel, "col, row" = [3 : index, 6 : index], ivs = [0 : index, 0 : index, 7 : index], kernel = 0 : index, kernel_ttmc0 = 168 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%759, %c3, %c6, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%757, %c3, %c6, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%758, %c3, %c7, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%756, %c3, %c7, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %760 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %760) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %761 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg117, %761) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %762 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg4, %762) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %763 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%759, %763) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %764 = call @kernel_ttmc(%760, %761, %762, %763) {adf.kernel, "col, row" = [3 : index, 7 : index], ivs = [1 : index, 0 : index, 7 : index], kernel_ttmc = 169 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%764, %c4, %c7, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%761, %c4, %c7, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%762, %c4, %c7, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%760, %c3, %c6, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%764, %arg118) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %765 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %765) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %766 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg117, %766) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %767 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg6, %767) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %768 = call @kernel_ttmc0(%765, %766, %767) {adf.kernel, "col, row" = [7 : index, 6 : index], ivs = [0 : index, 1 : index, 7 : index], kernel = 0 : index, kernel_ttmc0 = 170 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%768, %c7, %c6, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%766, %c7, %c6, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%767, %c7, %c7, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%765, %c7, %c7, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %769 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %769) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %770 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg117, %770) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %771 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg7, %771) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %772 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%768, %772) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %773 = call @kernel_ttmc(%769, %770, %771, %772) {adf.kernel, "col, row" = [7 : index, 7 : index], ivs = [1 : index, 1 : index, 7 : index], kernel_ttmc = 171 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%773, %c8, %c7, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%770, %c8, %c7, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%771, %c8, %c7, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%769, %c7, %c6, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%773, %arg119) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %774 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %774) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %775 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg117, %775) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %776 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg9, %776) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %777 = call @kernel_ttmc0(%774, %775, %776) {adf.kernel, "col, row" = [11 : index, 6 : index], ivs = [0 : index, 2 : index, 7 : index], kernel = 0 : index, kernel_ttmc0 = 172 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%777, %c11, %c6, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%775, %c11, %c6, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%776, %c11, %c7, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%774, %c11, %c7, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %778 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %778) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %779 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg117, %779) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %780 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg10, %780) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %781 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%777, %781) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %782 = call @kernel_ttmc(%778, %779, %780, %781) {adf.kernel, "col, row" = [11 : index, 7 : index], ivs = [1 : index, 2 : index, 7 : index], kernel_ttmc = 173 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%782, %c12, %c7, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%779, %c12, %c7, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%780, %c12, %c7, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%778, %c11, %c6, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%782, %arg120) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %783 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %783) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %784 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg117, %784) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %785 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg12, %785) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %786 = call @kernel_ttmc0(%783, %784, %785) {adf.kernel, "col, row" = [15 : index, 6 : index], ivs = [0 : index, 3 : index, 7 : index], kernel = 0 : index, kernel_ttmc0 = 174 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%786, %c15, %c6, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%784, %c15, %c6, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%785, %c15, %c7, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%783, %c15, %c7, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %787 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %787) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %788 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg117, %788) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %789 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg13, %789) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %790 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%786, %790) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %791 = call @kernel_ttmc(%787, %788, %789, %790) {adf.kernel, "col, row" = [15 : index, 7 : index], ivs = [1 : index, 3 : index, 7 : index], kernel_ttmc = 175 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%791, %c16, %c7, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%788, %c16, %c7, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%789, %c16, %c7, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%787, %c15, %c6, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%791, %arg121) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %792 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %792) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %793 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg117, %793) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %794 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg15, %794) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %795 = call @kernel_ttmc0(%792, %793, %794) {adf.kernel, "col, row" = [19 : index, 6 : index], ivs = [0 : index, 4 : index, 7 : index], kernel = 0 : index, kernel_ttmc0 = 176 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%795, %c19, %c6, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%793, %c19, %c6, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%794, %c19, %c7, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%792, %c19, %c7, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %796 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %796) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %797 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg117, %797) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %798 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg16, %798) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %799 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%795, %799) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %800 = call @kernel_ttmc(%796, %797, %798, %799) {adf.kernel, "col, row" = [19 : index, 7 : index], ivs = [1 : index, 4 : index, 7 : index], kernel_ttmc = 177 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%800, %c20, %c7, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%797, %c20, %c7, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%798, %c20, %c7, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%796, %c19, %c6, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%800, %arg122) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %801 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %801) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %802 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg117, %802) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %803 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg18, %803) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %804 = call @kernel_ttmc0(%801, %802, %803) {adf.kernel, "col, row" = [23 : index, 6 : index], ivs = [0 : index, 5 : index, 7 : index], kernel = 0 : index, kernel_ttmc0 = 178 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%804, %c23, %c6, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%802, %c23, %c6, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%803, %c23, %c7, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%801, %c23, %c7, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %805 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %805) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %806 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg117, %806) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %807 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg19, %807) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %808 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%804, %808) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %809 = call @kernel_ttmc(%805, %806, %807, %808) {adf.kernel, "col, row" = [23 : index, 7 : index], ivs = [1 : index, 5 : index, 7 : index], kernel_ttmc = 179 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%809, %c24, %c7, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%806, %c24, %c7, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%807, %c24, %c7, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%805, %c23, %c6, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%809, %arg123) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %810 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %810) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %811 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg117, %811) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %812 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg21, %812) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %813 = call @kernel_ttmc0(%810, %811, %812) {adf.kernel, "col, row" = [27 : index, 6 : index], ivs = [0 : index, 6 : index, 7 : index], kernel = 0 : index, kernel_ttmc0 = 180 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%813, %c27, %c6, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%811, %c27, %c6, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%812, %c27, %c7, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%810, %c27, %c7, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %814 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %814) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %815 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg117, %815) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %816 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg22, %816) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %817 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%813, %817) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %818 = call @kernel_ttmc(%814, %815, %816, %817) {adf.kernel, "col, row" = [27 : index, 7 : index], ivs = [1 : index, 6 : index, 7 : index], kernel_ttmc = 181 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%818, %c28, %c7, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%815, %c28, %c7, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%816, %c28, %c7, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%814, %c27, %c6, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%818, %arg124) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %819 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %819) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %820 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg117, %820) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %821 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg24, %821) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %822 = call @kernel_ttmc0(%819, %820, %821) {adf.kernel, "col, row" = [31 : index, 6 : index], ivs = [0 : index, 7 : index, 7 : index], kernel = 0 : index, kernel_ttmc0 = 182 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%822, %c31, %c6, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%820, %c31, %c6, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%821, %c31, %c7, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%819, %c31, %c7, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %823 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %823) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %824 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg117, %824) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %825 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg25, %825) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %826 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%822, %826) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %827 = call @kernel_ttmc(%823, %824, %825, %826) {adf.kernel, "col, row" = [31 : index, 7 : index], ivs = [1 : index, 7 : index, 7 : index], kernel_ttmc = 183 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%827, %c32, %c7, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%824, %c32, %c7, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%825, %c32, %c7, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%823, %c31, %c6, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%827, %arg125) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %828 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %828) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %829 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg117, %829) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %830 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg27, %830) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %831 = call @kernel_ttmc0(%828, %829, %830) {adf.kernel, "col, row" = [35 : index, 6 : index], ivs = [0 : index, 8 : index, 7 : index], kernel = 0 : index, kernel_ttmc0 = 184 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%831, %c35, %c6, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%829, %c35, %c6, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%830, %c35, %c7, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%828, %c35, %c7, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %832 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %832) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %833 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg117, %833) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %834 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg28, %834) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %835 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%831, %835) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %836 = call @kernel_ttmc(%832, %833, %834, %835) {adf.kernel, "col, row" = [35 : index, 7 : index], ivs = [1 : index, 8 : index, 7 : index], kernel_ttmc = 185 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%836, %c36, %c7, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%833, %c36, %c7, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%834, %c36, %c7, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%832, %c35, %c6, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%836, %arg126) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %837 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %837) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %838 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg117, %838) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %839 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg30, %839) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %840 = call @kernel_ttmc0(%837, %838, %839) {adf.kernel, "col, row" = [39 : index, 6 : index], ivs = [0 : index, 9 : index, 7 : index], kernel = 0 : index, kernel_ttmc0 = 186 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%840, %c39, %c6, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%838, %c39, %c6, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%839, %c39, %c7, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%837, %c39, %c7, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %841 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %841) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %842 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg117, %842) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %843 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg31, %843) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %844 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%840, %844) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %845 = call @kernel_ttmc(%841, %842, %843, %844) {adf.kernel, "col, row" = [39 : index, 7 : index], ivs = [1 : index, 9 : index, 7 : index], kernel_ttmc = 187 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%845, %c40, %c7, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%842, %c40, %c7, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%843, %c40, %c7, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%841, %c39, %c6, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%845, %arg127) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %846 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %846) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %847 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg117, %847) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %848 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg33, %848) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %849 = call @kernel_ttmc0(%846, %847, %848) {adf.kernel, "col, row" = [43 : index, 6 : index], ivs = [0 : index, 10 : index, 7 : index], kernel = 0 : index, kernel_ttmc0 = 188 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%849, %c43, %c6, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%847, %c43, %c6, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%848, %c43, %c7, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%846, %c43, %c7, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %850 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %850) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %851 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg117, %851) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %852 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg34, %852) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %853 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%849, %853) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %854 = call @kernel_ttmc(%850, %851, %852, %853) {adf.kernel, "col, row" = [43 : index, 7 : index], ivs = [1 : index, 10 : index, 7 : index], kernel_ttmc = 189 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%854, %c44, %c7, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%851, %c44, %c7, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%852, %c44, %c7, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%850, %c43, %c6, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%854, %arg128) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    %855 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg0, %855) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %856 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg117, %856) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %857 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg36, %857) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %858 = call @kernel_ttmc0(%855, %856, %857) {adf.kernel, "col, row" = [47 : index, 6 : index], ivs = [0 : index, 11 : index, 7 : index], kernel = 0 : index, kernel_ttmc0 = 190 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%858, %c47, %c6, %c16384, %c24576) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%856, %c47, %c6, %c0, %c8192) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%857, %c47, %c7, %c16384, %c24576) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%855, %c47, %c7, %c0, %c8192) : (memref<2x16x32xi32, 2>, index, index, index, index)
    %859 = adf.buffer.create() : memref<2x16x32xi32, 2>
    adf.connect(%arg3, %859) : (!adf.plio<In, 128>, memref<2x16x32xi32, 2>)
    %860 = adf.buffer.create() : memref<16x16xi32, 2>
    adf.connect(%arg117, %860) : (!adf.plio<In, 128>, memref<16x16xi32, 2>)
    %861 = adf.buffer.create() : memref<32x16xi32, 2>
    adf.connect(%arg37, %861) : (!adf.plio<In, 128>, memref<32x16xi32, 2>)
    %862 = adf.buffer.create() : memref<2x16x16xi32, 2>
    adf.connect(%858, %862) : (memref<2x16x16xi32, 2>, memref<2x16x16xi32, 2>)
    %863 = call @kernel_ttmc(%859, %860, %861, %862) {adf.kernel, "col, row" = [47 : index, 7 : index], ivs = [1 : index, 11 : index, 7 : index], kernel_ttmc = 191 : index} : (memref<2x16x32xi32, 2>, memref<16x16xi32, 2>, memref<32x16xi32, 2>, memref<2x16x16xi32, 2>) -> memref<2x16x16xi32, 2>
    adf.buffer.location(%863, %c48, %c7, %c4096, %c12288) : (memref<2x16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%860, %c48, %c7, %c16384, %c24576) : (memref<16x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%861, %c48, %c7, %c0, %c8192) : (memref<32x16xi32, 2>, index, index, index, index)
    adf.buffer.location(%859, %c47, %c6, %c4096, %c12288) : (memref<2x16x32xi32, 2>, index, index, index, index)
    adf.connect(%863, %arg129) {write = 1 : index} : (memref<2x16x16xi32, 2>, !adf.plio<Out, 128>)
    return
  }
  func.func @receive13(%arg0: memref<1xi128, "stream">, %arg1: memref<1xi128, "plio">) attributes {adf.pl, inline = false, receive, template} {
    %c63 = arith.constant 63 : index
    %c32 = arith.constant 32 : index
    %c127 = arith.constant 127 : index
    %c0 = arith.constant 0 : index
    %c64 = arith.constant 64 : index
    %c0_i128 = arith.constant 0 : i128
    %c95 = arith.constant 95 : index
    %c31 = arith.constant 31 : index
    %c96 = arith.constant 96 : index
    %alloc = memref.alloc() {buffer_type = "bram_s2p"} : memref<2x32x8xi128, 1>
    affine.for %arg2 = 0 to 2 {
      affine.for %arg3 = 0 to 32 {
        affine.for %arg4 = 0 to 8 {
          affine.store %c0_i128, %alloc[%arg2, %arg3, %arg4] : memref<2x32x8xi128, 1>
        } {pipeline_ii = 1 : index}
      }
    }
    affine.for %arg2 = 0 to 2 {
      affine.for %arg3 = 0 to 2 {
        affine.for %arg4 = 0 to 2 {
          affine.for %arg5 = 0 to 8 {
            affine.for %arg6 = 0 to 8 {
              affine.for %arg7 = 0 to 1 {
                affine.for %arg8 = 0 to 2 {
                  affine.for %arg9 = 0 to 2 {
                    affine.for %arg10 = 0 to 8 {
                      affine.for %arg11 = 0 to 8 {
                        affine.for %arg12 = 0 to 2 {
                          affine.for %arg13 = 0 to 16 {
                            affine.for %arg14 = 0 to 4 {
                              %0 = affine.load %arg1[0] : memref<1xi128, "plio">
                              %1 = affine.load %alloc[%arg12 + %arg7 * 2, %arg13 + %arg8 * 16, %arg14 + %arg9 * 4] : memref<2x32x8xi128, 1>
                              %2 = adf.int_to_apint(%0) : (i128) -> i128
                              %3 = adf.int_to_apint(%1) : (i128) -> i128
                              %4 = adf.int_to_apint(%c0_i128) : (i128) -> i128
                              %5 = adf.get_slice(%2 : i128, %c31, %c0) -> i32
                              %6 = adf.get_slice(%3 : i128, %c31, %c0) -> i32
                              %7 = arith.addi %5, %6 : i32
                              adf.set_slice(%4 : i128, %c31, %c0, %7 : i32)
                              %8 = adf.get_slice(%2 : i128, %c63, %c32) -> i32
                              %9 = adf.get_slice(%3 : i128, %c63, %c32) -> i32
                              %10 = arith.addi %8, %9 : i32
                              adf.set_slice(%4 : i128, %c63, %c32, %10 : i32)
                              %11 = adf.get_slice(%2 : i128, %c95, %c64) -> i32
                              %12 = adf.get_slice(%3 : i128, %c95, %c64) -> i32
                              %13 = arith.addi %11, %12 : i32
                              adf.set_slice(%4 : i128, %c95, %c64, %13 : i32)
                              %14 = adf.get_slice(%2 : i128, %c127, %c96) -> i32
                              %15 = adf.get_slice(%3 : i128, %c127, %c96) -> i32
                              %16 = arith.addi %14, %15 : i32
                              adf.set_slice(%4 : i128, %c127, %c96, %16 : i32)
                              %17 = adf.apint_to_int(%4) : (i128) -> i128
                              affine.store %17, %alloc[%arg12 + %arg7 * 2, %arg13 + %arg8 * 16, %arg14 + %arg9 * 4] : memref<2x32x8xi128, 1>
                            } {pipeline_ii = 1 : index}
                          }
                        }
                      }
                    }
                  }
                }
              }
            } {Array_Partition, reduction}
          } {reduction}
          affine.for %arg5 = 0 to 1 {
            affine.for %arg6 = 0 to 2 {
              affine.for %arg7 = 0 to 2 {
                affine.for %arg8 = 0 to 16 {
                  affine.for %arg9 = 0 to 2 {
                    affine.for %arg10 = 0 to 4 {
                      %0 = affine.load %alloc[%arg7 + %arg5 * 2, %arg8 + %arg6 * 16, %arg10 + %arg9 * 4] : memref<2x32x8xi128, 1>
                      affine.store %0, %arg0[0] : memref<1xi128, "stream">
                      affine.store %c0_i128, %alloc[%arg7 + %arg5 * 2, %arg8 + %arg6 * 16, %arg10 + %arg9 * 4] : memref<2x32x8xi128, 1>
                    } {pipeline_ii = 1 : index}
                  }
                }
              }
            }
          }
        }
      }
    }
    return
  }
  func.func @receive13_top(%arg0: memref<1xi128, "stream">, %arg1: memref<1xi128, "plio">, %arg2: memref<1xi128, "stream">, %arg3: memref<1xi128, "plio">, %arg4: memref<1xi128, "stream">, %arg5: memref<1xi128, "plio">, %arg6: memref<1xi128, "stream">, %arg7: memref<1xi128, "plio">, %arg8: memref<1xi128, "stream">, %arg9: memref<1xi128, "plio">, %arg10: memref<1xi128, "stream">, %arg11: memref<1xi128, "plio">, %arg12: memref<1xi128, "stream">, %arg13: memref<1xi128, "plio">, %arg14: memref<1xi128, "stream">, %arg15: memref<1xi128, "plio">, %arg16: memref<1xi128, "stream">, %arg17: memref<1xi128, "plio">, %arg18: memref<1xi128, "stream">, %arg19: memref<1xi128, "plio">, %arg20: memref<1xi128, "stream">, %arg21: memref<1xi128, "plio">, %arg22: memref<1xi128, "stream">, %arg23: memref<1xi128, "plio">, %arg24: memref<1xi128, "stream">, %arg25: memref<1xi128, "plio">, %arg26: memref<1xi128, "stream">, %arg27: memref<1xi128, "plio">, %arg28: memref<1xi128, "stream">, %arg29: memref<1xi128, "plio">, %arg30: memref<1xi128, "stream">, %arg31: memref<1xi128, "plio">, %arg32: memref<1xi128, "stream">, %arg33: memref<1xi128, "plio">, %arg34: memref<1xi128, "stream">, %arg35: memref<1xi128, "plio">, %arg36: memref<1xi128, "stream">, %arg37: memref<1xi128, "plio">, %arg38: memref<1xi128, "stream">, %arg39: memref<1xi128, "plio">, %arg40: memref<1xi128, "stream">, %arg41: memref<1xi128, "plio">, %arg42: memref<1xi128, "stream">, %arg43: memref<1xi128, "plio">, %arg44: memref<1xi128, "stream">, %arg45: memref<1xi128, "plio">, %arg46: memref<1xi128, "stream">, %arg47: memref<1xi128, "plio">, %arg48: memref<1xi128, "stream">, %arg49: memref<1xi128, "plio">, %arg50: memref<1xi128, "stream">, %arg51: memref<1xi128, "plio">, %arg52: memref<1xi128, "stream">, %arg53: memref<1xi128, "plio">, %arg54: memref<1xi128, "stream">, %arg55: memref<1xi128, "plio">, %arg56: memref<1xi128, "stream">, %arg57: memref<1xi128, "plio">, %arg58: memref<1xi128, "stream">, %arg59: memref<1xi128, "plio">, %arg60: memref<1xi128, "stream">, %arg61: memref<1xi128, "plio">, %arg62: memref<1xi128, "stream">, %arg63: memref<1xi128, "plio">, %arg64: memref<1xi128, "stream">, %arg65: memref<1xi128, "plio">, %arg66: memref<1xi128, "stream">, %arg67: memref<1xi128, "plio">, %arg68: memref<1xi128, "stream">, %arg69: memref<1xi128, "plio">, %arg70: memref<1xi128, "stream">, %arg71: memref<1xi128, "plio">, %arg72: memref<1xi128, "stream">, %arg73: memref<1xi128, "plio">, %arg74: memref<1xi128, "stream">, %arg75: memref<1xi128, "plio">, %arg76: memref<1xi128, "stream">, %arg77: memref<1xi128, "plio">, %arg78: memref<1xi128, "stream">, %arg79: memref<1xi128, "plio">, %arg80: memref<1xi128, "stream">, %arg81: memref<1xi128, "plio">, %arg82: memref<1xi128, "stream">, %arg83: memref<1xi128, "plio">, %arg84: memref<1xi128, "stream">, %arg85: memref<1xi128, "plio">, %arg86: memref<1xi128, "stream">, %arg87: memref<1xi128, "plio">, %arg88: memref<1xi128, "stream">, %arg89: memref<1xi128, "plio">) attributes {adf.pl, inline = false} {
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
    call @receive13(%arg76, %arg77) {template = 38 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @receive13(%arg78, %arg79) {template = 39 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @receive13(%arg80, %arg81) {template = 40 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @receive13(%arg82, %arg83) {template = 41 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @receive13(%arg84, %arg85) {template = 42 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @receive13(%arg86, %arg87) {template = 43 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @receive13(%arg88, %arg89) {template = 44 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    return
  }
  func.func @send29_0(%arg0: memref<1xi128, "stream">, %arg1: memref<128x8xi128, 1>, %arg2: i1) attributes {adf.pl, inline = false} {
    scf.if %arg2 {
      affine.for %arg3 = 0 to 8 {
        affine.for %arg4 = 0 to 16 {
          affine.for %arg5 = 0 to 2 {
            affine.for %arg6 = 0 to 4 {
              %0 = affine.load %arg0[0] : memref<1xi128, "stream">
              affine.store %0, %arg1[%arg4 + %arg3 * 16, %arg6 + %arg5 * 4] : memref<128x8xi128, 1>
            } {pipeline_ii = 1 : index}
          }
        }
      }
    }
    return
  }
  func.func @send29_1(%arg0: memref<128x8xi128, 1>, %arg1: memref<1xi128, "plio">, %arg2: i1) attributes {adf.pl, inline = false} {
    scf.if %arg2 {
      affine.for %arg3 = 0 to 1 {
        affine.for %arg4 = 0 to 2 {
          affine.for %arg5 = 0 to 2 {
            affine.for %arg6 = 0 to 8 {
              affine.for %arg7 = 0 to 8 {
                affine.for %arg8 = 0 to 16 {
                  affine.for %arg9 = 0 to 4 {
                    %0 = affine.load %arg0[%arg8 + %arg6 * 16, %arg9 + %arg4 * 4] : memref<128x8xi128, 1>
                    affine.store %0, %arg1[0] : memref<1xi128, "plio">
                  } {pipeline_ii = 1 : index}
                }
              }
            }
          }
        }
      }
    }
    return
  }
  func.func @send29(%arg0: memref<1xi128, "stream">, %arg1: memref<1xi128, "plio">) attributes {adf.pl, inline = false, send, template} {
    %c256 = arith.constant 256 : index
    %c128 = arith.constant 128 : index
    %c64 = arith.constant 64 : index
    %true = arith.constant true
    %c8 = arith.constant 8 : index
    %c0 = arith.constant 0 : index
    %c2 = arith.constant 2 : index
    %alloc = memref.alloc() {buffer_type = "bram_s2p"} : memref<128x8xi128, 1>
    %alloc_0 = memref.alloc() {buffer_type = "bram_s2p"} : memref<128x8xi128, 1>
    affine.for %arg2 = 0 to 2 {
      affine.for %arg3 = 0 to 2 {
        affine.for %arg4 = 0 to 2 {
          affine.for %arg5 = 0 to 8 {
            affine.for %arg6 = 0 to 8 {
              %0 = arith.muli %arg5, %c8 : index
              %1 = arith.addi %arg6, %0 : index
              %2 = arith.muli %arg4, %c64 : index
              %3 = arith.addi %1, %2 : index
              %4 = arith.muli %arg3, %c128 : index
              %5 = arith.addi %3, %4 : index
              %6 = arith.muli %arg2, %c256 : index
              %7 = arith.addi %5, %6 : index
              %8 = arith.remsi %7, %c2 : index
              %9 = arith.cmpi eq, %8, %c0 : index
              %10 = arith.cmpi ne, %7, %c0 : index
              scf.if %9 {
                func.call @send29_0(%arg0, %alloc, %true) : (memref<1xi128, "stream">, memref<128x8xi128, 1>, i1) -> ()
                func.call @send29_1(%alloc_0, %arg1, %10) : (memref<128x8xi128, 1>, memref<1xi128, "plio">, i1) -> ()
              } else {
                func.call @send29_0(%arg0, %alloc_0, %true) : (memref<1xi128, "stream">, memref<128x8xi128, 1>, i1) -> ()
                func.call @send29_1(%alloc, %arg1, %10) : (memref<128x8xi128, 1>, memref<1xi128, "plio">, i1) -> ()
              }
            } {Array_Partition, reduction}
          } {reduction}
        }
      }
    }
    call @send29_1(%alloc_0, %arg1, %true) : (memref<128x8xi128, 1>, memref<1xi128, "plio">, i1) -> ()
    return
  }
  func.func @send29_top(%arg0: memref<1xi128, "stream">, %arg1: memref<1xi128, "plio">, %arg2: memref<1xi128, "stream">, %arg3: memref<1xi128, "plio">, %arg4: memref<1xi128, "stream">, %arg5: memref<1xi128, "plio">, %arg6: memref<1xi128, "stream">, %arg7: memref<1xi128, "plio">, %arg8: memref<1xi128, "stream">, %arg9: memref<1xi128, "plio">, %arg10: memref<1xi128, "stream">, %arg11: memref<1xi128, "plio">, %arg12: memref<1xi128, "stream">, %arg13: memref<1xi128, "plio">, %arg14: memref<1xi128, "stream">, %arg15: memref<1xi128, "plio">) attributes {adf.pl, inline = false} {
    call @send29(%arg0, %arg1) {template = 0 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send29(%arg2, %arg3) {template = 1 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send29(%arg4, %arg5) {template = 2 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send29(%arg6, %arg7) {template = 3 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send29(%arg8, %arg9) {template = 4 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send29(%arg10, %arg11) {template = 5 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send29(%arg12, %arg13) {template = 6 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send29(%arg14, %arg15) {template = 7 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    return
  }
  func.func @send21_0(%arg0: memref<1xi128, "stream">, %arg1: memref<256x8xi128, 1>, %arg2: i1) attributes {adf.pl, inline = false} {
    scf.if %arg2 {
      affine.for %arg3 = 0 to 8 {
        affine.for %arg4 = 0 to 32 {
          affine.for %arg5 = 0 to 2 {
            affine.for %arg6 = 0 to 4 {
              %0 = affine.load %arg0[0] : memref<1xi128, "stream">
              affine.store %0, %arg1[%arg4 + %arg3 * 32, %arg6 + %arg5 * 4] : memref<256x8xi128, 1>
            } {pipeline_ii = 1 : index}
          }
        }
      }
    }
    return
  }
  func.func @send21_1(%arg0: memref<256x8xi128, 1>, %arg1: memref<1xi128, "plio">, %arg2: i1) attributes {adf.pl, inline = false} {
    scf.if %arg2 {
      affine.for %arg3 = 0 to 1 {
        affine.for %arg4 = 0 to 2 {
          affine.for %arg5 = 0 to 2 {
            affine.for %arg6 = 0 to 8 {
              affine.for %arg7 = 0 to 8 {
                affine.for %arg8 = 0 to 32 {
                  affine.for %arg9 = 0 to 4 {
                    %0 = affine.load %arg0[%arg8 + %arg7 * 32, %arg9 + %arg5 * 4] : memref<256x8xi128, 1>
                    affine.store %0, %arg1[0] : memref<1xi128, "plio">
                  } {pipeline_ii = 1 : index}
                }
              }
            }
          }
        }
      }
    }
    return
  }
  func.func @send21(%arg0: memref<1xi128, "stream">, %arg1: memref<1xi128, "plio">) attributes {adf.pl, inline = false, send, template} {
    %c256 = arith.constant 256 : index
    %c128 = arith.constant 128 : index
    %c64 = arith.constant 64 : index
    %true = arith.constant true
    %c8 = arith.constant 8 : index
    %c0 = arith.constant 0 : index
    %c2 = arith.constant 2 : index
    %alloc = memref.alloc() {buffer_type = "uram_t2p"} : memref<256x8xi128, 1>
    %alloc_0 = memref.alloc() {buffer_type = "uram_t2p"} : memref<256x8xi128, 1>
    affine.for %arg2 = 0 to 2 {
      affine.for %arg3 = 0 to 2 {
        affine.for %arg4 = 0 to 2 {
          affine.for %arg5 = 0 to 8 {
            affine.for %arg6 = 0 to 8 {
              %0 = arith.muli %arg5, %c8 : index
              %1 = arith.addi %arg6, %0 : index
              %2 = arith.muli %arg4, %c64 : index
              %3 = arith.addi %1, %2 : index
              %4 = arith.muli %arg3, %c128 : index
              %5 = arith.addi %3, %4 : index
              %6 = arith.muli %arg2, %c256 : index
              %7 = arith.addi %5, %6 : index
              %8 = arith.remsi %7, %c2 : index
              %9 = arith.cmpi eq, %8, %c0 : index
              %10 = arith.cmpi ne, %7, %c0 : index
              scf.if %9 {
                func.call @send21_0(%arg0, %alloc, %true) : (memref<1xi128, "stream">, memref<256x8xi128, 1>, i1) -> ()
                func.call @send21_1(%alloc_0, %arg1, %10) : (memref<256x8xi128, 1>, memref<1xi128, "plio">, i1) -> ()
              } else {
                func.call @send21_0(%arg0, %alloc_0, %true) : (memref<1xi128, "stream">, memref<256x8xi128, 1>, i1) -> ()
                func.call @send21_1(%alloc, %arg1, %10) : (memref<256x8xi128, 1>, memref<1xi128, "plio">, i1) -> ()
              }
            } {Array_Partition, reduction}
          } {reduction}
        }
      }
    }
    call @send21_1(%alloc_0, %arg1, %true) : (memref<256x8xi128, 1>, memref<1xi128, "plio">, i1) -> ()
    return
  }
  func.func @send21_top(%arg0: memref<1xi128, "stream">, %arg1: memref<1xi128, "plio">, %arg2: memref<1xi128, "stream">, %arg3: memref<1xi128, "plio">, %arg4: memref<1xi128, "stream">, %arg5: memref<1xi128, "plio">, %arg6: memref<1xi128, "stream">, %arg7: memref<1xi128, "plio">, %arg8: memref<1xi128, "stream">, %arg9: memref<1xi128, "plio">, %arg10: memref<1xi128, "stream">, %arg11: memref<1xi128, "plio">, %arg12: memref<1xi128, "stream">, %arg13: memref<1xi128, "plio">, %arg14: memref<1xi128, "stream">, %arg15: memref<1xi128, "plio">, %arg16: memref<1xi128, "stream">, %arg17: memref<1xi128, "plio">, %arg18: memref<1xi128, "stream">, %arg19: memref<1xi128, "plio">, %arg20: memref<1xi128, "stream">, %arg21: memref<1xi128, "plio">, %arg22: memref<1xi128, "stream">, %arg23: memref<1xi128, "plio">, %arg24: memref<1xi128, "stream">, %arg25: memref<1xi128, "plio">, %arg26: memref<1xi128, "stream">, %arg27: memref<1xi128, "plio">, %arg28: memref<1xi128, "stream">, %arg29: memref<1xi128, "plio">, %arg30: memref<1xi128, "stream">, %arg31: memref<1xi128, "plio">, %arg32: memref<1xi128, "stream">, %arg33: memref<1xi128, "plio">, %arg34: memref<1xi128, "stream">, %arg35: memref<1xi128, "plio">, %arg36: memref<1xi128, "stream">, %arg37: memref<1xi128, "plio">, %arg38: memref<1xi128, "stream">, %arg39: memref<1xi128, "plio">, %arg40: memref<1xi128, "stream">, %arg41: memref<1xi128, "plio">, %arg42: memref<1xi128, "stream">, %arg43: memref<1xi128, "plio">, %arg44: memref<1xi128, "stream">, %arg45: memref<1xi128, "plio">, %arg46: memref<1xi128, "stream">, %arg47: memref<1xi128, "plio">) attributes {adf.pl, inline = false} {
    call @send21(%arg0, %arg1) {template = 0 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send21(%arg2, %arg3) {template = 1 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send21(%arg4, %arg5) {template = 2 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send21(%arg6, %arg7) {template = 3 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send21(%arg8, %arg9) {template = 4 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send21(%arg10, %arg11) {template = 5 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send21(%arg12, %arg13) {template = 6 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send21(%arg14, %arg15) {template = 7 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send21(%arg16, %arg17) {template = 8 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send21(%arg18, %arg19) {template = 9 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send21(%arg20, %arg21) {template = 10 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send21(%arg22, %arg23) {template = 11 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send21(%arg24, %arg25) {template = 12 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send21(%arg26, %arg27) {template = 13 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send21(%arg28, %arg29) {template = 14 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send21(%arg30, %arg31) {template = 15 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send21(%arg32, %arg33) {template = 16 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send21(%arg34, %arg35) {template = 17 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send21(%arg36, %arg37) {template = 18 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send21(%arg38, %arg39) {template = 19 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send21(%arg40, %arg41) {template = 20 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send21(%arg42, %arg43) {template = 21 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send21(%arg44, %arg45) {template = 22 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send21(%arg46, %arg47) {template = 23 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    return
  }
  func.func @receive2(%arg0: memref<1xi128, "plio">, %arg1: memref<1xi128, "stream">) attributes {adf.pl, inline = false, receive, template} {
    %c96 = arith.constant 96 : index
    %c31 = arith.constant 31 : index
    %c95 = arith.constant 95 : index
    %c64 = arith.constant 64 : index
    %c0 = arith.constant 0 : index
    %c127 = arith.constant 127 : index
    %c32 = arith.constant 32 : index
    %c63 = arith.constant 63 : index
    %c0_i128 = arith.constant 0 : i128
    %alloc = memref.alloc() {buffer_type = "bram_s2p"} : memref<2x32x8xi128, 1>
    affine.for %arg2 = 0 to 2 {
      affine.for %arg3 = 0 to 32 {
        affine.for %arg4 = 0 to 8 {
          affine.store %c0_i128, %alloc[%arg2, %arg3, %arg4] : memref<2x32x8xi128, 1>
        } {pipeline_ii = 1 : index}
      }
    }
    affine.for %arg2 = 0 to 2 {
      affine.for %arg3 = 0 to 2 {
        affine.for %arg4 = 0 to 2 {
          affine.for %arg5 = 0 to 8 {
            affine.for %arg6 = 0 to 8 {
              affine.for %arg7 = 0 to 1 {
                affine.for %arg8 = 0 to 2 {
                  affine.for %arg9 = 0 to 2 {
                    affine.for %arg10 = 0 to 8 {
                      affine.for %arg11 = 0 to 8 {
                        affine.for %arg12 = 0 to 2 {
                          affine.for %arg13 = 0 to 16 {
                            affine.for %arg14 = 0 to 4 {
                              %0 = affine.load %arg0[0] : memref<1xi128, "plio">
                              %1 = affine.load %alloc[%arg12 + %arg7 * 2, %arg13 + %arg8 * 16, %arg14 + %arg9 * 4] : memref<2x32x8xi128, 1>
                              %2 = adf.int_to_apint(%0) : (i128) -> i128
                              %3 = adf.int_to_apint(%1) : (i128) -> i128
                              %4 = adf.int_to_apint(%c0_i128) : (i128) -> i128
                              %5 = adf.get_slice(%2 : i128, %c31, %c0) -> i32
                              %6 = adf.get_slice(%3 : i128, %c31, %c0) -> i32
                              %7 = arith.addi %5, %6 : i32
                              adf.set_slice(%4 : i128, %c31, %c0, %7 : i32)
                              %8 = adf.get_slice(%2 : i128, %c63, %c32) -> i32
                              %9 = adf.get_slice(%3 : i128, %c63, %c32) -> i32
                              %10 = arith.addi %8, %9 : i32
                              adf.set_slice(%4 : i128, %c63, %c32, %10 : i32)
                              %11 = adf.get_slice(%2 : i128, %c95, %c64) -> i32
                              %12 = adf.get_slice(%3 : i128, %c95, %c64) -> i32
                              %13 = arith.addi %11, %12 : i32
                              adf.set_slice(%4 : i128, %c95, %c64, %13 : i32)
                              %14 = adf.get_slice(%2 : i128, %c127, %c96) -> i32
                              %15 = adf.get_slice(%3 : i128, %c127, %c96) -> i32
                              %16 = arith.addi %14, %15 : i32
                              adf.set_slice(%4 : i128, %c127, %c96, %16 : i32)
                              %17 = adf.apint_to_int(%4) : (i128) -> i128
                              affine.store %17, %alloc[%arg12 + %arg7 * 2, %arg13 + %arg8 * 16, %arg14 + %arg9 * 4] : memref<2x32x8xi128, 1>
                            } {pipeline_ii = 1 : index}
                          }
                        }
                      }
                    }
                  }
                }
              }
            } {Array_Partition, reduction}
          } {reduction}
          affine.for %arg5 = 0 to 1 {
            affine.for %arg6 = 0 to 2 {
              affine.for %arg7 = 0 to 2 {
                affine.for %arg8 = 0 to 16 {
                  affine.for %arg9 = 0 to 2 {
                    affine.for %arg10 = 0 to 4 {
                      %0 = affine.load %alloc[%arg7 + %arg5 * 2, %arg8 + %arg6 * 16, %arg10 + %arg9 * 4] : memref<2x32x8xi128, 1>
                      affine.store %0, %arg1[0] : memref<1xi128, "stream">
                      affine.store %c0_i128, %alloc[%arg7 + %arg5 * 2, %arg8 + %arg6 * 16, %arg10 + %arg9 * 4] : memref<2x32x8xi128, 1>
                    } {pipeline_ii = 1 : index}
                  }
                }
              }
            }
          }
        }
      }
    }
    return
  }
  func.func @receive2_top(%arg0: memref<1xi128, "plio">, %arg1: memref<1xi128, "stream">, %arg2: memref<1xi128, "plio">, %arg3: memref<1xi128, "stream">, %arg4: memref<1xi128, "plio">, %arg5: memref<1xi128, "stream">, %arg6: memref<1xi128, "plio">, %arg7: memref<1xi128, "stream">, %arg8: memref<1xi128, "plio">, %arg9: memref<1xi128, "stream">, %arg10: memref<1xi128, "plio">, %arg11: memref<1xi128, "stream">, %arg12: memref<1xi128, "plio">, %arg13: memref<1xi128, "stream">, %arg14: memref<1xi128, "plio">, %arg15: memref<1xi128, "stream">, %arg16: memref<1xi128, "plio">, %arg17: memref<1xi128, "stream">, %arg18: memref<1xi128, "plio">, %arg19: memref<1xi128, "stream">, %arg20: memref<1xi128, "plio">, %arg21: memref<1xi128, "stream">, %arg22: memref<1xi128, "plio">, %arg23: memref<1xi128, "stream">, %arg24: memref<1xi128, "plio">, %arg25: memref<1xi128, "stream">, %arg26: memref<1xi128, "plio">, %arg27: memref<1xi128, "stream">, %arg28: memref<1xi128, "plio">, %arg29: memref<1xi128, "stream">, %arg30: memref<1xi128, "plio">, %arg31: memref<1xi128, "stream">, %arg32: memref<1xi128, "plio">, %arg33: memref<1xi128, "stream">, %arg34: memref<1xi128, "plio">, %arg35: memref<1xi128, "stream">, %arg36: memref<1xi128, "plio">, %arg37: memref<1xi128, "stream">, %arg38: memref<1xi128, "plio">, %arg39: memref<1xi128, "stream">, %arg40: memref<1xi128, "plio">, %arg41: memref<1xi128, "stream">, %arg42: memref<1xi128, "plio">, %arg43: memref<1xi128, "stream">, %arg44: memref<1xi128, "plio">, %arg45: memref<1xi128, "stream">, %arg46: memref<1xi128, "plio">, %arg47: memref<1xi128, "stream">, %arg48: memref<1xi128, "plio">, %arg49: memref<1xi128, "stream">, %arg50: memref<1xi128, "plio">, %arg51: memref<1xi128, "stream">, %arg52: memref<1xi128, "plio">, %arg53: memref<1xi128, "stream">, %arg54: memref<1xi128, "plio">, %arg55: memref<1xi128, "stream">, %arg56: memref<1xi128, "plio">, %arg57: memref<1xi128, "stream">, %arg58: memref<1xi128, "plio">, %arg59: memref<1xi128, "stream">, %arg60: memref<1xi128, "plio">, %arg61: memref<1xi128, "stream">, %arg62: memref<1xi128, "plio">, %arg63: memref<1xi128, "stream">, %arg64: memref<1xi128, "plio">, %arg65: memref<1xi128, "stream">, %arg66: memref<1xi128, "plio">, %arg67: memref<1xi128, "stream">, %arg68: memref<1xi128, "plio">, %arg69: memref<1xi128, "stream">, %arg70: memref<1xi128, "plio">, %arg71: memref<1xi128, "stream">, %arg72: memref<1xi128, "plio">, %arg73: memref<1xi128, "stream">, %arg74: memref<1xi128, "plio">, %arg75: memref<1xi128, "stream">, %arg76: memref<1xi128, "plio">, %arg77: memref<1xi128, "stream">, %arg78: memref<1xi128, "plio">, %arg79: memref<1xi128, "stream">, %arg80: memref<1xi128, "plio">, %arg81: memref<1xi128, "stream">, %arg82: memref<1xi128, "plio">, %arg83: memref<1xi128, "stream">, %arg84: memref<1xi128, "plio">, %arg85: memref<1xi128, "stream">, %arg86: memref<1xi128, "plio">, %arg87: memref<1xi128, "stream">, %arg88: memref<1xi128, "plio">, %arg89: memref<1xi128, "stream">, %arg90: memref<1xi128, "plio">, %arg91: memref<1xi128, "stream">, %arg92: memref<1xi128, "plio">, %arg93: memref<1xi128, "stream">, %arg94: memref<1xi128, "plio">, %arg95: memref<1xi128, "stream">, %arg96: memref<1xi128, "plio">, %arg97: memref<1xi128, "stream">, %arg98: memref<1xi128, "plio">, %arg99: memref<1xi128, "stream">, %arg100: memref<1xi128, "plio">, %arg101: memref<1xi128, "stream">) attributes {adf.pl, inline = false} {
    call @receive2(%arg0, %arg1) {template = 0 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive2(%arg2, %arg3) {template = 1 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive2(%arg4, %arg5) {template = 2 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive2(%arg6, %arg7) {template = 3 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive2(%arg8, %arg9) {template = 4 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive2(%arg10, %arg11) {template = 5 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive2(%arg12, %arg13) {template = 6 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive2(%arg14, %arg15) {template = 7 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive2(%arg16, %arg17) {template = 8 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive2(%arg18, %arg19) {template = 9 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive2(%arg20, %arg21) {template = 10 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive2(%arg22, %arg23) {template = 11 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive2(%arg24, %arg25) {template = 12 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive2(%arg26, %arg27) {template = 13 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive2(%arg28, %arg29) {template = 14 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive2(%arg30, %arg31) {template = 15 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive2(%arg32, %arg33) {template = 16 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive2(%arg34, %arg35) {template = 17 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive2(%arg36, %arg37) {template = 18 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive2(%arg38, %arg39) {template = 19 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive2(%arg40, %arg41) {template = 20 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive2(%arg42, %arg43) {template = 21 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive2(%arg44, %arg45) {template = 22 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive2(%arg46, %arg47) {template = 23 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive2(%arg48, %arg49) {template = 24 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive2(%arg50, %arg51) {template = 25 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive2(%arg52, %arg53) {template = 26 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive2(%arg54, %arg55) {template = 27 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive2(%arg56, %arg57) {template = 28 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive2(%arg58, %arg59) {template = 29 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive2(%arg60, %arg61) {template = 30 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive2(%arg62, %arg63) {template = 31 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive2(%arg64, %arg65) {template = 32 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive2(%arg66, %arg67) {template = 33 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive2(%arg68, %arg69) {template = 34 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive2(%arg70, %arg71) {template = 35 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive2(%arg72, %arg73) {template = 36 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive2(%arg74, %arg75) {template = 37 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive2(%arg76, %arg77) {template = 38 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive2(%arg78, %arg79) {template = 39 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive2(%arg80, %arg81) {template = 40 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive2(%arg82, %arg83) {template = 41 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive2(%arg84, %arg85) {template = 42 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive2(%arg86, %arg87) {template = 43 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive2(%arg88, %arg89) {template = 44 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive2(%arg90, %arg91) {template = 45 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive2(%arg92, %arg93) {template = 46 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive2(%arg94, %arg95) {template = 47 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive2(%arg96, %arg97) {template = 48 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive2(%arg98, %arg99) {template = 49 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @receive2(%arg100, %arg101) {template = 50 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    return
  }
  func.func @store0_0(%arg0: memref<1xi128, "stream">, %arg1: memref<1xi512, "stream1">) attributes {adf.pl, inline = false, store, template} {
    %c0_i512 = arith.constant 0 : i512
    affine.for %arg2 = 0 to 2 {
      affine.for %arg3 = 0 to 2 {
        affine.for %arg4 = 0 to 2 {
          affine.for %arg5 = 0 to 1 {
            affine.for %arg6 = 0 to 2 {
              affine.for %arg7 = 0 to 2 {
                affine.for %arg8 = 0 to 16 {
                  affine.for %arg9 = 0 to 2 {
                    affine.for %arg10 = 0 to 1 {
                      %0 = adf.int_to_apint(%c0_i512) : (i512) -> i512
                      affine.for %arg11 = 0 to 4 {
                        %1 = affine.load %arg0[0] : memref<1xi128, "stream">
                        %2 = affine.apply #map(%arg11)
                        %3 = affine.apply #map1(%arg11)
                        adf.set_slice(%0 : i512, %2, %3, %1 : i128)
                      } {pipeline_ii = 1 : index}
                      affine.store %0, %arg1[0] : memref<1xi512, "stream1">
                    } {pipeline_ii = 4 : index}
                  }
                }
              }
            }
          }
        }
      }
    }
    return
  }
  func.func @store0_0_top(%arg0: memref<1xi128, "stream">, %arg1: memref<1xi512, "stream1">, %arg2: memref<1xi128, "stream">, %arg3: memref<1xi512, "stream1">, %arg4: memref<1xi128, "stream">, %arg5: memref<1xi512, "stream1">, %arg6: memref<1xi128, "stream">, %arg7: memref<1xi512, "stream1">, %arg8: memref<1xi128, "stream">, %arg9: memref<1xi512, "stream1">, %arg10: memref<1xi128, "stream">, %arg11: memref<1xi512, "stream1">, %arg12: memref<1xi128, "stream">, %arg13: memref<1xi512, "stream1">, %arg14: memref<1xi128, "stream">, %arg15: memref<1xi512, "stream1">, %arg16: memref<1xi128, "stream">, %arg17: memref<1xi512, "stream1">, %arg18: memref<1xi128, "stream">, %arg19: memref<1xi512, "stream1">, %arg20: memref<1xi128, "stream">, %arg21: memref<1xi512, "stream1">, %arg22: memref<1xi128, "stream">, %arg23: memref<1xi512, "stream1">, %arg24: memref<1xi128, "stream">, %arg25: memref<1xi512, "stream1">, %arg26: memref<1xi128, "stream">, %arg27: memref<1xi512, "stream1">, %arg28: memref<1xi128, "stream">, %arg29: memref<1xi512, "stream1">, %arg30: memref<1xi128, "stream">, %arg31: memref<1xi512, "stream1">, %arg32: memref<1xi128, "stream">, %arg33: memref<1xi512, "stream1">, %arg34: memref<1xi128, "stream">, %arg35: memref<1xi512, "stream1">, %arg36: memref<1xi128, "stream">, %arg37: memref<1xi512, "stream1">, %arg38: memref<1xi128, "stream">, %arg39: memref<1xi512, "stream1">, %arg40: memref<1xi128, "stream">, %arg41: memref<1xi512, "stream1">, %arg42: memref<1xi128, "stream">, %arg43: memref<1xi512, "stream1">, %arg44: memref<1xi128, "stream">, %arg45: memref<1xi512, "stream1">, %arg46: memref<1xi128, "stream">, %arg47: memref<1xi512, "stream1">, %arg48: memref<1xi128, "stream">, %arg49: memref<1xi512, "stream1">, %arg50: memref<1xi128, "stream">, %arg51: memref<1xi512, "stream1">, %arg52: memref<1xi128, "stream">, %arg53: memref<1xi512, "stream1">, %arg54: memref<1xi128, "stream">, %arg55: memref<1xi512, "stream1">, %arg56: memref<1xi128, "stream">, %arg57: memref<1xi512, "stream1">, %arg58: memref<1xi128, "stream">, %arg59: memref<1xi512, "stream1">, %arg60: memref<1xi128, "stream">, %arg61: memref<1xi512, "stream1">, %arg62: memref<1xi128, "stream">, %arg63: memref<1xi512, "stream1">, %arg64: memref<1xi128, "stream">, %arg65: memref<1xi512, "stream1">, %arg66: memref<1xi128, "stream">, %arg67: memref<1xi512, "stream1">, %arg68: memref<1xi128, "stream">, %arg69: memref<1xi512, "stream1">, %arg70: memref<1xi128, "stream">, %arg71: memref<1xi512, "stream1">, %arg72: memref<1xi128, "stream">, %arg73: memref<1xi512, "stream1">, %arg74: memref<1xi128, "stream">, %arg75: memref<1xi512, "stream1">, %arg76: memref<1xi128, "stream">, %arg77: memref<1xi512, "stream1">, %arg78: memref<1xi128, "stream">, %arg79: memref<1xi512, "stream1">, %arg80: memref<1xi128, "stream">, %arg81: memref<1xi512, "stream1">, %arg82: memref<1xi128, "stream">, %arg83: memref<1xi512, "stream1">, %arg84: memref<1xi128, "stream">, %arg85: memref<1xi512, "stream1">, %arg86: memref<1xi128, "stream">, %arg87: memref<1xi512, "stream1">, %arg88: memref<1xi128, "stream">, %arg89: memref<1xi512, "stream1">, %arg90: memref<1xi128, "stream">, %arg91: memref<1xi512, "stream1">, %arg92: memref<1xi128, "stream">, %arg93: memref<1xi512, "stream1">, %arg94: memref<1xi128, "stream">, %arg95: memref<1xi512, "stream1">, %arg96: memref<1xi128, "stream">, %arg97: memref<1xi512, "stream1">, %arg98: memref<1xi128, "stream">, %arg99: memref<1xi512, "stream1">, %arg100: memref<1xi128, "stream">, %arg101: memref<1xi512, "stream1">, %arg102: memref<1xi128, "stream">, %arg103: memref<1xi512, "stream1">, %arg104: memref<1xi128, "stream">, %arg105: memref<1xi512, "stream1">, %arg106: memref<1xi128, "stream">, %arg107: memref<1xi512, "stream1">, %arg108: memref<1xi128, "stream">, %arg109: memref<1xi512, "stream1">, %arg110: memref<1xi128, "stream">, %arg111: memref<1xi512, "stream1">, %arg112: memref<1xi128, "stream">, %arg113: memref<1xi512, "stream1">, %arg114: memref<1xi128, "stream">, %arg115: memref<1xi512, "stream1">, %arg116: memref<1xi128, "stream">, %arg117: memref<1xi512, "stream1">, %arg118: memref<1xi128, "stream">, %arg119: memref<1xi512, "stream1">, %arg120: memref<1xi128, "stream">, %arg121: memref<1xi512, "stream1">, %arg122: memref<1xi128, "stream">, %arg123: memref<1xi512, "stream1">, %arg124: memref<1xi128, "stream">, %arg125: memref<1xi512, "stream1">, %arg126: memref<1xi128, "stream">, %arg127: memref<1xi512, "stream1">, %arg128: memref<1xi128, "stream">, %arg129: memref<1xi512, "stream1">, %arg130: memref<1xi128, "stream">, %arg131: memref<1xi512, "stream1">, %arg132: memref<1xi128, "stream">, %arg133: memref<1xi512, "stream1">, %arg134: memref<1xi128, "stream">, %arg135: memref<1xi512, "stream1">, %arg136: memref<1xi128, "stream">, %arg137: memref<1xi512, "stream1">, %arg138: memref<1xi128, "stream">, %arg139: memref<1xi512, "stream1">, %arg140: memref<1xi128, "stream">, %arg141: memref<1xi512, "stream1">, %arg142: memref<1xi128, "stream">, %arg143: memref<1xi512, "stream1">, %arg144: memref<1xi128, "stream">, %arg145: memref<1xi512, "stream1">, %arg146: memref<1xi128, "stream">, %arg147: memref<1xi512, "stream1">, %arg148: memref<1xi128, "stream">, %arg149: memref<1xi512, "stream1">, %arg150: memref<1xi128, "stream">, %arg151: memref<1xi512, "stream1">, %arg152: memref<1xi128, "stream">, %arg153: memref<1xi512, "stream1">, %arg154: memref<1xi128, "stream">, %arg155: memref<1xi512, "stream1">, %arg156: memref<1xi128, "stream">, %arg157: memref<1xi512, "stream1">, %arg158: memref<1xi128, "stream">, %arg159: memref<1xi512, "stream1">, %arg160: memref<1xi128, "stream">, %arg161: memref<1xi512, "stream1">, %arg162: memref<1xi128, "stream">, %arg163: memref<1xi512, "stream1">, %arg164: memref<1xi128, "stream">, %arg165: memref<1xi512, "stream1">, %arg166: memref<1xi128, "stream">, %arg167: memref<1xi512, "stream1">, %arg168: memref<1xi128, "stream">, %arg169: memref<1xi512, "stream1">, %arg170: memref<1xi128, "stream">, %arg171: memref<1xi512, "stream1">, %arg172: memref<1xi128, "stream">, %arg173: memref<1xi512, "stream1">, %arg174: memref<1xi128, "stream">, %arg175: memref<1xi512, "stream1">, %arg176: memref<1xi128, "stream">, %arg177: memref<1xi512, "stream1">, %arg178: memref<1xi128, "stream">, %arg179: memref<1xi512, "stream1">, %arg180: memref<1xi128, "stream">, %arg181: memref<1xi512, "stream1">, %arg182: memref<1xi128, "stream">, %arg183: memref<1xi512, "stream1">, %arg184: memref<1xi128, "stream">, %arg185: memref<1xi512, "stream1">, %arg186: memref<1xi128, "stream">, %arg187: memref<1xi512, "stream1">, %arg188: memref<1xi128, "stream">, %arg189: memref<1xi512, "stream1">, %arg190: memref<1xi128, "stream">, %arg191: memref<1xi512, "stream1">) attributes {adf.pl, inline = false} {
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
    call @store0_0(%arg160, %arg161) {template = 80 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg162, %arg163) {template = 81 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg164, %arg165) {template = 82 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg166, %arg167) {template = 83 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg168, %arg169) {template = 84 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg170, %arg171) {template = 85 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg172, %arg173) {template = 86 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg174, %arg175) {template = 87 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg176, %arg177) {template = 88 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg178, %arg179) {template = 89 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg180, %arg181) {template = 90 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg182, %arg183) {template = 91 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg184, %arg185) {template = 92 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg186, %arg187) {template = 93 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg188, %arg189) {template = 94 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_0(%arg190, %arg191) {template = 95 : index} : (memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    return
  }
  func.func @store0(%arg0: memref<1xi512, "stream1">, %arg1: memref<1xi512, "stream1">, %arg2: memref<1xi512, "stream1">, %arg3: memref<1xi512, "stream1">, %arg4: memref<1xi512, "stream1">, %arg5: memref<1xi512, "stream1">, %arg6: memref<1xi512, "stream1">, %arg7: memref<1xi512, "stream1">, %arg8: memref<1xi512, "stream1">, %arg9: memref<1xi512, "stream1">, %arg10: memref<1xi512, "stream1">, %arg11: memref<1xi512, "stream1">, %arg12: memref<1xi512, "stream1">, %arg13: memref<1xi512, "stream1">, %arg14: memref<1xi512, "stream1">, %arg15: memref<1xi512, "stream1">, %arg16: memref<1xi512, "stream1">, %arg17: memref<1xi512, "stream1">, %arg18: memref<1xi512, "stream1">, %arg19: memref<1xi512, "stream1">, %arg20: memref<1xi512, "stream1">, %arg21: memref<1xi512, "stream1">, %arg22: memref<1xi512, "stream1">, %arg23: memref<1xi512, "stream1">, %arg24: memref<1xi512, "stream1">, %arg25: memref<1xi512, "stream1">, %arg26: memref<1xi512, "stream1">, %arg27: memref<1xi512, "stream1">, %arg28: memref<1xi512, "stream1">, %arg29: memref<1xi512, "stream1">, %arg30: memref<1xi512, "stream1">, %arg31: memref<1xi512, "stream1">, %arg32: memref<1xi512, "stream1">, %arg33: memref<1xi512, "stream1">, %arg34: memref<1xi512, "stream1">, %arg35: memref<1xi512, "stream1">, %arg36: memref<1xi512, "stream1">, %arg37: memref<1xi512, "stream1">, %arg38: memref<1xi512, "stream1">, %arg39: memref<1xi512, "stream1">, %arg40: memref<1xi512, "stream1">, %arg41: memref<1xi512, "stream1">, %arg42: memref<1xi512, "stream1">, %arg43: memref<1xi512, "stream1">, %arg44: memref<1xi512, "stream1">, %arg45: memref<1xi512, "stream1">, %arg46: memref<1xi512, "stream1">, %arg47: memref<1xi512, "stream1">, %arg48: memref<1xi512, "stream1">, %arg49: memref<1xi512, "stream1">, %arg50: memref<1xi512, "stream1">, %arg51: memref<1xi512, "stream1">, %arg52: memref<1xi512, "stream1">, %arg53: memref<4x512x48xi512>, %arg54: memref<1xi512, "stream1">, %arg55: memref<1xi512, "stream1">, %arg56: memref<1xi512, "stream1">, %arg57: memref<1xi512, "stream1">, %arg58: memref<1xi512, "stream1">, %arg59: memref<1xi512, "stream1">, %arg60: memref<1xi512, "stream1">, %arg61: memref<1xi512, "stream1">, %arg62: memref<1xi512, "stream1">, %arg63: memref<1xi512, "stream1">, %arg64: memref<1xi512, "stream1">, %arg65: memref<1xi512, "stream1">, %arg66: memref<1xi512, "stream1">, %arg67: memref<1xi512, "stream1">, %arg68: memref<1xi512, "stream1">, %arg69: memref<1xi512, "stream1">, %arg70: memref<1xi512, "stream1">, %arg71: memref<1xi512, "stream1">, %arg72: memref<1xi512, "stream1">, %arg73: memref<1xi512, "stream1">, %arg74: memref<1xi512, "stream1">, %arg75: memref<1xi512, "stream1">, %arg76: memref<1xi512, "stream1">, %arg77: memref<1xi512, "stream1">, %arg78: memref<1xi512, "stream1">, %arg79: memref<1xi512, "stream1">, %arg80: memref<1xi512, "stream1">, %arg81: memref<1xi512, "stream1">, %arg82: memref<1xi512, "stream1">, %arg83: memref<1xi512, "stream1">, %arg84: memref<1xi512, "stream1">, %arg85: memref<1xi512, "stream1">, %arg86: memref<1xi512, "stream1">, %arg87: memref<1xi512, "stream1">, %arg88: memref<1xi512, "stream1">, %arg89: memref<1xi512, "stream1">, %arg90: memref<1xi512, "stream1">, %arg91: memref<1xi512, "stream1">, %arg92: memref<1xi512, "stream1">, %arg93: memref<1xi512, "stream1">, %arg94: memref<1xi512, "stream1">, %arg95: memref<1xi512, "stream1">, %arg96: memref<1xi512, "stream1">) attributes {adf.pl, inline = false, mem_idx = [53 : i32], mem_type = [i32], store, template} {
    %c11 = arith.constant 11 : index
    %c10 = arith.constant 10 : index
    %c9 = arith.constant 9 : index
    %c8 = arith.constant 8 : index
    %c7 = arith.constant 7 : index
    %c6 = arith.constant 6 : index
    %c5 = arith.constant 5 : index
    %c4 = arith.constant 4 : index
    %c3 = arith.constant 3 : index
    %c2 = arith.constant 2 : index
    %c1 = arith.constant 1 : index
    affine.for %arg97 = 0 to 2 {
      affine.for %arg98 = 0 to 2 {
        affine.for %arg99 = 0 to 2 {
          affine.for %arg100 = 0 to 1 {
            affine.for %arg101 = 0 to 2 {
              affine.for %arg102 = 0 to 2 {
                affine.for %arg103 = 0 to 16 {
                  affine.for %arg104 = 0 to 2 {
                    affine.for %arg105 = 0 to 12 {
                      %0 = arith.cmpi slt, %arg105, %c1 : index
                      %1 = scf.if %0 -> (i512) {
                        %2 = affine.load %arg75[0] : memref<1xi512, "stream1">
                        scf.yield %2 : i512
                      } else {
                        %2 = arith.cmpi slt, %arg105, %c2 : index
                        %3 = scf.if %2 -> (i512) {
                          %4 = affine.load %arg50[0] : memref<1xi512, "stream1">
                          scf.yield %4 : i512
                        } else {
                          %4 = arith.cmpi slt, %arg105, %c3 : index
                          %5 = scf.if %4 -> (i512) {
                            %6 = affine.load %arg52[0] : memref<1xi512, "stream1">
                            scf.yield %6 : i512
                          } else {
                            %6 = arith.cmpi slt, %arg105, %c4 : index
                            %7 = scf.if %6 -> (i512) {
                              %8 = affine.load %arg33[0] : memref<1xi512, "stream1">
                              scf.yield %8 : i512
                            } else {
                              %8 = arith.cmpi slt, %arg105, %c5 : index
                              %9 = scf.if %8 -> (i512) {
                                %10 = affine.load %arg5[0] : memref<1xi512, "stream1">
                                scf.yield %10 : i512
                              } else {
                                %10 = arith.cmpi slt, %arg105, %c6 : index
                                %11 = scf.if %10 -> (i512) {
                                  %12 = affine.load %arg93[0] : memref<1xi512, "stream1">
                                  scf.yield %12 : i512
                                } else {
                                  %12 = arith.cmpi slt, %arg105, %c7 : index
                                  %13 = scf.if %12 -> (i512) {
                                    %14 = affine.load %arg46[0] : memref<1xi512, "stream1">
                                    scf.yield %14 : i512
                                  } else {
                                    %14 = arith.cmpi slt, %arg105, %c8 : index
                                    %15 = scf.if %14 -> (i512) {
                                      %16 = affine.load %arg42[0] : memref<1xi512, "stream1">
                                      scf.yield %16 : i512
                                    } else {
                                      %16 = arith.cmpi slt, %arg105, %c9 : index
                                      %17 = scf.if %16 -> (i512) {
                                        %18 = affine.load %arg21[0] : memref<1xi512, "stream1">
                                        scf.yield %18 : i512
                                      } else {
                                        %18 = arith.cmpi slt, %arg105, %c10 : index
                                        %19 = scf.if %18 -> (i512) {
                                          %20 = affine.load %arg94[0] : memref<1xi512, "stream1">
                                          scf.yield %20 : i512
                                        } else {
                                          %20 = arith.cmpi slt, %arg105, %c11 : index
                                          %21 = scf.if %20 -> (i512) {
                                            %22 = affine.load %arg90[0] : memref<1xi512, "stream1">
                                            scf.yield %22 : i512
                                          } else {
                                            %22 = affine.load %arg77[0] : memref<1xi512, "stream1">
                                            scf.yield %22 : i512
                                          }
                                          scf.yield %21 : i512
                                        }
                                        scf.yield %19 : i512
                                      }
                                      scf.yield %17 : i512
                                    }
                                    scf.yield %15 : i512
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
                      affine.store %1, %arg53[%arg102 + %arg100 * 2 + %arg97 * 2, %arg103 + %arg101 * 128 + %arg98 * 256, %arg105 + %arg104 * 12 + %arg99 * 24] : memref<4x512x48xi512>
                    } {pipeline_ii = 1 : index}
                  }
                }
              }
            }
          } {merge}
          affine.for %arg100 = 0 to 1 {
            affine.for %arg101 = 0 to 2 {
              affine.for %arg102 = 0 to 2 {
                affine.for %arg103 = 0 to 16 {
                  affine.for %arg104 = 0 to 2 {
                    affine.for %arg105 = 0 to 12 {
                      %0 = arith.cmpi slt, %arg105, %c1 : index
                      %1 = scf.if %0 -> (i512) {
                        %2 = affine.load %arg56[0] : memref<1xi512, "stream1">
                        scf.yield %2 : i512
                      } else {
                        %2 = arith.cmpi slt, %arg105, %c2 : index
                        %3 = scf.if %2 -> (i512) {
                          %4 = affine.load %arg62[0] : memref<1xi512, "stream1">
                          scf.yield %4 : i512
                        } else {
                          %4 = arith.cmpi slt, %arg105, %c3 : index
                          %5 = scf.if %4 -> (i512) {
                            %6 = affine.load %arg9[0] : memref<1xi512, "stream1">
                            scf.yield %6 : i512
                          } else {
                            %6 = arith.cmpi slt, %arg105, %c4 : index
                            %7 = scf.if %6 -> (i512) {
                              %8 = affine.load %arg15[0] : memref<1xi512, "stream1">
                              scf.yield %8 : i512
                            } else {
                              %8 = arith.cmpi slt, %arg105, %c5 : index
                              %9 = scf.if %8 -> (i512) {
                                %10 = affine.load %arg40[0] : memref<1xi512, "stream1">
                                scf.yield %10 : i512
                              } else {
                                %10 = arith.cmpi slt, %arg105, %c6 : index
                                %11 = scf.if %10 -> (i512) {
                                  %12 = affine.load %arg45[0] : memref<1xi512, "stream1">
                                  scf.yield %12 : i512
                                } else {
                                  %12 = arith.cmpi slt, %arg105, %c7 : index
                                  %13 = scf.if %12 -> (i512) {
                                    %14 = affine.load %arg89[0] : memref<1xi512, "stream1">
                                    scf.yield %14 : i512
                                  } else {
                                    %14 = arith.cmpi slt, %arg105, %c8 : index
                                    %15 = scf.if %14 -> (i512) {
                                      %16 = affine.load %arg84[0] : memref<1xi512, "stream1">
                                      scf.yield %16 : i512
                                    } else {
                                      %16 = arith.cmpi slt, %arg105, %c9 : index
                                      %17 = scf.if %16 -> (i512) {
                                        %18 = affine.load %arg76[0] : memref<1xi512, "stream1">
                                        scf.yield %18 : i512
                                      } else {
                                        %18 = arith.cmpi slt, %arg105, %c10 : index
                                        %19 = scf.if %18 -> (i512) {
                                          %20 = affine.load %arg19[0] : memref<1xi512, "stream1">
                                          scf.yield %20 : i512
                                        } else {
                                          %20 = arith.cmpi slt, %arg105, %c11 : index
                                          %21 = scf.if %20 -> (i512) {
                                            %22 = affine.load %arg28[0] : memref<1xi512, "stream1">
                                            scf.yield %22 : i512
                                          } else {
                                            %22 = affine.load %arg70[0] : memref<1xi512, "stream1">
                                            scf.yield %22 : i512
                                          }
                                          scf.yield %21 : i512
                                        }
                                        scf.yield %19 : i512
                                      }
                                      scf.yield %17 : i512
                                    }
                                    scf.yield %15 : i512
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
                      affine.store %1, %arg53[%arg102 + %arg100 * 2 + %arg97 * 2, %arg103 + %arg101 * 128 + %arg98 * 256 + 16, %arg105 + %arg104 * 12 + %arg99 * 24] : memref<4x512x48xi512>
                    } {pipeline_ii = 1 : index}
                  }
                }
              }
            }
          } {merge}
          affine.for %arg100 = 0 to 1 {
            affine.for %arg101 = 0 to 2 {
              affine.for %arg102 = 0 to 2 {
                affine.for %arg103 = 0 to 16 {
                  affine.for %arg104 = 0 to 2 {
                    affine.for %arg105 = 0 to 12 {
                      %0 = arith.cmpi slt, %arg105, %c1 : index
                      %1 = scf.if %0 -> (i512) {
                        %2 = affine.load %arg14[0] : memref<1xi512, "stream1">
                        scf.yield %2 : i512
                      } else {
                        %2 = arith.cmpi slt, %arg105, %c2 : index
                        %3 = scf.if %2 -> (i512) {
                          %4 = affine.load %arg63[0] : memref<1xi512, "stream1">
                          scf.yield %4 : i512
                        } else {
                          %4 = arith.cmpi slt, %arg105, %c3 : index
                          %5 = scf.if %4 -> (i512) {
                            %6 = affine.load %arg27[0] : memref<1xi512, "stream1">
                            scf.yield %6 : i512
                          } else {
                            %6 = arith.cmpi slt, %arg105, %c4 : index
                            %7 = scf.if %6 -> (i512) {
                              %8 = affine.load %arg2[0] : memref<1xi512, "stream1">
                              scf.yield %8 : i512
                            } else {
                              %8 = arith.cmpi slt, %arg105, %c5 : index
                              %9 = scf.if %8 -> (i512) {
                                %10 = affine.load %arg17[0] : memref<1xi512, "stream1">
                                scf.yield %10 : i512
                              } else {
                                %10 = arith.cmpi slt, %arg105, %c6 : index
                                %11 = scf.if %10 -> (i512) {
                                  %12 = affine.load %arg31[0] : memref<1xi512, "stream1">
                                  scf.yield %12 : i512
                                } else {
                                  %12 = arith.cmpi slt, %arg105, %c7 : index
                                  %13 = scf.if %12 -> (i512) {
                                    %14 = affine.load %arg7[0] : memref<1xi512, "stream1">
                                    scf.yield %14 : i512
                                  } else {
                                    %14 = arith.cmpi slt, %arg105, %c8 : index
                                    %15 = scf.if %14 -> (i512) {
                                      %16 = affine.load %arg29[0] : memref<1xi512, "stream1">
                                      scf.yield %16 : i512
                                    } else {
                                      %16 = arith.cmpi slt, %arg105, %c9 : index
                                      %17 = scf.if %16 -> (i512) {
                                        %18 = affine.load %arg61[0] : memref<1xi512, "stream1">
                                        scf.yield %18 : i512
                                      } else {
                                        %18 = arith.cmpi slt, %arg105, %c10 : index
                                        %19 = scf.if %18 -> (i512) {
                                          %20 = affine.load %arg3[0] : memref<1xi512, "stream1">
                                          scf.yield %20 : i512
                                        } else {
                                          %20 = arith.cmpi slt, %arg105, %c11 : index
                                          %21 = scf.if %20 -> (i512) {
                                            %22 = affine.load %arg39[0] : memref<1xi512, "stream1">
                                            scf.yield %22 : i512
                                          } else {
                                            %22 = affine.load %arg92[0] : memref<1xi512, "stream1">
                                            scf.yield %22 : i512
                                          }
                                          scf.yield %21 : i512
                                        }
                                        scf.yield %19 : i512
                                      }
                                      scf.yield %17 : i512
                                    }
                                    scf.yield %15 : i512
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
                      affine.store %1, %arg53[%arg102 + %arg100 * 2 + %arg97 * 2, %arg103 + %arg101 * 128 + %arg98 * 256 + 32, %arg105 + %arg104 * 12 + %arg99 * 24] : memref<4x512x48xi512>
                    } {pipeline_ii = 1 : index}
                  }
                }
              }
            }
          } {merge}
          affine.for %arg100 = 0 to 1 {
            affine.for %arg101 = 0 to 2 {
              affine.for %arg102 = 0 to 2 {
                affine.for %arg103 = 0 to 16 {
                  affine.for %arg104 = 0 to 2 {
                    affine.for %arg105 = 0 to 12 {
                      %0 = arith.cmpi slt, %arg105, %c1 : index
                      %1 = scf.if %0 -> (i512) {
                        %2 = affine.load %arg58[0] : memref<1xi512, "stream1">
                        scf.yield %2 : i512
                      } else {
                        %2 = arith.cmpi slt, %arg105, %c2 : index
                        %3 = scf.if %2 -> (i512) {
                          %4 = affine.load %arg23[0] : memref<1xi512, "stream1">
                          scf.yield %4 : i512
                        } else {
                          %4 = arith.cmpi slt, %arg105, %c3 : index
                          %5 = scf.if %4 -> (i512) {
                            %6 = affine.load %arg86[0] : memref<1xi512, "stream1">
                            scf.yield %6 : i512
                          } else {
                            %6 = arith.cmpi slt, %arg105, %c4 : index
                            %7 = scf.if %6 -> (i512) {
                              %8 = affine.load %arg35[0] : memref<1xi512, "stream1">
                              scf.yield %8 : i512
                            } else {
                              %8 = arith.cmpi slt, %arg105, %c5 : index
                              %9 = scf.if %8 -> (i512) {
                                %10 = affine.load %arg38[0] : memref<1xi512, "stream1">
                                scf.yield %10 : i512
                              } else {
                                %10 = arith.cmpi slt, %arg105, %c6 : index
                                %11 = scf.if %10 -> (i512) {
                                  %12 = affine.load %arg6[0] : memref<1xi512, "stream1">
                                  scf.yield %12 : i512
                                } else {
                                  %12 = arith.cmpi slt, %arg105, %c7 : index
                                  %13 = scf.if %12 -> (i512) {
                                    %14 = affine.load %arg30[0] : memref<1xi512, "stream1">
                                    scf.yield %14 : i512
                                  } else {
                                    %14 = arith.cmpi slt, %arg105, %c8 : index
                                    %15 = scf.if %14 -> (i512) {
                                      %16 = affine.load %arg83[0] : memref<1xi512, "stream1">
                                      scf.yield %16 : i512
                                    } else {
                                      %16 = arith.cmpi slt, %arg105, %c9 : index
                                      %17 = scf.if %16 -> (i512) {
                                        %18 = affine.load %arg25[0] : memref<1xi512, "stream1">
                                        scf.yield %18 : i512
                                      } else {
                                        %18 = arith.cmpi slt, %arg105, %c10 : index
                                        %19 = scf.if %18 -> (i512) {
                                          %20 = affine.load %arg85[0] : memref<1xi512, "stream1">
                                          scf.yield %20 : i512
                                        } else {
                                          %20 = arith.cmpi slt, %arg105, %c11 : index
                                          %21 = scf.if %20 -> (i512) {
                                            %22 = affine.load %arg18[0] : memref<1xi512, "stream1">
                                            scf.yield %22 : i512
                                          } else {
                                            %22 = affine.load %arg4[0] : memref<1xi512, "stream1">
                                            scf.yield %22 : i512
                                          }
                                          scf.yield %21 : i512
                                        }
                                        scf.yield %19 : i512
                                      }
                                      scf.yield %17 : i512
                                    }
                                    scf.yield %15 : i512
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
                      affine.store %1, %arg53[%arg102 + %arg100 * 2 + %arg97 * 2, %arg103 + %arg101 * 128 + %arg98 * 256 + 48, %arg105 + %arg104 * 12 + %arg99 * 24] : memref<4x512x48xi512>
                    } {pipeline_ii = 1 : index}
                  }
                }
              }
            }
          } {merge}
          affine.for %arg100 = 0 to 1 {
            affine.for %arg101 = 0 to 2 {
              affine.for %arg102 = 0 to 2 {
                affine.for %arg103 = 0 to 16 {
                  affine.for %arg104 = 0 to 2 {
                    affine.for %arg105 = 0 to 12 {
                      %0 = arith.cmpi slt, %arg105, %c1 : index
                      %1 = scf.if %0 -> (i512) {
                        %2 = affine.load %arg47[0] : memref<1xi512, "stream1">
                        scf.yield %2 : i512
                      } else {
                        %2 = arith.cmpi slt, %arg105, %c2 : index
                        %3 = scf.if %2 -> (i512) {
                          %4 = affine.load %arg11[0] : memref<1xi512, "stream1">
                          scf.yield %4 : i512
                        } else {
                          %4 = arith.cmpi slt, %arg105, %c3 : index
                          %5 = scf.if %4 -> (i512) {
                            %6 = affine.load %arg66[0] : memref<1xi512, "stream1">
                            scf.yield %6 : i512
                          } else {
                            %6 = arith.cmpi slt, %arg105, %c4 : index
                            %7 = scf.if %6 -> (i512) {
                              %8 = affine.load %arg81[0] : memref<1xi512, "stream1">
                              scf.yield %8 : i512
                            } else {
                              %8 = arith.cmpi slt, %arg105, %c5 : index
                              %9 = scf.if %8 -> (i512) {
                                %10 = affine.load %arg0[0] : memref<1xi512, "stream1">
                                scf.yield %10 : i512
                              } else {
                                %10 = arith.cmpi slt, %arg105, %c6 : index
                                %11 = scf.if %10 -> (i512) {
                                  %12 = affine.load %arg20[0] : memref<1xi512, "stream1">
                                  scf.yield %12 : i512
                                } else {
                                  %12 = arith.cmpi slt, %arg105, %c7 : index
                                  %13 = scf.if %12 -> (i512) {
                                    %14 = affine.load %arg87[0] : memref<1xi512, "stream1">
                                    scf.yield %14 : i512
                                  } else {
                                    %14 = arith.cmpi slt, %arg105, %c8 : index
                                    %15 = scf.if %14 -> (i512) {
                                      %16 = affine.load %arg59[0] : memref<1xi512, "stream1">
                                      scf.yield %16 : i512
                                    } else {
                                      %16 = arith.cmpi slt, %arg105, %c9 : index
                                      %17 = scf.if %16 -> (i512) {
                                        %18 = affine.load %arg78[0] : memref<1xi512, "stream1">
                                        scf.yield %18 : i512
                                      } else {
                                        %18 = arith.cmpi slt, %arg105, %c10 : index
                                        %19 = scf.if %18 -> (i512) {
                                          %20 = affine.load %arg55[0] : memref<1xi512, "stream1">
                                          scf.yield %20 : i512
                                        } else {
                                          %20 = arith.cmpi slt, %arg105, %c11 : index
                                          %21 = scf.if %20 -> (i512) {
                                            %22 = affine.load %arg73[0] : memref<1xi512, "stream1">
                                            scf.yield %22 : i512
                                          } else {
                                            %22 = affine.load %arg67[0] : memref<1xi512, "stream1">
                                            scf.yield %22 : i512
                                          }
                                          scf.yield %21 : i512
                                        }
                                        scf.yield %19 : i512
                                      }
                                      scf.yield %17 : i512
                                    }
                                    scf.yield %15 : i512
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
                      affine.store %1, %arg53[%arg102 + %arg100 * 2 + %arg97 * 2, %arg103 + %arg101 * 128 + %arg98 * 256 + 64, %arg105 + %arg104 * 12 + %arg99 * 24] : memref<4x512x48xi512>
                    } {pipeline_ii = 1 : index}
                  }
                }
              }
            }
          } {merge}
          affine.for %arg100 = 0 to 1 {
            affine.for %arg101 = 0 to 2 {
              affine.for %arg102 = 0 to 2 {
                affine.for %arg103 = 0 to 16 {
                  affine.for %arg104 = 0 to 2 {
                    affine.for %arg105 = 0 to 12 {
                      %0 = arith.cmpi slt, %arg105, %c1 : index
                      %1 = scf.if %0 -> (i512) {
                        %2 = affine.load %arg43[0] : memref<1xi512, "stream1">
                        scf.yield %2 : i512
                      } else {
                        %2 = arith.cmpi slt, %arg105, %c2 : index
                        %3 = scf.if %2 -> (i512) {
                          %4 = affine.load %arg16[0] : memref<1xi512, "stream1">
                          scf.yield %4 : i512
                        } else {
                          %4 = arith.cmpi slt, %arg105, %c3 : index
                          %5 = scf.if %4 -> (i512) {
                            %6 = affine.load %arg79[0] : memref<1xi512, "stream1">
                            scf.yield %6 : i512
                          } else {
                            %6 = arith.cmpi slt, %arg105, %c4 : index
                            %7 = scf.if %6 -> (i512) {
                              %8 = affine.load %arg32[0] : memref<1xi512, "stream1">
                              scf.yield %8 : i512
                            } else {
                              %8 = arith.cmpi slt, %arg105, %c5 : index
                              %9 = scf.if %8 -> (i512) {
                                %10 = affine.load %arg71[0] : memref<1xi512, "stream1">
                                scf.yield %10 : i512
                              } else {
                                %10 = arith.cmpi slt, %arg105, %c6 : index
                                %11 = scf.if %10 -> (i512) {
                                  %12 = affine.load %arg82[0] : memref<1xi512, "stream1">
                                  scf.yield %12 : i512
                                } else {
                                  %12 = arith.cmpi slt, %arg105, %c7 : index
                                  %13 = scf.if %12 -> (i512) {
                                    %14 = affine.load %arg91[0] : memref<1xi512, "stream1">
                                    scf.yield %14 : i512
                                  } else {
                                    %14 = arith.cmpi slt, %arg105, %c8 : index
                                    %15 = scf.if %14 -> (i512) {
                                      %16 = affine.load %arg88[0] : memref<1xi512, "stream1">
                                      scf.yield %16 : i512
                                    } else {
                                      %16 = arith.cmpi slt, %arg105, %c9 : index
                                      %17 = scf.if %16 -> (i512) {
                                        %18 = affine.load %arg60[0] : memref<1xi512, "stream1">
                                        scf.yield %18 : i512
                                      } else {
                                        %18 = arith.cmpi slt, %arg105, %c10 : index
                                        %19 = scf.if %18 -> (i512) {
                                          %20 = affine.load %arg95[0] : memref<1xi512, "stream1">
                                          scf.yield %20 : i512
                                        } else {
                                          %20 = arith.cmpi slt, %arg105, %c11 : index
                                          %21 = scf.if %20 -> (i512) {
                                            %22 = affine.load %arg68[0] : memref<1xi512, "stream1">
                                            scf.yield %22 : i512
                                          } else {
                                            %22 = affine.load %arg41[0] : memref<1xi512, "stream1">
                                            scf.yield %22 : i512
                                          }
                                          scf.yield %21 : i512
                                        }
                                        scf.yield %19 : i512
                                      }
                                      scf.yield %17 : i512
                                    }
                                    scf.yield %15 : i512
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
                      affine.store %1, %arg53[%arg102 + %arg100 * 2 + %arg97 * 2, %arg103 + %arg101 * 128 + %arg98 * 256 + 80, %arg105 + %arg104 * 12 + %arg99 * 24] : memref<4x512x48xi512>
                    } {pipeline_ii = 1 : index}
                  }
                }
              }
            }
          } {merge}
          affine.for %arg100 = 0 to 1 {
            affine.for %arg101 = 0 to 2 {
              affine.for %arg102 = 0 to 2 {
                affine.for %arg103 = 0 to 16 {
                  affine.for %arg104 = 0 to 2 {
                    affine.for %arg105 = 0 to 12 {
                      %0 = arith.cmpi slt, %arg105, %c1 : index
                      %1 = scf.if %0 -> (i512) {
                        %2 = affine.load %arg37[0] : memref<1xi512, "stream1">
                        scf.yield %2 : i512
                      } else {
                        %2 = arith.cmpi slt, %arg105, %c2 : index
                        %3 = scf.if %2 -> (i512) {
                          %4 = affine.load %arg65[0] : memref<1xi512, "stream1">
                          scf.yield %4 : i512
                        } else {
                          %4 = arith.cmpi slt, %arg105, %c3 : index
                          %5 = scf.if %4 -> (i512) {
                            %6 = affine.load %arg1[0] : memref<1xi512, "stream1">
                            scf.yield %6 : i512
                          } else {
                            %6 = arith.cmpi slt, %arg105, %c4 : index
                            %7 = scf.if %6 -> (i512) {
                              %8 = affine.load %arg72[0] : memref<1xi512, "stream1">
                              scf.yield %8 : i512
                            } else {
                              %8 = arith.cmpi slt, %arg105, %c5 : index
                              %9 = scf.if %8 -> (i512) {
                                %10 = affine.load %arg36[0] : memref<1xi512, "stream1">
                                scf.yield %10 : i512
                              } else {
                                %10 = arith.cmpi slt, %arg105, %c6 : index
                                %11 = scf.if %10 -> (i512) {
                                  %12 = affine.load %arg44[0] : memref<1xi512, "stream1">
                                  scf.yield %12 : i512
                                } else {
                                  %12 = arith.cmpi slt, %arg105, %c7 : index
                                  %13 = scf.if %12 -> (i512) {
                                    %14 = affine.load %arg57[0] : memref<1xi512, "stream1">
                                    scf.yield %14 : i512
                                  } else {
                                    %14 = arith.cmpi slt, %arg105, %c8 : index
                                    %15 = scf.if %14 -> (i512) {
                                      %16 = affine.load %arg51[0] : memref<1xi512, "stream1">
                                      scf.yield %16 : i512
                                    } else {
                                      %16 = arith.cmpi slt, %arg105, %c9 : index
                                      %17 = scf.if %16 -> (i512) {
                                        %18 = affine.load %arg13[0] : memref<1xi512, "stream1">
                                        scf.yield %18 : i512
                                      } else {
                                        %18 = arith.cmpi slt, %arg105, %c10 : index
                                        %19 = scf.if %18 -> (i512) {
                                          %20 = affine.load %arg64[0] : memref<1xi512, "stream1">
                                          scf.yield %20 : i512
                                        } else {
                                          %20 = arith.cmpi slt, %arg105, %c11 : index
                                          %21 = scf.if %20 -> (i512) {
                                            %22 = affine.load %arg34[0] : memref<1xi512, "stream1">
                                            scf.yield %22 : i512
                                          } else {
                                            %22 = affine.load %arg48[0] : memref<1xi512, "stream1">
                                            scf.yield %22 : i512
                                          }
                                          scf.yield %21 : i512
                                        }
                                        scf.yield %19 : i512
                                      }
                                      scf.yield %17 : i512
                                    }
                                    scf.yield %15 : i512
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
                      affine.store %1, %arg53[%arg102 + %arg100 * 2 + %arg97 * 2, %arg103 + %arg101 * 128 + %arg98 * 256 + 96, %arg105 + %arg104 * 12 + %arg99 * 24] : memref<4x512x48xi512>
                    } {pipeline_ii = 1 : index}
                  }
                }
              }
            }
          } {merge}
          affine.for %arg100 = 0 to 1 {
            affine.for %arg101 = 0 to 2 {
              affine.for %arg102 = 0 to 2 {
                affine.for %arg103 = 0 to 16 {
                  affine.for %arg104 = 0 to 2 {
                    affine.for %arg105 = 0 to 12 {
                      %0 = arith.cmpi slt, %arg105, %c1 : index
                      %1 = scf.if %0 -> (i512) {
                        %2 = affine.load %arg8[0] : memref<1xi512, "stream1">
                        scf.yield %2 : i512
                      } else {
                        %2 = arith.cmpi slt, %arg105, %c2 : index
                        %3 = scf.if %2 -> (i512) {
                          %4 = affine.load %arg49[0] : memref<1xi512, "stream1">
                          scf.yield %4 : i512
                        } else {
                          %4 = arith.cmpi slt, %arg105, %c3 : index
                          %5 = scf.if %4 -> (i512) {
                            %6 = affine.load %arg24[0] : memref<1xi512, "stream1">
                            scf.yield %6 : i512
                          } else {
                            %6 = arith.cmpi slt, %arg105, %c4 : index
                            %7 = scf.if %6 -> (i512) {
                              %8 = affine.load %arg22[0] : memref<1xi512, "stream1">
                              scf.yield %8 : i512
                            } else {
                              %8 = arith.cmpi slt, %arg105, %c5 : index
                              %9 = scf.if %8 -> (i512) {
                                %10 = affine.load %arg74[0] : memref<1xi512, "stream1">
                                scf.yield %10 : i512
                              } else {
                                %10 = arith.cmpi slt, %arg105, %c6 : index
                                %11 = scf.if %10 -> (i512) {
                                  %12 = affine.load %arg96[0] : memref<1xi512, "stream1">
                                  scf.yield %12 : i512
                                } else {
                                  %12 = arith.cmpi slt, %arg105, %c7 : index
                                  %13 = scf.if %12 -> (i512) {
                                    %14 = affine.load %arg10[0] : memref<1xi512, "stream1">
                                    scf.yield %14 : i512
                                  } else {
                                    %14 = arith.cmpi slt, %arg105, %c8 : index
                                    %15 = scf.if %14 -> (i512) {
                                      %16 = affine.load %arg26[0] : memref<1xi512, "stream1">
                                      scf.yield %16 : i512
                                    } else {
                                      %16 = arith.cmpi slt, %arg105, %c9 : index
                                      %17 = scf.if %16 -> (i512) {
                                        %18 = affine.load %arg54[0] : memref<1xi512, "stream1">
                                        scf.yield %18 : i512
                                      } else {
                                        %18 = arith.cmpi slt, %arg105, %c10 : index
                                        %19 = scf.if %18 -> (i512) {
                                          %20 = affine.load %arg69[0] : memref<1xi512, "stream1">
                                          scf.yield %20 : i512
                                        } else {
                                          %20 = arith.cmpi slt, %arg105, %c11 : index
                                          %21 = scf.if %20 -> (i512) {
                                            %22 = affine.load %arg80[0] : memref<1xi512, "stream1">
                                            scf.yield %22 : i512
                                          } else {
                                            %22 = affine.load %arg12[0] : memref<1xi512, "stream1">
                                            scf.yield %22 : i512
                                          }
                                          scf.yield %21 : i512
                                        }
                                        scf.yield %19 : i512
                                      }
                                      scf.yield %17 : i512
                                    }
                                    scf.yield %15 : i512
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
                      affine.store %1, %arg53[%arg102 + %arg100 * 2 + %arg97 * 2, %arg103 + %arg101 * 128 + %arg98 * 256 + 112, %arg105 + %arg104 * 12 + %arg99 * 24] : memref<4x512x48xi512>
                    } {pipeline_ii = 1 : index}
                  }
                }
              }
            }
          } {merge}
        }
      }
    }
    return
  }
  func.func @store0_top(%arg0: memref<1xi512, "stream1">, %arg1: memref<1xi512, "stream1">, %arg2: memref<1xi512, "stream1">, %arg3: memref<1xi512, "stream1">, %arg4: memref<1xi512, "stream1">, %arg5: memref<1xi512, "stream1">, %arg6: memref<1xi512, "stream1">, %arg7: memref<1xi512, "stream1">, %arg8: memref<1xi512, "stream1">, %arg9: memref<1xi512, "stream1">, %arg10: memref<1xi512, "stream1">, %arg11: memref<1xi512, "stream1">, %arg12: memref<1xi512, "stream1">, %arg13: memref<1xi512, "stream1">, %arg14: memref<1xi512, "stream1">, %arg15: memref<1xi512, "stream1">, %arg16: memref<1xi512, "stream1">, %arg17: memref<1xi512, "stream1">, %arg18: memref<1xi512, "stream1">, %arg19: memref<1xi512, "stream1">, %arg20: memref<1xi512, "stream1">, %arg21: memref<1xi512, "stream1">, %arg22: memref<1xi512, "stream1">, %arg23: memref<1xi512, "stream1">, %arg24: memref<1xi512, "stream1">, %arg25: memref<1xi512, "stream1">, %arg26: memref<1xi512, "stream1">, %arg27: memref<1xi512, "stream1">, %arg28: memref<1xi512, "stream1">, %arg29: memref<1xi512, "stream1">, %arg30: memref<1xi512, "stream1">, %arg31: memref<1xi512, "stream1">, %arg32: memref<1xi512, "stream1">, %arg33: memref<1xi512, "stream1">, %arg34: memref<1xi512, "stream1">, %arg35: memref<1xi512, "stream1">, %arg36: memref<1xi512, "stream1">, %arg37: memref<1xi512, "stream1">, %arg38: memref<1xi512, "stream1">, %arg39: memref<1xi512, "stream1">, %arg40: memref<1xi512, "stream1">, %arg41: memref<1xi512, "stream1">, %arg42: memref<1xi512, "stream1">, %arg43: memref<1xi512, "stream1">, %arg44: memref<1xi512, "stream1">, %arg45: memref<1xi512, "stream1">, %arg46: memref<1xi512, "stream1">, %arg47: memref<1xi512, "stream1">, %arg48: memref<1xi512, "stream1">, %arg49: memref<1xi512, "stream1">, %arg50: memref<1xi512, "stream1">, %arg51: memref<1xi512, "stream1">, %arg52: memref<1xi512, "stream1">, %arg53: memref<4x512x48xi512>, %arg54: memref<1xi512, "stream1">, %arg55: memref<1xi512, "stream1">, %arg56: memref<1xi512, "stream1">, %arg57: memref<1xi512, "stream1">, %arg58: memref<1xi512, "stream1">, %arg59: memref<1xi512, "stream1">, %arg60: memref<1xi512, "stream1">, %arg61: memref<1xi512, "stream1">, %arg62: memref<1xi512, "stream1">, %arg63: memref<1xi512, "stream1">, %arg64: memref<1xi512, "stream1">, %arg65: memref<1xi512, "stream1">, %arg66: memref<1xi512, "stream1">, %arg67: memref<1xi512, "stream1">, %arg68: memref<1xi512, "stream1">, %arg69: memref<1xi512, "stream1">, %arg70: memref<1xi512, "stream1">, %arg71: memref<1xi512, "stream1">, %arg72: memref<1xi512, "stream1">, %arg73: memref<1xi512, "stream1">, %arg74: memref<1xi512, "stream1">, %arg75: memref<1xi512, "stream1">, %arg76: memref<1xi512, "stream1">, %arg77: memref<1xi512, "stream1">, %arg78: memref<1xi512, "stream1">, %arg79: memref<1xi512, "stream1">, %arg80: memref<1xi512, "stream1">, %arg81: memref<1xi512, "stream1">, %arg82: memref<1xi512, "stream1">, %arg83: memref<1xi512, "stream1">, %arg84: memref<1xi512, "stream1">, %arg85: memref<1xi512, "stream1">, %arg86: memref<1xi512, "stream1">, %arg87: memref<1xi512, "stream1">, %arg88: memref<1xi512, "stream1">, %arg89: memref<1xi512, "stream1">, %arg90: memref<1xi512, "stream1">, %arg91: memref<1xi512, "stream1">, %arg92: memref<1xi512, "stream1">, %arg93: memref<1xi512, "stream1">, %arg94: memref<1xi512, "stream1">, %arg95: memref<1xi512, "stream1">, %arg96: memref<1xi512, "stream1">) attributes {adf.pl, inline = false} {
    call @store0(%arg0, %arg1, %arg2, %arg3, %arg4, %arg5, %arg6, %arg7, %arg8, %arg9, %arg10, %arg11, %arg12, %arg13, %arg14, %arg15, %arg16, %arg17, %arg18, %arg19, %arg20, %arg21, %arg22, %arg23, %arg24, %arg25, %arg26, %arg27, %arg28, %arg29, %arg30, %arg31, %arg32, %arg33, %arg34, %arg35, %arg36, %arg37, %arg38, %arg39, %arg40, %arg41, %arg42, %arg43, %arg44, %arg45, %arg46, %arg47, %arg48, %arg49, %arg50, %arg51, %arg52, %arg53, %arg54, %arg55, %arg56, %arg57, %arg58, %arg59, %arg60, %arg61, %arg62, %arg63, %arg64, %arg65, %arg66, %arg67, %arg68, %arg69, %arg70, %arg71, %arg72, %arg73, %arg74, %arg75, %arg76, %arg77, %arg78, %arg79, %arg80, %arg81, %arg82, %arg83, %arg84, %arg85, %arg86, %arg87, %arg88, %arg89, %arg90, %arg91, %arg92, %arg93, %arg94, %arg95, %arg96) {template = 0 : index} : (memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<4x512x48xi512>, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">) -> ()
    return
  }
  func.func @load0(%arg0: memref<4x1024x256xi512>, %arg1: memref<1xi512, "stream2">, %arg2: memref<1xi512, "stream2">) attributes {adf.pl, inline = false, load, mem_idx = [0 : i32], mem_type = [i32], template} {
    %c2 = arith.constant 2 : index
    affine.for %arg3 = 0 to 2 {
      affine.for %arg4 = 0 to 2 {
        affine.for %arg5 = 0 to 2 {
          affine.for %arg6 = 0 to 8 {
            affine.for %arg7 = 0 to 8 {
              affine.for %arg8 = 0 to 1 {
                affine.for %arg9 = 0 to 8 {
                  affine.for %arg10 = 0 to 2 {
                    affine.for %arg11 = 0 to 16 {
                      affine.for %arg12 = 0 to 8 {
                        affine.for %arg13 = 0 to 4 {
                          %0 = affine.load %arg0[%arg10 + %arg8 * 2 + %arg3 * 2, %arg11 + %arg9 * 16 + %arg6 * 128, %arg13 + %arg12 * 4 + %arg7 * 32] : memref<4x1024x256xi512>
                          %1 = arith.cmpi slt, %arg13, %c2 : index
                          scf.if %1 {
                            affine.store %0, %arg2[0] : memref<1xi512, "stream2">
                          } else {
                            affine.store %0, %arg1[0] : memref<1xi512, "stream2">
                          }
                        } {pipeline_ii = 1 : index}
                      }
                    }
                  }
                }
              } {merge}
            } {Array_Partition, reduction}
          } {reduction}
        }
      }
    }
    return
  }
  func.func @load0_top(%arg0: memref<4x1024x256xi512>, %arg1: memref<1xi512, "stream2">, %arg2: memref<1xi512, "stream2">) attributes {adf.pl, inline = false} {
    call @load0(%arg0, %arg1, %arg2) {template = 0 : index} : (memref<4x1024x256xi512>, memref<1xi512, "stream2">, memref<1xi512, "stream2">) -> ()
    return
  }
  func.func @load0_1(%arg0: memref<1xi512, "stream2">, %arg1: memref<1xi128, "stream">) attributes {adf.pl, inline = false, load, template} {
    affine.for %arg2 = 0 to 2 {
      affine.for %arg3 = 0 to 2 {
        affine.for %arg4 = 0 to 2 {
          affine.for %arg5 = 0 to 8 {
            affine.for %arg6 = 0 to 8 {
              affine.for %arg7 = 0 to 1 {
                affine.for %arg8 = 0 to 8 {
                  affine.for %arg9 = 0 to 2 {
                    affine.for %arg10 = 0 to 16 {
                      affine.for %arg11 = 0 to 8 {
                        affine.for %arg12 = 0 to 2 {
                          %0 = affine.load %arg0[0] : memref<1xi512, "stream2">
                          affine.for %arg13 = 0 to 4 {
                            %1 = affine.apply #map(%arg13)
                            %2 = affine.apply #map1(%arg13)
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
          }
        }
      }
    }
    return
  }
  func.func @load0_1_top(%arg0: memref<1xi512, "stream2">, %arg1: memref<1xi128, "stream">, %arg2: memref<1xi512, "stream2">, %arg3: memref<1xi128, "stream">) attributes {adf.pl, inline = false} {
    call @load0_1(%arg0, %arg1) {template = 0 : index} : (memref<1xi512, "stream2">, memref<1xi128, "stream">) -> ()
    call @load0_1(%arg2, %arg3) {template = 1 : index} : (memref<1xi512, "stream2">, memref<1xi128, "stream">) -> ()
    return
  }
  func.func @send3_0(%arg0: memref<1xi128, "stream">, %arg1: memref<2x128x64xi128, 1>, %arg2: i1) attributes {adf.pl, inline = false} {
    scf.if %arg2 {
      affine.for %arg3 = 0 to 1 {
        affine.for %arg4 = 0 to 8 {
          affine.for %arg5 = 0 to 2 {
            affine.for %arg6 = 0 to 16 {
              affine.for %arg7 = 0 to 8 {
                affine.for %arg8 = 0 to 8 {
                  %0 = affine.load %arg0[0] : memref<1xi128, "stream">
                  affine.store %0, %arg1[%arg5 + %arg3 * 2, %arg6 + %arg4 * 16, %arg8 + %arg7 * 8] : memref<2x128x64xi128, 1>
                } {pipeline_ii = 1 : index}
              }
            }
          }
        }
      }
    }
    return
  }
  func.func @send3_1(%arg0: memref<2x128x64xi128, 1>, %arg1: memref<1xi128, "plio">, %arg2: i1) attributes {adf.pl, inline = false} {
    scf.if %arg2 {
      affine.for %arg3 = 0 to 1 {
        affine.for %arg4 = 0 to 2 {
          affine.for %arg5 = 0 to 2 {
            affine.for %arg6 = 0 to 8 {
              affine.for %arg7 = 0 to 8 {
                affine.for %arg8 = 0 to 2 {
                  affine.for %arg9 = 0 to 16 {
                    affine.for %arg10 = 0 to 8 {
                      %0 = affine.load %arg0[%arg8 + %arg3 * 2, %arg9 + %arg6 * 16, %arg10 + %arg7 * 8] : memref<2x128x64xi128, 1>
                      affine.store %0, %arg1[0] : memref<1xi128, "plio">
                    } {pipeline_ii = 1 : index}
                  }
                }
              }
            }
          }
        }
      }
    }
    return
  }
  func.func @send3(%arg0: memref<1xi128, "stream">, %arg1: memref<1xi128, "plio">) attributes {adf.pl, inline = false, send, template} {
    %c256 = arith.constant 256 : index
    %c128 = arith.constant 128 : index
    %c64 = arith.constant 64 : index
    %true = arith.constant true
    %c8 = arith.constant 8 : index
    %c0 = arith.constant 0 : index
    %c2 = arith.constant 2 : index
    %alloc = memref.alloc() {buffer_type = "uram_t2p"} : memref<2x128x64xi128, 1>
    %alloc_0 = memref.alloc() {buffer_type = "uram_t2p"} : memref<2x128x64xi128, 1>
    affine.for %arg2 = 0 to 2 {
      affine.for %arg3 = 0 to 2 {
        affine.for %arg4 = 0 to 2 {
          affine.for %arg5 = 0 to 8 {
            affine.for %arg6 = 0 to 8 {
              %0 = arith.muli %arg5, %c8 : index
              %1 = arith.addi %arg6, %0 : index
              %2 = arith.muli %arg4, %c64 : index
              %3 = arith.addi %1, %2 : index
              %4 = arith.muli %arg3, %c128 : index
              %5 = arith.addi %3, %4 : index
              %6 = arith.muli %arg2, %c256 : index
              %7 = arith.addi %5, %6 : index
              %8 = arith.remsi %7, %c2 : index
              %9 = arith.cmpi eq, %8, %c0 : index
              %10 = arith.cmpi ne, %7, %c0 : index
              scf.if %9 {
                func.call @send3_0(%arg0, %alloc, %true) : (memref<1xi128, "stream">, memref<2x128x64xi128, 1>, i1) -> ()
                func.call @send3_1(%alloc_0, %arg1, %10) : (memref<2x128x64xi128, 1>, memref<1xi128, "plio">, i1) -> ()
              } else {
                func.call @send3_0(%arg0, %alloc_0, %true) : (memref<1xi128, "stream">, memref<2x128x64xi128, 1>, i1) -> ()
                func.call @send3_1(%alloc, %arg1, %10) : (memref<2x128x64xi128, 1>, memref<1xi128, "plio">, i1) -> ()
              }
            } {Array_Partition, reduction}
          } {reduction}
        }
      }
    }
    call @send3_1(%alloc_0, %arg1, %true) : (memref<2x128x64xi128, 1>, memref<1xi128, "plio">, i1) -> ()
    return
  }
  func.func @send3_top(%arg0: memref<1xi128, "stream">, %arg1: memref<1xi128, "plio">) attributes {adf.pl, inline = false} {
    call @send3(%arg0, %arg1) {template = 0 : index} : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    return
  }
  func.func @load2(%arg0: memref<1xi512, "stream1">, %arg1: memref<1xi512, "stream1">, %arg2: memref<1xi512, "stream1">, %arg3: memref<1xi512, "stream1">, %arg4: memref<1xi512, "stream1">, %arg5: memref<1xi512, "stream1">, %arg6: memref<1xi512, "stream1">, %arg7: memref<1xi512, "stream1">, %arg8: memref<1xi512, "stream1">, %arg9: memref<1xi512, "stream1">, %arg10: memref<1xi512, "stream1">, %arg11: memref<1xi512, "stream1">, %arg12: memref<1xi512, "stream1">, %arg13: memref<4096x48xi512>, %arg14: memref<1xi512, "stream1">, %arg15: memref<1xi512, "stream1">, %arg16: memref<1xi512, "stream1">, %arg17: memref<1xi512, "stream1">, %arg18: memref<1xi512, "stream1">, %arg19: memref<1xi512, "stream1">, %arg20: memref<1xi512, "stream1">, %arg21: memref<1xi512, "stream1">, %arg22: memref<1xi512, "stream1">, %arg23: memref<1xi512, "stream1">, %arg24: memref<1xi512, "stream1">) attributes {adf.pl, inline = false, load, mem_idx = [13 : i32], mem_type = [i32], template} {
    %c11 = arith.constant 11 : index
    %c10 = arith.constant 10 : index
    %c9 = arith.constant 9 : index
    %c8 = arith.constant 8 : index
    %c7 = arith.constant 7 : index
    %c6 = arith.constant 6 : index
    %c5 = arith.constant 5 : index
    %c4 = arith.constant 4 : index
    %c3 = arith.constant 3 : index
    %c2 = arith.constant 2 : index
    %c1 = arith.constant 1 : index
    affine.for %arg25 = 0 to 2 {
      affine.for %arg26 = 0 to 2 {
        affine.for %arg27 = 0 to 2 {
          affine.for %arg28 = 0 to 8 {
            affine.for %arg29 = 0 to 8 {
              affine.for %arg30 = 0 to 8 {
                affine.for %arg31 = 0 to 32 {
                  affine.for %arg32 = 0 to 2 {
                    affine.for %arg33 = 0 to 12 {
                      %0 = affine.load %arg13[%arg31 + %arg30 * 64 + %arg29 * 512, %arg33 + %arg32 * 12 + %arg27 * 24] : memref<4096x48xi512>
                      %1 = arith.cmpi slt, %arg33, %c1 : index
                      scf.if %1 {
                        affine.store %0, %arg9[0] : memref<1xi512, "stream1">
                      } else {
                        %2 = arith.cmpi slt, %arg33, %c2 : index
                        scf.if %2 {
                          affine.store %0, %arg0[0] : memref<1xi512, "stream1">
                        } else {
                          %3 = arith.cmpi slt, %arg33, %c3 : index
                          scf.if %3 {
                            affine.store %0, %arg18[0] : memref<1xi512, "stream1">
                          } else {
                            %4 = arith.cmpi slt, %arg33, %c4 : index
                            scf.if %4 {
                              affine.store %0, %arg8[0] : memref<1xi512, "stream1">
                            } else {
                              %5 = arith.cmpi slt, %arg33, %c5 : index
                              scf.if %5 {
                                affine.store %0, %arg6[0] : memref<1xi512, "stream1">
                              } else {
                                %6 = arith.cmpi slt, %arg33, %c6 : index
                                scf.if %6 {
                                  affine.store %0, %arg19[0] : memref<1xi512, "stream1">
                                } else {
                                  %7 = arith.cmpi slt, %arg33, %c7 : index
                                  scf.if %7 {
                                    affine.store %0, %arg10[0] : memref<1xi512, "stream1">
                                  } else {
                                    %8 = arith.cmpi slt, %arg33, %c8 : index
                                    scf.if %8 {
                                      affine.store %0, %arg1[0] : memref<1xi512, "stream1">
                                    } else {
                                      %9 = arith.cmpi slt, %arg33, %c9 : index
                                      scf.if %9 {
                                        affine.store %0, %arg14[0] : memref<1xi512, "stream1">
                                      } else {
                                        %10 = arith.cmpi slt, %arg33, %c10 : index
                                        scf.if %10 {
                                          affine.store %0, %arg24[0] : memref<1xi512, "stream1">
                                        } else {
                                          %11 = arith.cmpi slt, %arg33, %c11 : index
                                          scf.if %11 {
                                            affine.store %0, %arg21[0] : memref<1xi512, "stream1">
                                          } else {
                                            affine.store %0, %arg16[0] : memref<1xi512, "stream1">
                                          }
                                        }
                                      }
                                    }
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
              affine.for %arg30 = 0 to 8 {
                affine.for %arg31 = 0 to 32 {
                  affine.for %arg32 = 0 to 2 {
                    affine.for %arg33 = 0 to 12 {
                      %0 = affine.load %arg13[%arg31 + %arg30 * 64 + %arg29 * 512 + 32, %arg33 + %arg32 * 12 + %arg27 * 24] : memref<4096x48xi512>
                      %1 = arith.cmpi slt, %arg33, %c1 : index
                      scf.if %1 {
                        affine.store %0, %arg5[0] : memref<1xi512, "stream1">
                      } else {
                        %2 = arith.cmpi slt, %arg33, %c2 : index
                        scf.if %2 {
                          affine.store %0, %arg20[0] : memref<1xi512, "stream1">
                        } else {
                          %3 = arith.cmpi slt, %arg33, %c3 : index
                          scf.if %3 {
                            affine.store %0, %arg23[0] : memref<1xi512, "stream1">
                          } else {
                            %4 = arith.cmpi slt, %arg33, %c4 : index
                            scf.if %4 {
                              affine.store %0, %arg2[0] : memref<1xi512, "stream1">
                            } else {
                              %5 = arith.cmpi slt, %arg33, %c5 : index
                              scf.if %5 {
                                affine.store %0, %arg7[0] : memref<1xi512, "stream1">
                              } else {
                                %6 = arith.cmpi slt, %arg33, %c6 : index
                                scf.if %6 {
                                  affine.store %0, %arg3[0] : memref<1xi512, "stream1">
                                } else {
                                  %7 = arith.cmpi slt, %arg33, %c7 : index
                                  scf.if %7 {
                                    affine.store %0, %arg12[0] : memref<1xi512, "stream1">
                                  } else {
                                    %8 = arith.cmpi slt, %arg33, %c8 : index
                                    scf.if %8 {
                                      affine.store %0, %arg22[0] : memref<1xi512, "stream1">
                                    } else {
                                      %9 = arith.cmpi slt, %arg33, %c9 : index
                                      scf.if %9 {
                                        affine.store %0, %arg11[0] : memref<1xi512, "stream1">
                                      } else {
                                        %10 = arith.cmpi slt, %arg33, %c10 : index
                                        scf.if %10 {
                                          affine.store %0, %arg17[0] : memref<1xi512, "stream1">
                                        } else {
                                          %11 = arith.cmpi slt, %arg33, %c11 : index
                                          scf.if %11 {
                                            affine.store %0, %arg15[0] : memref<1xi512, "stream1">
                                          } else {
                                            affine.store %0, %arg4[0] : memref<1xi512, "stream1">
                                          }
                                        }
                                      }
                                    }
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
          } {reduction}
        }
      }
    }
    return
  }
  func.func @load2_top(%arg0: memref<1xi512, "stream1">, %arg1: memref<1xi512, "stream1">, %arg2: memref<1xi512, "stream1">, %arg3: memref<1xi512, "stream1">, %arg4: memref<1xi512, "stream1">, %arg5: memref<1xi512, "stream1">, %arg6: memref<1xi512, "stream1">, %arg7: memref<1xi512, "stream1">, %arg8: memref<1xi512, "stream1">, %arg9: memref<1xi512, "stream1">, %arg10: memref<1xi512, "stream1">, %arg11: memref<1xi512, "stream1">, %arg12: memref<1xi512, "stream1">, %arg13: memref<4096x48xi512>, %arg14: memref<1xi512, "stream1">, %arg15: memref<1xi512, "stream1">, %arg16: memref<1xi512, "stream1">, %arg17: memref<1xi512, "stream1">, %arg18: memref<1xi512, "stream1">, %arg19: memref<1xi512, "stream1">, %arg20: memref<1xi512, "stream1">, %arg21: memref<1xi512, "stream1">, %arg22: memref<1xi512, "stream1">, %arg23: memref<1xi512, "stream1">, %arg24: memref<1xi512, "stream1">) attributes {adf.pl, inline = false} {
    call @load2(%arg0, %arg1, %arg2, %arg3, %arg4, %arg5, %arg6, %arg7, %arg8, %arg9, %arg10, %arg11, %arg12, %arg13, %arg14, %arg15, %arg16, %arg17, %arg18, %arg19, %arg20, %arg21, %arg22, %arg23, %arg24) {template = 0 : index} : (memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<4096x48xi512>, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">) -> ()
    return
  }
  func.func @load2_23(%arg0: memref<1xi512, "stream1">, %arg1: memref<1xi128, "stream">) attributes {adf.pl, inline = false, load, template} {
    affine.for %arg2 = 0 to 2 {
      affine.for %arg3 = 0 to 2 {
        affine.for %arg4 = 0 to 2 {
          affine.for %arg5 = 0 to 8 {
            affine.for %arg6 = 0 to 8 {
              affine.for %arg7 = 0 to 8 {
                affine.for %arg8 = 0 to 32 {
                  affine.for %arg9 = 0 to 2 {
                    affine.for %arg10 = 0 to 1 {
                      %0 = affine.load %arg0[0] : memref<1xi512, "stream1">
                      affine.for %arg11 = 0 to 4 {
                        %1 = affine.apply #map(%arg11)
                        %2 = affine.apply #map1(%arg11)
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
      }
    }
    return
  }
  func.func @load2_23_top(%arg0: memref<1xi512, "stream1">, %arg1: memref<1xi128, "stream">, %arg2: memref<1xi512, "stream1">, %arg3: memref<1xi128, "stream">, %arg4: memref<1xi512, "stream1">, %arg5: memref<1xi128, "stream">, %arg6: memref<1xi512, "stream1">, %arg7: memref<1xi128, "stream">, %arg8: memref<1xi512, "stream1">, %arg9: memref<1xi128, "stream">, %arg10: memref<1xi512, "stream1">, %arg11: memref<1xi128, "stream">, %arg12: memref<1xi512, "stream1">, %arg13: memref<1xi128, "stream">, %arg14: memref<1xi512, "stream1">, %arg15: memref<1xi128, "stream">, %arg16: memref<1xi512, "stream1">, %arg17: memref<1xi128, "stream">, %arg18: memref<1xi512, "stream1">, %arg19: memref<1xi128, "stream">, %arg20: memref<1xi512, "stream1">, %arg21: memref<1xi128, "stream">, %arg22: memref<1xi512, "stream1">, %arg23: memref<1xi128, "stream">, %arg24: memref<1xi512, "stream1">, %arg25: memref<1xi128, "stream">, %arg26: memref<1xi512, "stream1">, %arg27: memref<1xi128, "stream">, %arg28: memref<1xi512, "stream1">, %arg29: memref<1xi128, "stream">, %arg30: memref<1xi512, "stream1">, %arg31: memref<1xi128, "stream">, %arg32: memref<1xi512, "stream1">, %arg33: memref<1xi128, "stream">, %arg34: memref<1xi512, "stream1">, %arg35: memref<1xi128, "stream">, %arg36: memref<1xi512, "stream1">, %arg37: memref<1xi128, "stream">, %arg38: memref<1xi512, "stream1">, %arg39: memref<1xi128, "stream">, %arg40: memref<1xi512, "stream1">, %arg41: memref<1xi128, "stream">, %arg42: memref<1xi512, "stream1">, %arg43: memref<1xi128, "stream">, %arg44: memref<1xi512, "stream1">, %arg45: memref<1xi128, "stream">, %arg46: memref<1xi512, "stream1">, %arg47: memref<1xi128, "stream">) attributes {adf.pl, inline = false} {
    call @load2_23(%arg0, %arg1) {template = 0 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load2_23(%arg2, %arg3) {template = 1 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load2_23(%arg4, %arg5) {template = 2 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load2_23(%arg6, %arg7) {template = 3 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load2_23(%arg8, %arg9) {template = 4 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load2_23(%arg10, %arg11) {template = 5 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load2_23(%arg12, %arg13) {template = 6 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load2_23(%arg14, %arg15) {template = 7 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load2_23(%arg16, %arg17) {template = 8 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load2_23(%arg18, %arg19) {template = 9 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load2_23(%arg20, %arg21) {template = 10 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load2_23(%arg22, %arg23) {template = 11 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load2_23(%arg24, %arg25) {template = 12 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load2_23(%arg26, %arg27) {template = 13 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load2_23(%arg28, %arg29) {template = 14 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load2_23(%arg30, %arg31) {template = 15 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load2_23(%arg32, %arg33) {template = 16 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load2_23(%arg34, %arg35) {template = 17 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load2_23(%arg36, %arg37) {template = 18 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load2_23(%arg38, %arg39) {template = 19 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load2_23(%arg40, %arg41) {template = 20 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load2_23(%arg42, %arg43) {template = 21 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load2_23(%arg44, %arg45) {template = 22 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load2_23(%arg46, %arg47) {template = 23 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    return
  }
  func.func @send0_0(%arg0: memref<1xi128, "stream">, %arg1: memref<2x128x64xi128, 1>, %arg2: i1) attributes {adf.pl, inline = false} {
    scf.if %arg2 {
      affine.for %arg3 = 0 to 1 {
        affine.for %arg4 = 0 to 8 {
          affine.for %arg5 = 0 to 2 {
            affine.for %arg6 = 0 to 16 {
              affine.for %arg7 = 0 to 8 {
                affine.for %arg8 = 0 to 8 {
                  %0 = affine.load %arg0[0] : memref<1xi128, "stream">
                  affine.store %0, %arg1[%arg5 + %arg3 * 2, %arg6 + %arg4 * 16, %arg8 + %arg7 * 8] : memref<2x128x64xi128, 1>
                } {pipeline_ii = 1 : index}
              }
            }
          }
        }
      }
    }
    return
  }
  func.func @send0_1(%arg0: memref<2x128x64xi128, 1>, %arg1: memref<1xi128, "plio">, %arg2: i1) attributes {adf.pl, inline = false} {
    scf.if %arg2 {
      affine.for %arg3 = 0 to 1 {
        affine.for %arg4 = 0 to 2 {
          affine.for %arg5 = 0 to 2 {
            affine.for %arg6 = 0 to 8 {
              affine.for %arg7 = 0 to 8 {
                affine.for %arg8 = 0 to 2 {
                  affine.for %arg9 = 0 to 16 {
                    affine.for %arg10 = 0 to 8 {
                      %0 = affine.load %arg0[%arg8 + %arg3 * 2, %arg9 + %arg6 * 16, %arg10 + %arg7 * 8] : memref<2x128x64xi128, 1>
                      affine.store %0, %arg1[0] : memref<1xi128, "plio">
                    } {pipeline_ii = 1 : index}
                  }
                }
              }
            }
          }
        }
      }
    }
    return
  }
  func.func @send0(%arg0: memref<1xi128, "plio">, %arg1: memref<1xi128, "stream">) attributes {adf.pl, inline = false, send, template} {
    %c256 = arith.constant 256 : index
    %c128 = arith.constant 128 : index
    %c64 = arith.constant 64 : index
    %true = arith.constant true
    %c8 = arith.constant 8 : index
    %c0 = arith.constant 0 : index
    %c2 = arith.constant 2 : index
    %alloc = memref.alloc() {buffer_type = "uram_t2p"} : memref<2x128x64xi128, 1>
    %alloc_0 = memref.alloc() {buffer_type = "uram_t2p"} : memref<2x128x64xi128, 1>
    affine.for %arg2 = 0 to 2 {
      affine.for %arg3 = 0 to 2 {
        affine.for %arg4 = 0 to 2 {
          affine.for %arg5 = 0 to 8 {
            affine.for %arg6 = 0 to 8 {
              %0 = arith.muli %arg5, %c8 : index
              %1 = arith.addi %arg6, %0 : index
              %2 = arith.muli %arg4, %c64 : index
              %3 = arith.addi %1, %2 : index
              %4 = arith.muli %arg3, %c128 : index
              %5 = arith.addi %3, %4 : index
              %6 = arith.muli %arg2, %c256 : index
              %7 = arith.addi %5, %6 : index
              %8 = arith.remsi %7, %c2 : index
              %9 = arith.cmpi eq, %8, %c0 : index
              %10 = arith.cmpi ne, %7, %c0 : index
              scf.if %9 {
                func.call @send0_0(%arg1, %alloc, %true) : (memref<1xi128, "stream">, memref<2x128x64xi128, 1>, i1) -> ()
                func.call @send0_1(%alloc_0, %arg0, %10) : (memref<2x128x64xi128, 1>, memref<1xi128, "plio">, i1) -> ()
              } else {
                func.call @send0_0(%arg1, %alloc_0, %true) : (memref<1xi128, "stream">, memref<2x128x64xi128, 1>, i1) -> ()
                func.call @send0_1(%alloc, %arg0, %10) : (memref<2x128x64xi128, 1>, memref<1xi128, "plio">, i1) -> ()
              }
            } {Array_Partition, reduction}
          } {reduction}
        }
      }
    }
    call @send0_1(%alloc_0, %arg0, %true) : (memref<2x128x64xi128, 1>, memref<1xi128, "plio">, i1) -> ()
    return
  }
  func.func @send0_top(%arg0: memref<1xi128, "plio">, %arg1: memref<1xi128, "stream">) attributes {adf.pl, inline = false} {
    call @send0(%arg0, %arg1) {template = 0 : index} : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    return
  }
  func.func @load1(%arg0: memref<1xi512, "stream1">, %arg1: memref<1xi512, "stream1">, %arg2: memref<1xi512, "stream1">, %arg3: memref<1xi512, "stream1">, %arg4: memref<1xi512, "stream1">, %arg5: memref<1xi512, "stream1">, %arg6: memref<1xi512, "stream1">, %arg7: memref<1xi512, "stream1">, %arg8: memref<1024x32xi512>) attributes {adf.pl, inline = false, load, mem_idx = [8 : i32], mem_type = [i32], template} {
    %c7 = arith.constant 7 : index
    %c6 = arith.constant 6 : index
    %c5 = arith.constant 5 : index
    %c4 = arith.constant 4 : index
    %c3 = arith.constant 3 : index
    %c2 = arith.constant 2 : index
    %c1 = arith.constant 1 : index
    affine.for %arg9 = 0 to 2 {
      affine.for %arg10 = 0 to 2 {
        affine.for %arg11 = 0 to 2 {
          affine.for %arg12 = 0 to 8 {
            affine.for %arg13 = 0 to 8 {
              affine.for %arg14 = 0 to 8 {
                affine.for %arg15 = 0 to 16 {
                  affine.for %arg16 = 0 to 2 {
                    affine.for %arg17 = 0 to 8 {
                      %0 = affine.load %arg8[%arg15 + %arg14 * 16 + %arg12 * 128, %arg17 + %arg16 * 8 + %arg10 * 16] : memref<1024x32xi512>
                      %1 = arith.cmpi slt, %arg17, %c1 : index
                      scf.if %1 {
                        affine.store %0, %arg6[0] : memref<1xi512, "stream1">
                      } else {
                        %2 = arith.cmpi slt, %arg17, %c2 : index
                        scf.if %2 {
                          affine.store %0, %arg4[0] : memref<1xi512, "stream1">
                        } else {
                          %3 = arith.cmpi slt, %arg17, %c3 : index
                          scf.if %3 {
                            affine.store %0, %arg7[0] : memref<1xi512, "stream1">
                          } else {
                            %4 = arith.cmpi slt, %arg17, %c4 : index
                            scf.if %4 {
                              affine.store %0, %arg5[0] : memref<1xi512, "stream1">
                            } else {
                              %5 = arith.cmpi slt, %arg17, %c5 : index
                              scf.if %5 {
                                affine.store %0, %arg2[0] : memref<1xi512, "stream1">
                              } else {
                                %6 = arith.cmpi slt, %arg17, %c6 : index
                                scf.if %6 {
                                  affine.store %0, %arg3[0] : memref<1xi512, "stream1">
                                } else {
                                  %7 = arith.cmpi slt, %arg17, %c7 : index
                                  scf.if %7 {
                                    affine.store %0, %arg0[0] : memref<1xi512, "stream1">
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
            } {Array_Partition, reduction}
          } {reduction}
        }
      }
    }
    return
  }
  func.func @load1_top(%arg0: memref<1xi512, "stream1">, %arg1: memref<1xi512, "stream1">, %arg2: memref<1xi512, "stream1">, %arg3: memref<1xi512, "stream1">, %arg4: memref<1xi512, "stream1">, %arg5: memref<1xi512, "stream1">, %arg6: memref<1xi512, "stream1">, %arg7: memref<1xi512, "stream1">, %arg8: memref<1024x32xi512>) attributes {adf.pl, inline = false} {
    call @load1(%arg0, %arg1, %arg2, %arg3, %arg4, %arg5, %arg6, %arg7, %arg8) {template = 0 : index} : (memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1024x32xi512>) -> ()
    return
  }
  func.func @load1_7(%arg0: memref<1xi512, "stream1">, %arg1: memref<1xi128, "stream">) attributes {adf.pl, inline = false, load, template} {
    affine.for %arg2 = 0 to 2 {
      affine.for %arg3 = 0 to 2 {
        affine.for %arg4 = 0 to 2 {
          affine.for %arg5 = 0 to 8 {
            affine.for %arg6 = 0 to 8 {
              affine.for %arg7 = 0 to 8 {
                affine.for %arg8 = 0 to 16 {
                  affine.for %arg9 = 0 to 2 {
                    affine.for %arg10 = 0 to 1 {
                      %0 = affine.load %arg0[0] : memref<1xi512, "stream1">
                      affine.for %arg11 = 0 to 4 {
                        %1 = affine.apply #map(%arg11)
                        %2 = affine.apply #map1(%arg11)
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
      }
    }
    return
  }
  func.func @load1_7_top(%arg0: memref<1xi512, "stream1">, %arg1: memref<1xi128, "stream">, %arg2: memref<1xi512, "stream1">, %arg3: memref<1xi128, "stream">, %arg4: memref<1xi512, "stream1">, %arg5: memref<1xi128, "stream">, %arg6: memref<1xi512, "stream1">, %arg7: memref<1xi128, "stream">, %arg8: memref<1xi512, "stream1">, %arg9: memref<1xi128, "stream">, %arg10: memref<1xi512, "stream1">, %arg11: memref<1xi128, "stream">, %arg12: memref<1xi512, "stream1">, %arg13: memref<1xi128, "stream">, %arg14: memref<1xi512, "stream1">, %arg15: memref<1xi128, "stream">) attributes {adf.pl, inline = false} {
    call @load1_7(%arg0, %arg1) {template = 0 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load1_7(%arg2, %arg3) {template = 1 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load1_7(%arg4, %arg5) {template = 2 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load1_7(%arg6, %arg7) {template = 3 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load1_7(%arg8, %arg9) {template = 4 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load1_7(%arg10, %arg11) {template = 5 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load1_7(%arg12, %arg13) {template = 6 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @load1_7(%arg14, %arg15) {template = 7 : index} : (memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    return
  }
  func.func @ttmc_pl(%arg0: memref<4x1024x256xi512>, %arg1: memref<1024x32xi512>, %arg2: memref<4096x48xi512>, %arg3: memref<4x512x48xi512>, %arg4: memref<1xi128, "plio">, %arg5: memref<1xi128, "plio">, %arg6: memref<1xi128, "plio">, %arg7: memref<1xi128, "plio">, %arg8: memref<1xi128, "plio">, %arg9: memref<1xi128, "plio">, %arg10: memref<1xi128, "plio">, %arg11: memref<1xi128, "plio">, %arg12: memref<1xi128, "plio">, %arg13: memref<1xi128, "plio">, %arg14: memref<1xi128, "plio">, %arg15: memref<1xi128, "plio">, %arg16: memref<1xi128, "plio">, %arg17: memref<1xi128, "plio">, %arg18: memref<1xi128, "plio">, %arg19: memref<1xi128, "plio">, %arg20: memref<1xi128, "plio">, %arg21: memref<1xi128, "plio">, %arg22: memref<1xi128, "plio">, %arg23: memref<1xi128, "plio">, %arg24: memref<1xi128, "plio">, %arg25: memref<1xi128, "plio">, %arg26: memref<1xi128, "plio">, %arg27: memref<1xi128, "plio">, %arg28: memref<1xi128, "plio">, %arg29: memref<1xi128, "plio">, %arg30: memref<1xi128, "plio">, %arg31: memref<1xi128, "plio">, %arg32: memref<1xi128, "plio">, %arg33: memref<1xi128, "plio">, %arg34: memref<1xi128, "plio">, %arg35: memref<1xi128, "plio">, %arg36: memref<1xi128, "plio">, %arg37: memref<1xi128, "plio">, %arg38: memref<1xi128, "plio">, %arg39: memref<1xi128, "plio">, %arg40: memref<1xi128, "plio">, %arg41: memref<1xi128, "plio">, %arg42: memref<1xi128, "plio">, %arg43: memref<1xi128, "plio">, %arg44: memref<1xi128, "plio">, %arg45: memref<1xi128, "plio">, %arg46: memref<1xi128, "plio">, %arg47: memref<1xi128, "plio">, %arg48: memref<1xi128, "plio">, %arg49: memref<1xi128, "plio">, %arg50: memref<1xi128, "plio">, %arg51: memref<1xi128, "plio">, %arg52: memref<1xi128, "plio">, %arg53: memref<1xi128, "plio">, %arg54: memref<1xi128, "plio">, %arg55: memref<1xi128, "plio">, %arg56: memref<1xi128, "plio">, %arg57: memref<1xi128, "plio">, %arg58: memref<1xi128, "plio">, %arg59: memref<1xi128, "plio">, %arg60: memref<1xi128, "plio">, %arg61: memref<1xi128, "plio">, %arg62: memref<1xi128, "plio">, %arg63: memref<1xi128, "plio">, %arg64: memref<1xi128, "plio">, %arg65: memref<1xi128, "plio">, %arg66: memref<1xi128, "plio">, %arg67: memref<1xi128, "plio">, %arg68: memref<1xi128, "plio">, %arg69: memref<1xi128, "plio">, %arg70: memref<1xi128, "plio">, %arg71: memref<1xi128, "plio">, %arg72: memref<1xi128, "plio">, %arg73: memref<1xi128, "plio">, %arg74: memref<1xi128, "plio">, %arg75: memref<1xi128, "plio">, %arg76: memref<1xi128, "plio">, %arg77: memref<1xi128, "plio">, %arg78: memref<1xi128, "plio">, %arg79: memref<1xi128, "plio">, %arg80: memref<1xi128, "plio">, %arg81: memref<1xi128, "plio">, %arg82: memref<1xi128, "plio">, %arg83: memref<1xi128, "plio">, %arg84: memref<1xi128, "plio">, %arg85: memref<1xi128, "plio">, %arg86: memref<1xi128, "plio">, %arg87: memref<1xi128, "plio">, %arg88: memref<1xi128, "plio">, %arg89: memref<1xi128, "plio">, %arg90: memref<1xi128, "plio">, %arg91: memref<1xi128, "plio">, %arg92: memref<1xi128, "plio">, %arg93: memref<1xi128, "plio">, %arg94: memref<1xi128, "plio">, %arg95: memref<1xi128, "plio">, %arg96: memref<1xi128, "plio">, %arg97: memref<1xi128, "plio">, %arg98: memref<1xi128, "plio">, %arg99: memref<1xi128, "plio">, %arg100: memref<1xi128, "plio">, %arg101: memref<1xi128, "plio">, %arg102: memref<1xi128, "plio">, %arg103: memref<1xi128, "plio">, %arg104: memref<1xi128, "plio">, %arg105: memref<1xi128, "plio">, %arg106: memref<1xi128, "plio">, %arg107: memref<1xi128, "plio">, %arg108: memref<1xi128, "plio">, %arg109: memref<1xi128, "plio">, %arg110: memref<1xi128, "plio">, %arg111: memref<1xi128, "plio">, %arg112: memref<1xi128, "plio">, %arg113: memref<1xi128, "plio">, %arg114: memref<1xi128, "plio">, %arg115: memref<1xi128, "plio">, %arg116: memref<1xi128, "plio">, %arg117: memref<1xi128, "plio">, %arg118: memref<1xi128, "plio">, %arg119: memref<1xi128, "plio">, %arg120: memref<1xi128, "plio">, %arg121: memref<1xi128, "plio">, %arg122: memref<1xi128, "plio">, %arg123: memref<1xi128, "plio">, %arg124: memref<1xi128, "plio">, %arg125: memref<1xi128, "plio">, %arg126: memref<1xi128, "plio">, %arg127: memref<1xi128, "plio">, %arg128: memref<1xi128, "plio">, %arg129: memref<1xi128, "plio">, %arg130: memref<1xi128, "plio">, %arg131: memref<1xi128, "plio">, %arg132: memref<1xi128, "plio">, %arg133: memref<1xi128, "plio">) attributes {adf.pl = true, dataflow, inline = false, mem_idx = [0 : i32, 1 : i32, 2 : i32, 3 : i32], mem_type = [i32, i32, i32, i32]} {
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
    %alloc_129 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_130 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_131 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_132 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_133 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_134 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_135 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_136 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_137 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_138 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_139 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_140 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_141 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_142 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_143 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_144 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_145 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_146 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_147 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_148 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_149 = memref.alloc() : memref<1xi512, "stream1">
    %alloc_150 = memref.alloc() : memref<1xi512, "stream1">
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
    %alloc_225 = memref.alloc() : memref<1xi512, "stream2">
    %alloc_226 = memref.alloc() : memref<1xi512, "stream2">
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
    call @receive13_top(%alloc_12, %arg125, %alloc_26, %arg128, %alloc_41, %arg48, %alloc_11, %arg132, %alloc_92, %arg81, %alloc_62, %arg10, %alloc_50, %arg59, %alloc_55, %arg28, %alloc_23, %arg96, %alloc_52, %arg93, %alloc_71, %arg62, %alloc_61, %arg46, %alloc_44, %arg115, %alloc_28, %arg43, %alloc_73, %arg86, %alloc_53, %arg70, %alloc_76, %arg29, %alloc_49, %arg15, %alloc_51, %arg112, %alloc_68, %arg26, %alloc_7, %arg36, %alloc_83, %arg124, %alloc_8, %arg122, %alloc_90, %arg54, %alloc_14, %arg39, %alloc_19, %arg92, %alloc_40, %arg65, %alloc_13, %arg64, %alloc_48, %arg89, %alloc_21, %arg23, %alloc_36, %arg111, %alloc_32, %arg131, %alloc_15, %arg53, %alloc_4, %arg90, %alloc_27, %arg109, %alloc_10, %arg13, %alloc_6, %arg68, %alloc_64, %arg52, %alloc_89, %arg55, %alloc_67, %arg6, %alloc_85, %arg123, %alloc_87, %arg67, %alloc_25, %arg27, %alloc_3, %arg75, %alloc_24, %arg44) : (memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send29_top(%alloc_99, %arg35, %alloc_98, %arg113, %alloc_96, %arg121, %alloc_100, %arg87, %alloc_101, %arg16, %alloc_97, %arg79, %alloc_95, %arg117, %alloc_127, %arg8) : (memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @send21_top(%alloc_107, %arg104, %alloc_106, %arg107, %alloc_111, %arg21, %alloc_102, %arg116, %alloc_122, %arg83, %alloc_108, %arg7, %alloc_104, %arg105, %alloc_109, %arg19, %alloc_120, %arg58, %alloc_115, %arg49, %alloc_116, %arg12, %alloc_126, %arg71, %alloc_113, %arg56, %alloc_112, %arg38, %alloc_103, %arg110, %alloc_110, %arg50, %alloc_124, %arg24, %alloc_121, %arg118, %alloc_105, %arg94, %alloc_117, %arg97, %alloc_119, %arg99, %alloc_118, %arg32, %alloc_114, %arg61, %alloc_123, %arg129) : (memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @receive2_top(%arg63, %alloc_1, %arg77, %alloc_43, %arg76, %alloc_86, %arg37, %alloc_72, %arg82, %alloc_91, %arg22, %alloc_9, %arg14, %alloc_94, %arg11, %alloc_93, %arg95, %alloc, %arg25, %alloc_60, %arg18, %alloc_57, %arg69, %alloc_30, %arg100, %alloc_42, %arg114, %alloc_79, %arg33, %alloc_20, %arg108, %alloc_78, %arg51, %alloc_58, %arg9, %alloc_16, %arg84, %alloc_54, %arg20, %alloc_38, %arg80, %alloc_39, %arg66, %alloc_59, %arg101, %alloc_46, %arg127, %alloc_17, %arg91, %alloc_70, %arg102, %alloc_74, %arg98, %alloc_47, %arg41, %alloc_18, %arg42, %alloc_37, %arg133, %alloc_88, %arg88, %alloc_0, %arg34, %alloc_69, %arg119, %alloc_45, %arg4, %alloc_34, %arg30, %alloc_77, %arg126, %alloc_2, %arg45, %alloc_65, %arg120, %alloc_5, %arg103, %alloc_84, %arg106, %alloc_82, %arg5, %alloc_33, %arg74, %alloc_81, %arg57, %alloc_66, %arg31, %alloc_75, %arg73, %alloc_56, %arg130, %alloc_22, %arg17, %alloc_63, %arg85, %alloc_29, %arg40, %alloc_35, %arg47, %alloc_31, %arg60, %alloc_80) : (memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">, memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @store0_0_top(%alloc, %alloc_129, %alloc_0, %alloc_130, %alloc_1, %alloc_131, %alloc_2, %alloc_132, %alloc_3, %alloc_133, %alloc_4, %alloc_134, %alloc_5, %alloc_135, %alloc_6, %alloc_136, %alloc_7, %alloc_137, %alloc_8, %alloc_138, %alloc_9, %alloc_139, %alloc_10, %alloc_140, %alloc_11, %alloc_141, %alloc_12, %alloc_142, %alloc_13, %alloc_143, %alloc_14, %alloc_144, %alloc_15, %alloc_145, %alloc_16, %alloc_146, %alloc_17, %alloc_147, %alloc_18, %alloc_148, %alloc_19, %alloc_149, %alloc_20, %alloc_150, %alloc_21, %alloc_151, %alloc_22, %alloc_152, %alloc_23, %alloc_153, %alloc_24, %alloc_154, %alloc_25, %alloc_155, %alloc_26, %alloc_156, %alloc_27, %alloc_157, %alloc_28, %alloc_158, %alloc_29, %alloc_159, %alloc_30, %alloc_160, %alloc_31, %alloc_161, %alloc_32, %alloc_162, %alloc_33, %alloc_163, %alloc_34, %alloc_164, %alloc_35, %alloc_165, %alloc_36, %alloc_166, %alloc_37, %alloc_167, %alloc_38, %alloc_168, %alloc_39, %alloc_169, %alloc_40, %alloc_170, %alloc_41, %alloc_171, %alloc_42, %alloc_172, %alloc_43, %alloc_173, %alloc_44, %alloc_174, %alloc_45, %alloc_175, %alloc_46, %alloc_176, %alloc_47, %alloc_177, %alloc_48, %alloc_178, %alloc_49, %alloc_179, %alloc_50, %alloc_180, %alloc_51, %alloc_181, %alloc_52, %alloc_182, %alloc_53, %alloc_183, %alloc_54, %alloc_184, %alloc_55, %alloc_185, %alloc_56, %alloc_186, %alloc_57, %alloc_187, %alloc_58, %alloc_188, %alloc_59, %alloc_189, %alloc_60, %alloc_190, %alloc_61, %alloc_191, %alloc_62, %alloc_192, %alloc_63, %alloc_193, %alloc_64, %alloc_194, %alloc_65, %alloc_195, %alloc_66, %alloc_196, %alloc_67, %alloc_197, %alloc_68, %alloc_198, %alloc_69, %alloc_199, %alloc_70, %alloc_200, %alloc_71, %alloc_201, %alloc_72, %alloc_202, %alloc_73, %alloc_203, %alloc_74, %alloc_204, %alloc_75, %alloc_205, %alloc_76, %alloc_206, %alloc_77, %alloc_207, %alloc_78, %alloc_208, %alloc_79, %alloc_209, %alloc_80, %alloc_210, %alloc_81, %alloc_211, %alloc_82, %alloc_212, %alloc_83, %alloc_213, %alloc_84, %alloc_214, %alloc_85, %alloc_215, %alloc_86, %alloc_216, %alloc_87, %alloc_217, %alloc_88, %alloc_218, %alloc_89, %alloc_219, %alloc_90, %alloc_220, %alloc_91, %alloc_221, %alloc_92, %alloc_222, %alloc_93, %alloc_223, %alloc_94, %alloc_224) : (memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">) -> ()
    call @store0_top(%alloc_181, %alloc_203, %alloc_156, %alloc_162, %alloc_176, %alloc_133, %alloc_170, %alloc_159, %alloc_213, %alloc_143, %alloc_219, %alloc_178, %alloc_224, %alloc_209, %alloc_153, %alloc_144, %alloc_190, %alloc_157, %alloc_175, %alloc_150, %alloc_182, %alloc_137, %alloc_216, %alloc_166, %alloc_215, %alloc_173, %alloc_220, %alloc_155, %alloc_151, %alloc_160, %alloc_171, %alloc_158, %alloc_192, %alloc_132, %alloc_211, %alloc_168, %alloc_205, %alloc_201, %alloc_169, %alloc_163, %alloc_145, %alloc_200, %alloc_136, %alloc_189, %alloc_206, %alloc_146, %alloc_135, %alloc_177, %alloc_212, %alloc_214, %alloc_130, %alloc_208, %alloc_131, %arg3, %alloc_221, %alloc_186, %alloc_141, %alloc_207, %alloc_165, %alloc_184, %alloc_197, %alloc_161, %alloc_142, %alloc_154, %alloc_210, %alloc_202, %alloc_179, %alloc_188, %alloc_199, %alloc_222, %alloc_152, %alloc_193, %alloc_204, %alloc_187, %alloc_217, %alloc_129, %alloc_149, %alloc_140, %alloc_185, %alloc_191, %alloc_223, %alloc_180, %alloc_194, %alloc_172, %alloc_148, %alloc_174, %alloc_167, %alloc_183, %alloc_196, %alloc_147, %alloc_139, %alloc_195, %alloc_164, %alloc_134, %alloc_138, %alloc_198, %alloc_218) : (memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<4x512x48xi512>, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">) -> ()
    call @load0_top(%arg0, %alloc_225, %alloc_226) : (memref<4x1024x256xi512>, memref<1xi512, "stream2">, memref<1xi512, "stream2">) -> ()
    call @load0_1_top(%alloc_226, %alloc_128, %alloc_225, %alloc_125) : (memref<1xi512, "stream2">, memref<1xi128, "stream">, memref<1xi512, "stream2">, memref<1xi128, "stream">) -> ()
    call @send3_top(%alloc_125, %arg72) : (memref<1xi128, "stream">, memref<1xi128, "plio">) -> ()
    call @load2_top(%alloc_248, %alloc_236, %alloc_243, %alloc_239, %alloc_227, %alloc_249, %alloc_242, %alloc_241, %alloc_244, %alloc_250, %alloc_238, %alloc_233, %alloc_237, %arg2, %alloc_234, %alloc_229, %alloc_228, %alloc_231, %alloc_246, %alloc_240, %alloc_247, %alloc_230, %alloc_235, %alloc_245, %alloc_232) : (memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<4096x48xi512>, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">) -> ()
    call @load2_23_top(%alloc_250, %alloc_126, %alloc_249, %alloc_124, %alloc_248, %alloc_123, %alloc_247, %alloc_122, %alloc_246, %alloc_121, %alloc_245, %alloc_120, %alloc_244, %alloc_119, %alloc_243, %alloc_118, %alloc_242, %alloc_117, %alloc_241, %alloc_116, %alloc_240, %alloc_115, %alloc_239, %alloc_114, %alloc_238, %alloc_113, %alloc_237, %alloc_112, %alloc_236, %alloc_111, %alloc_235, %alloc_110, %alloc_234, %alloc_109, %alloc_233, %alloc_108, %alloc_232, %alloc_107, %alloc_231, %alloc_106, %alloc_230, %alloc_105, %alloc_229, %alloc_104, %alloc_228, %alloc_103, %alloc_227, %alloc_102) : (memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    call @send0_top(%arg78, %alloc_128) : (memref<1xi128, "plio">, memref<1xi128, "stream">) -> ()
    call @load1_top(%alloc_252, %alloc_251, %alloc_254, %alloc_253, %alloc_257, %alloc_255, %alloc_258, %alloc_256, %arg1) : (memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1xi512, "stream1">, memref<1024x32xi512>) -> ()
    call @load1_7_top(%alloc_258, %alloc_127, %alloc_257, %alloc_101, %alloc_256, %alloc_100, %alloc_255, %alloc_99, %alloc_254, %alloc_98, %alloc_253, %alloc_97, %alloc_252, %alloc_96, %alloc_251, %alloc_95) : (memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">, memref<1xi512, "stream1">, memref<1xi128, "stream">) -> ()
    return
  }
  func.func @ttmc(%arg0: memref<4x1024x256xi512>, %arg1: memref<1024x32xi512>, %arg2: memref<4096x48xi512>, %arg3: memref<4x512x48xi512>, %arg4: memref<1xi128, "plio">, %arg5: memref<1xi128, "plio">, %arg6: memref<1xi128, "plio">, %arg7: memref<1xi128, "plio">, %arg8: memref<1xi128, "plio">, %arg9: memref<1xi128, "plio">, %arg10: memref<1xi128, "plio">, %arg11: memref<1xi128, "plio">, %arg12: memref<1xi128, "plio">, %arg13: memref<1xi128, "plio">, %arg14: memref<1xi128, "plio">, %arg15: memref<1xi128, "plio">, %arg16: memref<1xi128, "plio">, %arg17: memref<1xi128, "plio">, %arg18: memref<1xi128, "plio">, %arg19: memref<1xi128, "plio">, %arg20: memref<1xi128, "plio">, %arg21: memref<1xi128, "plio">, %arg22: memref<1xi128, "plio">, %arg23: memref<1xi128, "plio">, %arg24: memref<1xi128, "plio">, %arg25: memref<1xi128, "plio">, %arg26: memref<1xi128, "plio">, %arg27: memref<1xi128, "plio">, %arg28: memref<1xi128, "plio">, %arg29: memref<1xi128, "plio">, %arg30: memref<1xi128, "plio">, %arg31: memref<1xi128, "plio">, %arg32: memref<1xi128, "plio">, %arg33: memref<1xi128, "plio">, %arg34: memref<1xi128, "plio">, %arg35: memref<1xi128, "plio">, %arg36: memref<1xi128, "plio">, %arg37: memref<1xi128, "plio">, %arg38: memref<1xi128, "plio">, %arg39: memref<1xi128, "plio">, %arg40: memref<1xi128, "plio">, %arg41: memref<1xi128, "plio">, %arg42: memref<1xi128, "plio">, %arg43: memref<1xi128, "plio">, %arg44: memref<1xi128, "plio">, %arg45: memref<1xi128, "plio">, %arg46: memref<1xi128, "plio">, %arg47: memref<1xi128, "plio">, %arg48: memref<1xi128, "plio">, %arg49: memref<1xi128, "plio">, %arg50: memref<1xi128, "plio">, %arg51: memref<1xi128, "plio">, %arg52: memref<1xi128, "plio">, %arg53: memref<1xi128, "plio">, %arg54: memref<1xi128, "plio">, %arg55: memref<1xi128, "plio">, %arg56: memref<1xi128, "plio">, %arg57: memref<1xi128, "plio">, %arg58: memref<1xi128, "plio">, %arg59: memref<1xi128, "plio">, %arg60: memref<1xi128, "plio">, %arg61: memref<1xi128, "plio">, %arg62: memref<1xi128, "plio">, %arg63: memref<1xi128, "plio">, %arg64: memref<1xi128, "plio">, %arg65: memref<1xi128, "plio">, %arg66: memref<1xi128, "plio">, %arg67: memref<1xi128, "plio">, %arg68: memref<1xi128, "plio">, %arg69: memref<1xi128, "plio">, %arg70: memref<1xi128, "plio">, %arg71: memref<1xi128, "plio">, %arg72: memref<1xi128, "plio">, %arg73: memref<1xi128, "plio">, %arg74: memref<1xi128, "plio">, %arg75: memref<1xi128, "plio">, %arg76: memref<1xi128, "plio">, %arg77: memref<1xi128, "plio">, %arg78: memref<1xi128, "plio">, %arg79: memref<1xi128, "plio">, %arg80: memref<1xi128, "plio">, %arg81: memref<1xi128, "plio">, %arg82: memref<1xi128, "plio">, %arg83: memref<1xi128, "plio">, %arg84: memref<1xi128, "plio">, %arg85: memref<1xi128, "plio">, %arg86: memref<1xi128, "plio">, %arg87: memref<1xi128, "plio">, %arg88: memref<1xi128, "plio">, %arg89: memref<1xi128, "plio">, %arg90: memref<1xi128, "plio">, %arg91: memref<1xi128, "plio">, %arg92: memref<1xi128, "plio">, %arg93: memref<1xi128, "plio">, %arg94: memref<1xi128, "plio">, %arg95: memref<1xi128, "plio">, %arg96: memref<1xi128, "plio">, %arg97: memref<1xi128, "plio">, %arg98: memref<1xi128, "plio">, %arg99: memref<1xi128, "plio">, %arg100: memref<1xi128, "plio">, %arg101: memref<1xi128, "plio">, %arg102: memref<1xi128, "plio">, %arg103: memref<1xi128, "plio">, %arg104: memref<1xi128, "plio">, %arg105: memref<1xi128, "plio">, %arg106: memref<1xi128, "plio">, %arg107: memref<1xi128, "plio">, %arg108: memref<1xi128, "plio">, %arg109: memref<1xi128, "plio">, %arg110: memref<1xi128, "plio">, %arg111: memref<1xi128, "plio">, %arg112: memref<1xi128, "plio">, %arg113: memref<1xi128, "plio">, %arg114: memref<1xi128, "plio">, %arg115: memref<1xi128, "plio">, %arg116: memref<1xi128, "plio">, %arg117: memref<1xi128, "plio">, %arg118: memref<1xi128, "plio">, %arg119: memref<1xi128, "plio">, %arg120: memref<1xi128, "plio">, %arg121: memref<1xi128, "plio">, %arg122: memref<1xi128, "plio">, %arg123: memref<1xi128, "plio">, %arg124: memref<1xi128, "plio">, %arg125: memref<1xi128, "plio">, %arg126: memref<1xi128, "plio">, %arg127: memref<1xi128, "plio">, %arg128: memref<1xi128, "plio">, %arg129: memref<1xi128, "plio">, %arg130: memref<1xi128, "plio">, %arg131: memref<1xi128, "plio">, %arg132: memref<1xi128, "plio">, %arg133: memref<1xi128, "plio">) attributes {adf.func, gmio = false, plio = true} {
    %0 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%0, %arg14) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %1 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%1, %arg11) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %2 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%2, %arg81) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %3 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%3, %arg82) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %4 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%4, %arg54) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %5 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%5, %arg55) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %6 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%6, %arg133) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %7 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%7, %arg67) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %8 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%8, %arg76) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %9 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%9, %arg123) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %10 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%10, %arg103) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %11 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%11, %arg124) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %12 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg117, %12) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %13 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%13, %arg106) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %14 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%14, %arg74) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %15 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%15, %arg60) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %16 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%16, %arg114) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %17 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%17, %arg108) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %18 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%18, %arg30) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %19 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%19, %arg29) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %20 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%20, %arg31) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %21 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%21, %arg102) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %22 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%22, %arg86) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %23 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%23, %arg37) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %24 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%24, %arg62) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %25 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg121, %25) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %26 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%26, %arg91) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %27 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%27, %arg34) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %28 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%28, %arg26) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %29 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%29, %arg6) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %30 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%30, %arg57) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %31 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%31, %arg45) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %32 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%32, %arg52) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %33 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%33, %arg17) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %34 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%34, %arg10) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %35 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%35, %arg46) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %36 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%36, %arg25) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %37 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%37, %arg66) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %38 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg79, %38) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %39 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%39, %arg51) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %40 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%40, %arg18) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %41 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%41, %arg73) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %42 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%42, %arg28) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %43 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%43, %arg84) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %44 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%44, %arg70) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %45 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%45, %arg93) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %46 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%46, %arg112) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %47 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%47, %arg59) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %48 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%48, %arg15) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %49 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%49, %arg89) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %50 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%50, %arg98) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %51 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg113, %51) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %52 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%52, %arg101) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %53 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%53, %arg119) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %54 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%54, %arg115) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %55 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%55, %arg77) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %56 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%56, %arg100) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %57 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%57, %arg48) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %58 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%58, %arg65) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %59 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%59, %arg80) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %60 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%60, %arg20) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %61 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%61, %arg42) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %62 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%62, %arg111) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %63 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%63, %arg40) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %64 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg35, %64) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %65 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%65, %arg4) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %66 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%66, %arg5) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %67 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%67, %arg131) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %68 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%68, %arg47) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %69 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%69, %arg69) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %70 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%70, %arg85) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %71 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%71, %arg43) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %72 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%72, %arg109) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %73 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%73, %arg128) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %74 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%74, %arg27) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %75 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%75, %arg44) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %76 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%76, %arg96) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %77 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg87, %77) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %78 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%78, %arg130) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %79 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%79, %arg23) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %80 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%80, %arg33) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %81 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%81, %arg92) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %82 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%82, %arg41) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %83 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%83, %arg127) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %84 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%84, %arg9) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %85 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%85, %arg53) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %86 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%86, %arg39) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %87 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%87, %arg64) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %88 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%88, %arg125) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %89 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%89, %arg132) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %90 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg16, %90) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %91 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%91, %arg13) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %92 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg116, %92) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %93 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg110, %93) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %94 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%94, %arg22) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %95 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg105, %95) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %96 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg94, %96) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %97 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%97, %arg122) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %98 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg107, %98) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %99 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg104, %99) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %100 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%100, %arg36) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %101 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg7, %101) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %102 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg19, %102) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %103 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%103, %arg68) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %104 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg50, %104) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %105 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg21, %105) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %106 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%106, %arg120) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %107 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg38, %107) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %108 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg56, %108) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %109 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%109, %arg90) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %110 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg61, %110) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %111 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg49, %111) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %112 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%112, %arg75) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %113 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg12, %113) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %114 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg97, %114) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %115 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%115, %arg126) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %116 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg32, %116) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %117 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg99, %117) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %118 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%118, %arg63) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %119 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg58, %119) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %120 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg118, %120) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %121 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%121, %arg88) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %122 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg83, %122) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %123 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg129, %123) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %124 = adf.graph.io(PLIO) : !adf.plio<Out, 128>
    adf.connect(%124, %arg95) {top_config} : (!adf.plio<Out, 128>, memref<1xi128, "plio">)
    %125 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg24, %125) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %126 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg72, %126) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %127 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg71, %127) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %128 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg8, %128) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    %129 = adf.graph.io(PLIO) : !adf.plio<In, 128>
    adf.connect(%arg78, %129) {top_config} : (memref<1xi128, "plio">, !adf.plio<In, 128>)
    adf.cell.launch @adf_cell0 {
      func.call @adf_cell0(%129, %128, %127, %126, %125, %124, %123, %122, %121, %120, %119, %118, %117, %116, %115, %114, %113, %112, %111, %110, %109, %108, %107, %106, %105, %104, %103, %102, %101, %100, %99, %98, %97, %96, %95, %94, %93, %92, %91, %90, %89, %88, %87, %86, %85, %84, %83, %82, %81, %80, %79, %78, %77, %76, %75, %74, %73, %72, %71, %70, %69, %68, %67, %66, %65, %64, %63, %62, %61, %60, %59, %58, %57, %56, %55, %54, %53, %52, %51, %50, %49, %48, %47, %46, %45, %44, %43, %42, %41, %40, %39, %38, %37, %36, %35, %34, %33, %32, %31, %30, %29, %28, %27, %26, %25, %24, %23, %22, %21, %20, %19, %18, %17, %16, %15, %14, %13, %12, %11, %10, %9, %8, %7, %6, %5, %4, %3, %2, %1, %0) {adf.cell} : (!adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<Out, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<Out, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<Out, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<Out, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<Out, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<Out, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<Out, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<Out, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<Out, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<Out, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<Out, 128>, !adf.plio<In, 128>, !adf.plio<In, 128>, !adf.plio<Out, 128>, !adf.plio<In, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<In, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<In, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<In, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<In, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<In, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<In, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>, !adf.plio<Out, 128>) -> ()
      adf.cell.launch.end
    }
    adf.pl.launch @ttmc_pl {
      func.call @ttmc_pl(%arg0, %arg1, %arg2, %arg3, %arg4, %arg5, %arg6, %arg7, %arg8, %arg9, %arg10, %arg11, %arg12, %arg13, %arg14, %arg15, %arg16, %arg17, %arg18, %arg19, %arg20, %arg21, %arg22, %arg23, %arg24, %arg25, %arg26, %arg27, %arg28, %arg29, %arg30, %arg31, %arg32, %arg33, %arg34, %arg35, %arg36, %arg37, %arg38, %arg39, %arg40, %arg41, %arg42, %arg43, %arg44, %arg45, %arg46, %arg47, %arg48, %arg49, %arg50, %arg51, %arg52, %arg53, %arg54, %arg55, %arg56, %arg57, %arg58, %arg59, %arg60, %arg61, %arg62, %arg63, %arg64, %arg65, %arg66, %arg67, %arg68, %arg69, %arg70, %arg71, %arg72, %arg73, %arg74, %arg75, %arg76, %arg77, %arg78, %arg79, %arg80, %arg81, %arg82, %arg83, %arg84, %arg85, %arg86, %arg87, %arg88, %arg89, %arg90, %arg91, %arg92, %arg93, %arg94, %arg95, %arg96, %arg97, %arg98, %arg99, %arg100, %arg101, %arg102, %arg103, %arg104, %arg105, %arg106, %arg107, %arg108, %arg109, %arg110, %arg111, %arg112, %arg113, %arg114, %arg115, %arg116, %arg117, %arg118, %arg119, %arg120, %arg121, %arg122, %arg123, %arg124, %arg125, %arg126, %arg127, %arg128, %arg129, %arg130, %arg131, %arg132, %arg133) {adf.pl} : (memref<4x1024x256xi512>, memref<1024x32xi512>, memref<4096x48xi512>, memref<4x512x48xi512>, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">) -> ()
      adf.pl.launch.wait
    }
    return
  }
  func.func @top(%arg0: memref<4x1024x256xi512>, %arg1: memref<1024x32xi512>, %arg2: memref<4096x48xi512>, %arg3: memref<4x512x48xi512>, %arg4: memref<1xi128, "plio">, %arg5: memref<1xi128, "plio">, %arg6: memref<1xi128, "plio">, %arg7: memref<1xi128, "plio">, %arg8: memref<1xi128, "plio">, %arg9: memref<1xi128, "plio">, %arg10: memref<1xi128, "plio">, %arg11: memref<1xi128, "plio">, %arg12: memref<1xi128, "plio">, %arg13: memref<1xi128, "plio">, %arg14: memref<1xi128, "plio">, %arg15: memref<1xi128, "plio">, %arg16: memref<1xi128, "plio">, %arg17: memref<1xi128, "plio">, %arg18: memref<1xi128, "plio">, %arg19: memref<1xi128, "plio">, %arg20: memref<1xi128, "plio">, %arg21: memref<1xi128, "plio">, %arg22: memref<1xi128, "plio">, %arg23: memref<1xi128, "plio">, %arg24: memref<1xi128, "plio">, %arg25: memref<1xi128, "plio">, %arg26: memref<1xi128, "plio">, %arg27: memref<1xi128, "plio">, %arg28: memref<1xi128, "plio">, %arg29: memref<1xi128, "plio">, %arg30: memref<1xi128, "plio">, %arg31: memref<1xi128, "plio">, %arg32: memref<1xi128, "plio">, %arg33: memref<1xi128, "plio">, %arg34: memref<1xi128, "plio">, %arg35: memref<1xi128, "plio">, %arg36: memref<1xi128, "plio">, %arg37: memref<1xi128, "plio">, %arg38: memref<1xi128, "plio">, %arg39: memref<1xi128, "plio">, %arg40: memref<1xi128, "plio">, %arg41: memref<1xi128, "plio">, %arg42: memref<1xi128, "plio">, %arg43: memref<1xi128, "plio">, %arg44: memref<1xi128, "plio">, %arg45: memref<1xi128, "plio">, %arg46: memref<1xi128, "plio">, %arg47: memref<1xi128, "plio">, %arg48: memref<1xi128, "plio">, %arg49: memref<1xi128, "plio">, %arg50: memref<1xi128, "plio">, %arg51: memref<1xi128, "plio">, %arg52: memref<1xi128, "plio">, %arg53: memref<1xi128, "plio">, %arg54: memref<1xi128, "plio">, %arg55: memref<1xi128, "plio">, %arg56: memref<1xi128, "plio">, %arg57: memref<1xi128, "plio">, %arg58: memref<1xi128, "plio">, %arg59: memref<1xi128, "plio">, %arg60: memref<1xi128, "plio">, %arg61: memref<1xi128, "plio">, %arg62: memref<1xi128, "plio">, %arg63: memref<1xi128, "plio">, %arg64: memref<1xi128, "plio">, %arg65: memref<1xi128, "plio">, %arg66: memref<1xi128, "plio">, %arg67: memref<1xi128, "plio">, %arg68: memref<1xi128, "plio">, %arg69: memref<1xi128, "plio">, %arg70: memref<1xi128, "plio">, %arg71: memref<1xi128, "plio">, %arg72: memref<1xi128, "plio">, %arg73: memref<1xi128, "plio">, %arg74: memref<1xi128, "plio">, %arg75: memref<1xi128, "plio">, %arg76: memref<1xi128, "plio">, %arg77: memref<1xi128, "plio">, %arg78: memref<1xi128, "plio">, %arg79: memref<1xi128, "plio">, %arg80: memref<1xi128, "plio">, %arg81: memref<1xi128, "plio">, %arg82: memref<1xi128, "plio">, %arg83: memref<1xi128, "plio">, %arg84: memref<1xi128, "plio">, %arg85: memref<1xi128, "plio">, %arg86: memref<1xi128, "plio">, %arg87: memref<1xi128, "plio">, %arg88: memref<1xi128, "plio">, %arg89: memref<1xi128, "plio">, %arg90: memref<1xi128, "plio">, %arg91: memref<1xi128, "plio">, %arg92: memref<1xi128, "plio">, %arg93: memref<1xi128, "plio">, %arg94: memref<1xi128, "plio">, %arg95: memref<1xi128, "plio">, %arg96: memref<1xi128, "plio">, %arg97: memref<1xi128, "plio">, %arg98: memref<1xi128, "plio">, %arg99: memref<1xi128, "plio">, %arg100: memref<1xi128, "plio">, %arg101: memref<1xi128, "plio">, %arg102: memref<1xi128, "plio">, %arg103: memref<1xi128, "plio">, %arg104: memref<1xi128, "plio">, %arg105: memref<1xi128, "plio">, %arg106: memref<1xi128, "plio">, %arg107: memref<1xi128, "plio">, %arg108: memref<1xi128, "plio">, %arg109: memref<1xi128, "plio">, %arg110: memref<1xi128, "plio">, %arg111: memref<1xi128, "plio">, %arg112: memref<1xi128, "plio">, %arg113: memref<1xi128, "plio">, %arg114: memref<1xi128, "plio">, %arg115: memref<1xi128, "plio">, %arg116: memref<1xi128, "plio">, %arg117: memref<1xi128, "plio">, %arg118: memref<1xi128, "plio">, %arg119: memref<1xi128, "plio">, %arg120: memref<1xi128, "plio">, %arg121: memref<1xi128, "plio">, %arg122: memref<1xi128, "plio">, %arg123: memref<1xi128, "plio">, %arg124: memref<1xi128, "plio">, %arg125: memref<1xi128, "plio">, %arg126: memref<1xi128, "plio">, %arg127: memref<1xi128, "plio">, %arg128: memref<1xi128, "plio">, %arg129: memref<1xi128, "plio">, %arg130: memref<1xi128, "plio">, %arg131: memref<1xi128, "plio">, %arg132: memref<1xi128, "plio">, %arg133: memref<1xi128, "plio">) attributes {outArgs = [3 : i32], top_func = "plio"} {
    call @ttmc_pl(%arg0, %arg1, %arg2, %arg3, %arg4, %arg5, %arg6, %arg7, %arg8, %arg9, %arg10, %arg11, %arg12, %arg13, %arg14, %arg15, %arg16, %arg17, %arg18, %arg19, %arg20, %arg21, %arg22, %arg23, %arg24, %arg25, %arg26, %arg27, %arg28, %arg29, %arg30, %arg31, %arg32, %arg33, %arg34, %arg35, %arg36, %arg37, %arg38, %arg39, %arg40, %arg41, %arg42, %arg43, %arg44, %arg45, %arg46, %arg47, %arg48, %arg49, %arg50, %arg51, %arg52, %arg53, %arg54, %arg55, %arg56, %arg57, %arg58, %arg59, %arg60, %arg61, %arg62, %arg63, %arg64, %arg65, %arg66, %arg67, %arg68, %arg69, %arg70, %arg71, %arg72, %arg73, %arg74, %arg75, %arg76, %arg77, %arg78, %arg79, %arg80, %arg81, %arg82, %arg83, %arg84, %arg85, %arg86, %arg87, %arg88, %arg89, %arg90, %arg91, %arg92, %arg93, %arg94, %arg95, %arg96, %arg97, %arg98, %arg99, %arg100, %arg101, %arg102, %arg103, %arg104, %arg105, %arg106, %arg107, %arg108, %arg109, %arg110, %arg111, %arg112, %arg113, %arg114, %arg115, %arg116, %arg117, %arg118, %arg119, %arg120, %arg121, %arg122, %arg123, %arg124, %arg125, %arg126, %arg127, %arg128, %arg129, %arg130, %arg131, %arg132, %arg133) : (memref<4x1024x256xi512>, memref<1024x32xi512>, memref<4096x48xi512>, memref<4x512x48xi512>, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">, memref<1xi128, "plio">) -> ()
    return
  }
  func.func @ttmc_host(%arg0: memref<4x1024x4096xi32>, %arg1: memref<1024x512xi32>, %arg2: memref<4096x768xi32>, %arg3: memref<4x512x768xi32>) attributes {origin_func = "ttmc"} {
    affine.for %arg4 = 0 to 4 {
      affine.for %arg5 = 0 to 512 {
        affine.for %arg6 = 0 to 768 {
          affine.for %arg7 = 0 to 1024 {
            affine.for %arg8 = 0 to 4096 {
              %0 = affine.load %arg0[%arg4, %arg7, %arg8] : memref<4x1024x4096xi32>
              %1 = affine.load %arg1[%arg7, %arg5] : memref<1024x512xi32>
              %2 = affine.load %arg2[%arg8, %arg6] : memref<4096x768xi32>
              %3 = arith.muli %0, %1 : i32
              %4 = arith.muli %3, %2 : i32
              %5 = affine.load %arg3[%arg4, %arg5, %arg6] : memref<4x512x768xi32>
              %6 = arith.addi %5, %4 : i32
              affine.store %6, %arg3[%arg4, %arg5, %arg6] : memref<4x512x768xi32>
            } {reduction}
          } {reduction}
        }
      }
    }
    return
  }
  func.func @top_host(%arg0: memref<4x1024x4096xi32>, %arg1: memref<1024x512xi32>, %arg2: memref<4096x768xi32>, %arg3: memref<4x512x768xi32>) attributes {origin_func = "top", outArgs = [3 : i32], top_host} {
    call @ttmc_host(%arg0, %arg1, %arg2, %arg3) {origin_func = "ttmc"} : (memref<4x1024x4096xi32>, memref<1024x512xi32>, memref<4096x768xi32>, memref<4x512x768xi32>) -> ()
    return
  }
}

