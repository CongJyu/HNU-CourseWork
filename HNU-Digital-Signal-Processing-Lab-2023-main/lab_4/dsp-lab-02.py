# encoding utf-8
# python 3.10

import numpy as np
import numpy.fft as fft
import scipy.signal as signal
import matplotlib.pyplot as plt

# 设定滤波器的参数
N = 21  # 滤波器的阶数
wc = 0.05 * np.pi  # 截止频率
n = np.arange(N)  # 时域序列
w = 0.54 - 0.46 * np.cos(2 * np.pi * n / (N - 1))  # 海明窗

# 计算滤波器的抽样响应
h = wc / np.pi * np.sinc(wc / np.pi * (n - (N - 1) / 2)) * w

# 绘制滤波器的抽样响应
plt.subplot(3, 2, 1)
plt.stem(n, h)
plt.xlabel('n')
plt.ylabel('h(n)')
plt.title('Impulse response of the FIR filter')
plt.grid(True)

# 计算滤波器的频率响应
H = fft.fft(h, 512)  # 用 512 点 FFT
omega = np.linspace(-np.pi, np.pi, 512)  # 频率范围

# 绘制滤波器的频率响应的幅度
plt.subplot(3, 2, 3)
plt.plot(omega, 20 * np.log10(np.abs(H)))
plt.xlabel('omega (rad)')
plt.ylabel('Magnitude (dB)')
plt.title('Magnitude response of the FIR filter')
plt.grid(True)

# 绘制滤波器的频率响应的相位
plt.subplot(3, 2, 5)
plt.plot(omega, np.angle(H))
plt.xlabel('omega (rad)')
plt.ylabel('Phase (rad)')
plt.title('Phase response of the FIR filter')
plt.grid(True)

# 定义输入信号 x(n)
x = np.ones(10)

# 计算输出信号 y(n)
y = signal.convolve(h, x)  # 利用卷积函数

# 绘制输入信号和输出信号的波形图
plt.subplot(2, 2, 2)  # 上半部分画输入信号
plt.stem(x)
plt.xlabel('n')
plt.ylabel('x(n)')
plt.title('Input signal')

plt.subplot(2, 2, 4)  # 下半部分画输出信号
plt.stem(y)
plt.xlabel('n')
plt.ylabel('y(n)')
plt.title('Output signal')

plt.tight_layout()  # 调整子图的间距

plt.show()
