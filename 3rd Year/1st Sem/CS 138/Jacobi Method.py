# Import Libraries here
import numpy as np
import plotly.express as px # https://plotly.com/python/line-charts/
import pandas as pd # https://www.geeksforgeeks.org/create-a-pandas-dataframe-from-lists/

#Alternatively, you may use Matplotlib. However, make sure that your figures are scaled properly.
import matplotlib.pyplot as plt
import warnings

warnings.filterwarnings("ignore")

def generate_matrix(n):
  D = np.zeros((n, n))
  C = np.zeros((n, n))
  S = np.zeros((n, n))
  x = np.ones((n, 1))
  for i in range(1, n+1):
    for j in range(1, n+1):
      # For D Matrix
      if (j==i-1):
        D[i-1, j-1] = n + 1 - i
      elif (j>=i):
        D[i-1, j-1] = n + 1 -j

      # For C Matrix
      if (i==j):
        C[i-1, j-1] = -2
      elif (abs(j-i)==1):
        C[i-1, j-1] = 1
      elif (abs(j-i)>1):
        C[i-1, j-1] = 0

      # For S Matrix
      S[i-1, j-1] = 1/(i+j-1)
  D_b =np.dot(D, x).reshape(n)
  C_b =np.dot(C, x).reshape(n)
  S_b =np.dot(S, x).reshape(n)
  return (D, D_b), (C, C_b), (S, S_b) # Change this

def jacobi(M, b, n, epsilon):
  x = [0] * n # an initial guess at the solution - here just a vector of zeros of length the number of rows in A
  it_max = 1000 # upper limit on iterations if we don't hit tolerance
  residuals = [] # store residuals

  for _ in range(it_max):
    residual = np.linalg.norm(b-np.dot(M, x))  # calculate the norm of the residual r=b-Ax for this latest guess
    residuals.append(residual) # store it for later plotting
    
    if (residual < epsilon): # if less than our required tolerance jump out of the iteration and end.
      break

    x_new = np.zeros(n)  # initialise the new solution vector
    
    for i in range(n):
      x_new[i] = (1./M[i, i]) * (b[i] - np.dot(M[i, :i], x[:i]) - np.dot(M[i, i + 1:], x[i + 1:]))

    x = x_new # update old solution

  return x

n_D, n_C, n_S = [10, 15, 20, 25], [10, 40, 160, 200], [10, 15, 20, 25]
D_matrices, C_matrices, S_matrices = [], [], []
for n in n_D:
  D_matrices.append(generate_matrix(n)[0])
for n in n_C:
  C_matrices.append(generate_matrix(n)[1])
for n in n_S:
  S_matrices.append(generate_matrix(n)[2])

size = []
determinants = []
residuals = []
error = []
condNum = []
sols = []

for D_mat, n in zip(D_matrices, n_D):
  x = jacobi(D_mat[0], D_mat[1], n, 1.e-5)
  solVector = np.ones(n)

  size.append(n)
  determinants.append(np.linalg.det(D_mat[0]))
  error.append(np.linalg.norm(np.subtract(x, solVector)))
  residuals.append(np.linalg.norm(np.subtract(D_mat[1], np.dot(D_mat[0], x))))
  condNum.append(np.linalg.cond(D_mat[0]))
  sols.append(x)

print(f'Error: {error}')
print(f'Residuals: {residuals}')
print(f'Solutions for D: {sols}')
print(D_matrices)

size = []
determinants = []
residuals = []
error = []
condNum = []
sols = []

for C_mat, n in zip(C_matrices, n_C):
  x = jacobi(C_mat[0], C_mat[1], n, 1.e-5)
  solVector = np.ones(n)

  size.append(n)
  determinants.append(np.linalg.det(C_mat[0]))
  error.append(np.linalg.norm(np.subtract(x, solVector)))
  residuals.append(np.linalg.norm(np.subtract(C_mat[1], np.dot(C_mat[0], x))))
  condNum.append(np.linalg.cond(C_mat[0]))
  sols.append(x)

size = []
determinants = []
residuals = []
error = []
condNum = []
sols = []

for S_mat, n in zip(S_matrices, n_S):
  x = jacobi(S_mat[0], S_mat[1], n, 1.e-5)
  solVector = np.ones(n)

  size.append(n)
  determinants.append(np.linalg.det(S_mat[0]))
  error.append(np.linalg.norm(np.subtract(x, solVector)))
  residuals.append(np.linalg.norm(np.subtract(S_mat[1], np.dot(S_mat[0], x))))
  condNum.append(np.linalg.cond(S_mat[0]))
  sols.append(x)

print(f'Error: {error}')
print(f'Residuals: {residuals}')
print(f'Solutions for S: {sols}')
print(S_matrices)

