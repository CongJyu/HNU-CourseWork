# encoding utf-8
# python 3.10

import numpy as np
import scipy.signal as sig
import matplotlib.pyplot as plt

# 设定滤波器的参数
n = [3, 4, 5, 6]  # 滤波器的阶数
wc = 9.9e3  # 截止角频率
ws = 16e3  # 阻带截止角频率
wp = 10e3  # 通带截止角频率
Ap = 1  # 通带最大衰减
As = 20  # 阻带最小衰减

b = [0, 0, 0, 0]
a = [0, 0, 0, 0]

# 计算滤波器的系数
for i in range(4):
    b[i], a[i] = sig.butter(n[i], wc, 'low', analog=True)

w = [0, 0, 0, 0]
h = [0, 0, 0, 0]

for j in range(4):
    w[j], h[j] = sig.freqs(b[j], a[j])


for plt_counter in range(4):
    # 绘制滤波器的幅频响应图
    plt.subplot(2, 4, plt_counter + 1)
    plt.semilogx(w[plt_counter], 20 * np.log10(abs(h[plt_counter])))
    plt.title('LowPass Filter\'s\nAmptitude Frequency Response')
    plt.xlabel('Frequency [rad/s]')
    plt.ylabel('Gain [dB]')
    plt.grid()
    # plt.axvline(wc, color='green', linestyle='dotted')  # 截止频率
    # plt.axhline(-Ap, color='red', linestyle='dotted')  # 通带最大衰减
    # plt.axhline(-As, color='blue', linestyle='dotted')  # 阻带最小衰减

    # 绘制滤波器的相频响应图
    plt.subplot(2, 4, plt_counter + 5)
    plt.semilogx(w[plt_counter], np.angle(h[plt_counter]))
    plt.title('LowPass Filter\'s\nPhase Frequency Response')
    plt.xlabel('Frequency [rad/s]')
    plt.ylabel('Phase [rad]')
    plt.grid()

plt.tight_layout()
plt.show()
