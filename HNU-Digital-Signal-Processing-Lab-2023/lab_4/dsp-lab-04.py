# encoding utf-8
# python 3.10

import numpy as np
import matplotlib.pyplot as plt

# 设定窗函数的长度
N = 21

# 生成窗函数的序列
n = np.arange(N)
w = 0.5 - 0.5 * np.cos(2 * np.pi * n / (N - 1))

# 生成理想差分器的序列
hd = 1 / ((np.pi * n) * np.sin(np.pi * n) + 0.00001)
hd[N // 2] = 1  # 处理 n = 0 的情况

# 生成加窗后的差分器的序列
h = w * hd

# 绘制时域响应波形
plt.subplot(3, 1, 1)
plt.stem(n, h)
plt.xlabel('$n$')
plt.ylabel('$h(n)$')
plt.title('Impulse response of the windowed differentiator')
plt.grid(True)

# 计算频域响应
omega = np.linspace(-np.pi, np.pi, 1024)  # 频率范围
H = np.fft.fftshift(np.fft.fft(h, 1024))  # 傅里叶变换
mag = np.abs(H)  # 模值
phase = np.angle(H)  # 相位

# 绘制频域响应的模值
plt.subplot(3, 1, 2)
plt.plot(omega, mag)
plt.xlabel('$\omega$(rad)')
plt.ylabel('$|H(e^{j\omega})|$')
plt.title('Magnitude response of the windowed differentiator')
plt.grid(True)

# 绘制频域响应的相位
plt.subplot(3, 1, 3)
plt.plot(omega, phase)
plt.xlabel('$\omega$(rad)')
plt.ylabel('angle($H(e^{j\omega})$)')
plt.title('Phase response of the windowed differentiator')
plt.grid(True)

# 显示图形
plt.show()
