# encoding utf-8
# python 3.10

import numpy as np

# 定义序列x(n)
n = np.arange(0, 8)
x = 0.9 ** n * ((n >= 0) & (n <= 8))

# 定义DFT矩阵W
N = 8
W = np.fft.fft(np.eye(N))

# 计算DFT
X = np.dot(W, x)

# 输出结果
print(X)
