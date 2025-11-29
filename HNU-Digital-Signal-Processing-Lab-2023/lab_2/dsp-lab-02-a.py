# encoding utf-8
# python 3.10


# 定义序列x(n)
import numpy as np

n = np.arange(0, 8)
x = 0.9 ** n * ((n >= 0) & (n <= 8))

# 定义DFT的基本定义
N = 8
k = np.arange(0, N)
WN = np.exp(-1j * 2 * np.pi/N)

# 计算DFT
X = np.zeros(N, dtype=np.complex128)
for i in range(1, N+1):
    for j in range(1, N+1):
        X[i-1] += x[j-1] * WN**((i-1)*(j-1))

# 输出结果
print(X)
