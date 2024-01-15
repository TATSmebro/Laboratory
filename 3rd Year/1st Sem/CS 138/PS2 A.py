import numpy as np
from math import tan, atan as cot

#Initialize list of x values
x = []
val = 30
h = 0.3
alpha = 0
beta = 5

for i in range(101):
    x.append(val)
    val += h

x[-1] = 60 #change last element to be precisely 60

p = -0.7

# functions
def q(x):
    return -(3 * cot(x) + 2 * tan(x))

def coeffyminus1(x):
    return 1 + h/2 * (q(x))

def coeffy():
    return -(2 + h**2 * p)

def coeffyplus1(x):
    return 1 - h/2 * (q(x))

#construct matrix at the right-hand side of the equation
#inner nodes are 0 since r(x) = 0
matB = np.array([alpha] + [0]*99 + [beta])


#construct matrix A
matA = np.zeros((101, 101))
matA[0][0] = 1
matA[100][100] = 1

for i in range(1, 100):
    matA[i][i-1] = coeffyminus1(x[i])
    matA[i][i] = coeffy()
    matA[i][i+1] = coeffyplus1(x[i])

y = np.linalg.solve(matA, matB)
print(y.tolist())