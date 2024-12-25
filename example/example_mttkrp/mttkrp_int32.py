import os
import sys
directory = os.path.dirname(os.path.abspath(__file__)) + "/../../"
sys.path.append(directory)
from frontend import *

# ----------------------------
# Example usage
# ----------------------------
I, J, K, L = TypeVar("I"), TypeVar("J"), TypeVar("K"), TypeVar("L")


# MTTKRP: D[i0, j0] += A[i0, k0, l0] * B[k0, j0] * C[l0, j0]
@task_tile()
def mttkrp(A: int32[I, K, L], B: int32[K, J], C: int32[L, J], D: int32[I, J]):

    i, j, k, l = tile_ranks()
    TI, TJ, TK, TL = tile_sizes()

    ti = arange(i*TI, (i+1)*TI)
    tj = arange(j*TJ, (j+1)*TJ)
    tk = arange(k*TK, (k+1)*TK)
    tl = arange(l*TL, (l+1)*TL)

    A_L1: int32[TI, TK, TL] = A[ti, tk, tl]
    B_L1: int32[TK, TJ] = B[tk, tj]
    C_L1: int32[TL, TJ] = C[tl, tj]
    D_L1: int32[TI, TJ] = D[ti, tj]

    for i0 in range(0, TI):
        for j0 in range(0, TJ):
            for k0 in reduction_range(0, TK):
                for l0 in reduction_range(0, TL):
                    D_L1[i0, j0] += A_L1[i0, k0, l0] * B_L1[k0, j0] * C_L1[l0, j0]
    D[ti, tj] = D_L1


def app_mttkrp():
    I, J, K, L = 64, 6144, 768, 2048
    TI, TJ, TK, TL = 2, 32, 16, 32

    grid, size = (I/TI, J/TJ, K/TK, L/TL), (TI, TJ, TK, TL)

    A = np.random.rand(I, K, L)
    W0 = np.random.rand(K, J)
    W1 = np.random.rand(L, J)
    B = np.zeros((I, J))

    task0 = mttkrp[grid, size](A, W0, W1, B)
    sch = Schedule(task0)
    code, _ = sch.build(target=VCK190)
    print(code)
    return


if __name__ == "__main__":
    app_mttkrp()