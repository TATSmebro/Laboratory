import numpy as np
from math import sqrt, tan, atan as cot

x0 = 30
xN = 60
h = (xN - x0)/(10-1)
alpha = 0
beta = 5
sigma = 50
n = 50 # total number of points, collocation points = n - 2

# construct x equidistant points
x = []
val = 30

for i in range(n):
    x.append(val)
    val += h

x[-1] = 60

def p(x):
    return 0.7

def r(x):
    return 0

def q(x):
    return -(3 * cot(x) + 2 * tan(x))

def phi(x, xj):
    return sqrt((x - xj)**2 + sigma**2)

def phi1(x, xj):
    return (x - xj) / phi(x, xj)

def phi2(x, xj):
    return (sigma**2) / (phi(x, xj)**3)

def Lphi(x, xj):
    return phi2(x, xj) + p(x) * phi1(x, xj) + q(x) * phi(x, xj)

# Construct matrix on left-hand side.
matA = np.zeros((n, n))

# first row
for j in range(n):
    matA[0][j] = phi(x[0], x[j])

# 5 collocation points
for i in range(n):
    for j in range(n):
        matA[i][j] = Lphi(x[i], x[j])

# last row
for j in range(n):
    matA[-1][j] = phi(x[-1], x[j])


# Construct matrix on right-hand side
matB = np.array([alpha] + [0]*(n-2) + [beta])

a = np.linalg.solve(matA, matB) # Coeffiecients

# x with smaller intervals for computation of y
x2 = []
val2 = 30
h2 = (xN - x0)/(101-1)
for i in range(101):
    x2.append(val2)
    val2 += h2

x2[-1] = 60
print(x2)

# Construct y
y = np.zeros(101)
for i in range(len(y)):
    yi = 0
    for j in range(n):
        yi += a[j] * phi(x2[i], x[j])
    
    y[i] = yi

print(y.tolist())


