# encoding utf-8
# python 3.10

import numpy as np
import matplotlib.pyplot as plt

# 定义有限长序列
x = np.array([0, 1, 2, 3])

# 计算 DTFT
N = len(x)
w = np.linspace(-np.pi, np.pi, num=N, endpoint=False)
X = np.zeros_like(w, dtype=np.complex128)
for k in range(N):
    X += x[k] * np.exp(-1j * w * k)

# 绘制幅度谱
plt.subplot(2, 1, 1)
plt.stem(w, np.abs(X))
plt.title('DTFT Amplitude Spectrum')
plt.xlabel('$ \omega $')
plt.ylabel('$ |X(e^{j\omega})| $')

# 对 X(e^{jω}) 进行采样
k = np.arange(N)
omega = 2 * np.pi * k / N
X_sampled = X[k]

# 绘制采样后的图像
plt.subplot(2, 1, 2)
plt.stem(omega, np.abs(X_sampled))
plt.title('Sampled DTFT Amplitude Spectrum')
plt.xlabel('$ \omega $')
plt.ylabel('$ |X(e^{j\omega})| $')

plt.show()
