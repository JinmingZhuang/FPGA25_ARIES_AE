import os
import sys
directory = os.path.dirname(os.path.abspath(__file__)) + "/../../"
sys.path.append(directory)
from frontend import *

# ----------------------------
# Example usage
# ----------------------------
I, J, K, L, M = TypeVar("I"), TypeVar("J"), TypeVar("K"), TypeVar("L"), TypeVar("M")

# TTMc: D[i0, j0, k0] += A[i0, l0, m0] * B[l0, j0] * C[m0, k0]
@task_tile()
def ttmc(A: int32[I, L, M], B: int32[L, J], C: int32[M, K], D: int32[I, J, K]):

    i, j, k, l, m = tile_ranks()
    TI, TJ, TK, TL, TM = tile_sizes()

    ti = arange(i*TI, (i+1)*TI)
    tj = arange(j*TJ, (j+1)*TJ)
    tk = arange(k*TK, (k+1)*TK)
    tl = arange(l*TL, (l+1)*TL)
    tm = arange(m*TM, (m+1)*TM)

    A_L1: int32[TI, TL, TM] = A[ti, tl, tm]
    B_L1: int32[TL, TJ] = B[tl, tj]
    C_L1: int32[TM, TK] = C[tm, tk]
    D_L1: int32[TI, TJ, TK] = D[ti, tj, tk]

    for i0 in range(0, TI):
        for j0 in range(0, TJ):
            for k0 in range(0, TK):
                for l0 in reduction_range(0, TL): # reduction
                    for m0 in reduction_range(0, TM): # reduction
                        D_L1[i0, j0, k0] += A_L1[i0, l0, m0] * B_L1[l0, j0] * C_L1[m0, k0]


def app_ttmc():
    I, J, K, L, M = 4, 512, 768, 1024, 4096
    TI, TJ, TK, TL, TM = 2, 16, 16, 16, 32

    grid, size = (I/TI, J/TJ, K/TK, L/TL, M/TM), (TI, TJ, TK, TL, TM)

    A = np.random.rand(I, L, M)
    W0 = np.random.rand(L, J)
    W1 = np.random.rand(M, K)
    B = np.zeros((I, J, K))

    task0 = ttmc[grid, size](A, W0, W1, B)
    sch = Schedule(task0)
    code, _ = sch.build(target=VCK190)
    print(code)
    return


if __name__ == "__main__":
    app_ttmc()