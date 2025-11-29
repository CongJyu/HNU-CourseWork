# encoding utf-8
# python 3.10

import numpy as np
from matplotlib import pyplot as plt


def dft(x):
    N = len(x)
    n = np.arange(N)
    k = n.reshape((N, 1))
    M = np.exp(-2j * np.pi * k * n / N)
    return np.dot(M, x)


# 基-2 FFT 算法
def fft(x):
    N = len(x)
    if N <= 1:
        return x
    even = fft(x[::2])
    odd = fft(x[1::2])
    T = np.exp(-2j * np.pi * np.arange(N) / N)
    return np.concatenate([even + T[:N // 2] * odd, even + T[N // 2:] * odd])


# 测试
n = np.arange(1024)
x = np.exp(1j * 0.48 * np.pi * n) + np.exp(1j * 0.52 * np.pi * n)
x[128:1024] = 0

'''
print("序列 x: ", x)
print("DFT: ", dft(x))  # 验证算法正确性
print("FFT: ", fft(x))
'''

plt.figure('离散')

plt.subplot(2, 1, 1)
plt.stem(n, np.abs(dft(x)))
plt.title('Use DFT straightly (Compare)')
plt.ylabel('DFT[x(n)]')

plt.subplot(2, 1, 2)
plt.stem(n, np.abs(fft(x)))
plt.title('Use Base-2 FFT Algorithm')
plt.ylabel('FFT[x(n)]')

plt.show()

plt.figure('连续')

plt.subplot(2, 1, 1)
plt.plot(n, np.abs(dft(x)))
plt.title('Use DFT straightly (Compare)')
plt.ylabel('DFT[x(n)]')

plt.subplot(2, 1, 2)
plt.plot(n, np.abs(fft(x)))
plt.title('Use Base-2 FFT Algorithm')
plt.ylabel('FFT[x(n)]')

plt.show()
