import numpy as np
import random


PLIO_WIDTH = 128
BPE = 4

############ Helper functions
def sim_gen(data_in, BPE, plio_width, filename):
  data_per_col = (plio_width // 8) // BPE
  if data_in.ndim != 1:
    assert("Must transpose to one dim array before generating files")
  size = data_in.size
  with open(filename, 'w') as file:
    for i in range(size):
      data = data_in[i]
      file.write(f"{data}")
      if(i==size-1):
        continue
      elif((i+1)%data_per_col==0):
        file.write("\n")
      else:
        file.write(" ")

def readFile(filename):
  rows = []
  # Open and read the file line by line
  with open(filename, 'r') as file:
    for line in file:
      if line.strip() and not any(char.isalpha() for char in line):
        row = list(map(float, line.split()))
        rows.append(row)
  array = np.array(rows)
  return array

def verification(file_sw, file_hw):
  array_sw = readFile(file_sw)
  array_hw = readFile(file_hw)
  flag = np.allclose(array_sw, array_hw)
  if flag:
    print("Test Passed\n")
  else:
    print("Test Failed\n")

def result_verify(file_out, file_final, file_golden):
  array_hw = readFile(file_out)
  array_hw_1d = array_hw.reshape(-1)
  sim_gen(array_hw_1d, BPE, PLIO_WIDTH, file_final)
  verification(file_golden, file_final)

############ matmul: C(i, j)+ = A(i, k) * B(k, j)
def matmul(I, J, K, BPE):
  np.random.seed(0)
  data_0 = np.random.randint(0, 3, size=(I, K))
  data_1 = np.random.randint(0, 3, size=(K, J))
  data_result = np.matmul(data_0, data_1)
  if(BPE==1): #Need to do reshape for int8
    data_0_1d = np.vstack(np.split(data_0, K//8, axis=1)).reshape(-1)
    data_1_1d = np.vstack(np.split(data_1, J//8, axis=1)).reshape(-1)
    data_result_1d = np.vstack(np.split(data_result, J//8, axis=1)).reshape(-1)
  else:
    data_0_1d = data_0.reshape(-1)
    data_1_1d = data_1.reshape(-1)
    data_result_1d = data_result.reshape(-1)
  return data_0_1d, data_1_1d, data_result_1d

def matmul_gen(file_lhs, file_rhs, file_golden, BPE):
  data_0_1d, data_1_1d, data_result_1d = matmul(32, 32, 32, BPE)
  sim_gen(data_0_1d, BPE, PLIO_WIDTH, file_lhs)
  sim_gen(data_1_1d, BPE, PLIO_WIDTH, file_rhs)
  sim_gen(data_result_1d, BPE, PLIO_WIDTH, file_golden)
  
############ mttkrp: D(i, j)+ = A(i, k, l) * B(k, j) * C(l, j)
def mttkrp(I, J, K, L):
  np.random.seed(0)
  data_0 = np.random.randint(0, 3, size=(I, K, L))
  data_1 = np.random.randint(0, 3, size=(K, J))
  data_2 = np.random.randint(0, 3, size=(L, J))
  data_result = np.zeros([I, J])
  data_0_1d = data_0.reshape(-1)
  data_1_1d = data_1.reshape(-1)
  data_2_1d = data_2.reshape(-1)
  for i in range(I):
    for j in range(J):
      for k in range(K):
        for l in range(L):
          #print(f"D[i][j] = A[i][k][l] * C[l][j] * B[k][j], D[{i}][{j}] = A[{i}][{k}][{l}] * C[{l}][{j}] * B[{k}][{j}]")
          data_result[i,j] = data_result[i,j] + data_0[i,k,l] * data_1[k,j] * data_2[l,j]
  data_result_1d = data_result.reshape(-1)
  return data_0_1d, data_1_1d, data_2_1d, data_result_1d

def mttkrp_gen(file_0, file_1, file_2, file_golden):
  data_0_1d, data_1_1d, data_2_1d, data_result_1d = mttkrp(2, 32, 16, 32)
  sim_gen(data_0_1d, BPE, PLIO_WIDTH, file_0)
  sim_gen(data_1_1d, BPE, PLIO_WIDTH, file_1)
  sim_gen(data_2_1d, BPE, PLIO_WIDTH, file_2)
  sim_gen(data_result_1d, BPE, PLIO_WIDTH, file_golden)

############ ttmc: D(i, j, k)+ = A(i, l, m) * B(l, j) * C(m, k)
def ttmc(I, J, K, L, M):
  np.random.seed(0)
  data_0 = np.random.randint(0, 3, size=(I, L, M))
  data_1 = np.random.randint(0, 3, size=(L, J))
  data_2 = np.random.randint(0, 3, size=(M, K))
  data_result = np.zeros([I, J, K])
  data_0_1d = data_0.reshape(-1)
  data_1_1d = data_1.reshape(-1)
  data_2_1d = data_2.reshape(-1)
  for i in range(I):
    for j in range(J):
      for k in range(K):
        for l in range(L):
          for m in range(M):
            #print(f"D[i][j][k]  = A[i][l][m] * B[l][j] * C[m][k], D[{i}][{j}][{k}] = A[{i}][{l}][{m}] * B[{l}][{j}] * C[{m}][{k}]")
            data_result[i, j, k] = data_result[i, j, k] + data_0[i,l,m] * data_1[l,j] * data_2[m,k]
  data_result_1d = data_result.reshape(-1)
  return data_0_1d, data_1_1d, data_2_1d, data_result_1d

def ttmc_gen(file_0, file_1, file_2, file_golden):
  data_0_1d, data_1_1d, data_2_1d, data_result_1d = ttmc(2, 16, 16, 16, 32)
  sim_gen(data_0_1d, BPE, PLIO_WIDTH, file_0)
  sim_gen(data_1_1d, BPE, PLIO_WIDTH, file_1)
  sim_gen(data_2_1d, BPE, PLIO_WIDTH, file_2)
  sim_gen(data_result_1d, BPE, PLIO_WIDTH, file_golden)

test_case=0
verfify = False

if test_case==0: #matmul
  file_0 = 'data/v0.txt'
  file_1 = 'data/v1.txt'
  file_out = 'aiesimulator_output/data/v2.txt'
  file_final = 'data/v2.txt'
  file_golden = 'data/golden.txt'
  matmul_gen(file_0, file_1, file_golden, BPE)
  if verfify:
    result_verify(file_out, file_final, file_golden)
elif test_case==1: #mttkrp
  file_0 = 'data/v0.txt'
  file_1 = 'data/v1.txt'
  file_2 = 'data/v2.txt'
  file_out = 'aiesimulator_output/data/v3.txt'
  file_final = 'data/v3.txt'
  file_golden = 'data/golden.txt'
  mttkrp_gen(file_0, file_1, file_2, file_golden)
  if verfify:
    result_verify(file_out, file_final, file_golden)
elif test_case==2: #ttmc
  file_0 = 'data/v0.txt'
  file_1 = 'data/v1.txt'
  file_2 = 'data/v2.txt'
  file_out = 'aiesimulator_output/data/v3.txt'
  file_final = 'data/v3.txt'
  file_golden = 'data/golden.txt'
  ttmc_gen(file_0, file_1, file_2, file_golden)
  if verfify:
    result_verify(file_out, file_final, file_golden)
   