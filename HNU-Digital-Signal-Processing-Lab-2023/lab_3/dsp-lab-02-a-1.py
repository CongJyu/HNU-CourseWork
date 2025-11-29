# encoding utf-8
# python 3.10

import numpy as np
import matplotlib.pyplot as plt
from scipy import signal

# 定义滤波器的参数
f_pass = 1000  # 通带截止频率，单位为 Hz
f_stop = 1400  # 阻带截止频率，单位为 Hz
a_pass = 2  # 通带最大衰减，单位为 dB
a_stop = 20  # 阻带最小衰减，单位为 dB
f_samp = 8000  # 采样频率，单位为 Hz

# 计算归一化的截止频率
w_pass = f_pass / (f_samp / 2)
w_stop = f_stop / (f_samp / 2)

# 使用 signal.buttord 函数计算滤波器的阶数和自然截止频率
n, w_n = signal.buttord(w_pass, w_stop, a_pass, a_stop)

# 使用 signal.butter 函数设计巴特沃思低通滤波器
b, a = signal.butter(n, w_n, btype='low')

# 使用 signal.freqz 函数计算滤波器的频率响应
w, h = signal.freqz(b, a)

# 将弧度转换为频率
f = w * f_samp / (2 * np.pi)

# 计算幅频特性，单位为 dB
h_db = 20 * np.log10(abs(h))

# 计算相频特性，单位为度
h_phase = np.angle(h, deg=True)

# 绘制幅频和相频特性图
plt.figure('巴特沃思低通滤波器')
plt.subplot(2, 1, 1)
plt.plot(f, h_db)
plt.title('Amptitude')
plt.xlabel('Frequency (Hz)')
plt.ylabel('Gain (dB)')
plt.grid()
plt.subplot(2, 1, 2)
plt.plot(f, h_phase)
plt.title('Phase')
plt.xlabel('Frequency (Hz)')
plt.ylabel('Phase (Degree)')
plt.grid()
plt.show()
