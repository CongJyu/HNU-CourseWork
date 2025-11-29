# encoding utf-8
# python 3.10

# 导入必要的模块
import numpy as np
import matplotlib.pyplot as plt
from scipy.signal import butter, freqs, lfilter

# 设定滤波器的参数
n = 4  # 滤波器的阶数
wc = 9.9e3  # 截止角频率
ws = 16e3  # 阻带截止角频率
wp = 10e3  # 通带截止角频率
Ap = 1  # 通带最大衰减
As = 20  # 阻带最小衰减

# 计算滤波器的系数
b, a = butter(n, wc, 'low', analog=True)

# 计算滤波器的频率响应
w, h = freqs(b, a)

# 绘制滤波器的幅频响应图
plt.subplot(2, 1, 1)
plt.semilogx(w, 20 * np.log10(abs(h)))
plt.title('Analog LowPass Filter\'s Amptitude Frequency Response')
plt.xlabel('Frequency [rad/s]')
plt.ylabel('Gain [dB]')
plt.grid()
plt.axvline(wc, color='green', linestyle='dotted')  # 截止频率
plt.axhline(-Ap, color='red', linestyle='dotted')  # 通带最大衰减
plt.axhline(-As, color='blue', linestyle='dotted')  # 阻带最小衰减

# 绘制滤波器的相频响应图
plt.subplot(2, 1, 2)
plt.semilogx(w, np.angle(h))
plt.title('Analog LowPass Filter\'s Phase Frequency Response')
plt.xlabel('Frequency [rad/s]')
plt.ylabel('Phase [rad]')
plt.grid()
plt.show()
