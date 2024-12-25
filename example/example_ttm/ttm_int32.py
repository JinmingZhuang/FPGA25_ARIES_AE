import os
import sys
directory = os.path.dirname(os.path.abspath(__file__)) + "/../../"
sys.path.append(directory)
from frontend import *

# ----------------------------
# Example usage
# ----------------------------
I, J, K, L = TypeVar("I"), TypeVar("J"), TypeVar("K"), TypeVar("L")

# =========== tensor times matrix : C[i0, j0, k0] += A[i0, j0, l0] * B[l0, k0]
@task_tile()
def ttm(A: int32[I, J, L], B: int32[L, K], C: int32[I, J, K]):

    i, j, k, l = tile_ranks()
    TI, TJ, TK, TL = tile_sizes()

    ti = arange(i*TI, (i+1)*TI)
    tj = arange(j*TJ, (j+1)*TJ)
    tk = arange(k*TK, (k+1)*TK)
    tl = arange(l*TL, (l+1)*TL)

    A_L1: int32[TI, TJ, TL] = A[ti, tj, tl]
    B_L1: int32[TL, TK] = B[tl, tk]
    C_L1: int32[TI, TJ, TK] = C[ti, tj, tk]

    for i0 in range(0, TI):
        for j0 in range(0, TJ):
            for k0 in range(0, TK):
                for l0 in reduction_range(0, TL): # reduction
                    C_L1[i0, j0, k0] += A_L1[i0, j0, l0] * B_L1[l0, k0]

    C[ti, tj, tk] = C_L1


def app_ttm():
    I, J, K, L = 4, 1408, 1536, 8192
    TI, TJ, TK, TL = 1, 32, 32, 32

    grid, size = (I/TI, J/TJ, K/TK, L/TL), (TI, TJ, TK, TL)

    A = np.random.rand(I, J, L)
    W0 = np.random.rand(L, K)
    B = np.zeros((I, J, K))

    task0 = ttm[grid, size](A, W0, B)
    sch = Schedule(task0)
    code, _ = sch.build(target=VCK190)
    print(code)
    return


if __name__ == "__main__":
    app_ttm()