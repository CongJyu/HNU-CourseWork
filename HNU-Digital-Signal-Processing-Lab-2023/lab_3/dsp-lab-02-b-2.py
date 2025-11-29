# encoding utf-8
# python 3.10

import numpy as np
import matplotlib.pyplot as plt
from scipy import signal

import numpy as np
from scipy import signal
import matplotlib.pyplot as plt

# 设定参数
fs = 8000  # 采样频率
wp = 1000  # 通带截止频率
ws = 1400  # 阻带截止频率
Ap = 2  # 通带最大衰减
As = 20  # 阻带最小衰减
T = 1/fs  # 采样周期

# 计算滤波器的阶数和临界频率
N = np.ceil(np.log10((10**(0.1*As)-1)/(10**(0.1*Ap)-1)) /
            (2*np.log10(ws/wp)))  # 向上取整
N = int(N)  # 转换为整数
wc = wp/np.sqrt(10**(0.1*Ap)-1)  # 模拟滤波器的临界频率

# 计算双线性变换法的常数
c = wc / 2 * (T + np.sqrt(T ** 2 + 4 * wc ** 2))/(T ** 2 + 4 * wc ** 2)

# 设计数字低通滤波器
b, a = signal.butter(N, c, btype='low', analog=False,
                     output='ba', fs=fs)  # 返回滤波器的系数

# 计算并绘制滤波器的频率响应
w, h = signal.freqz(b, a, worN=512, whole=False,
                    plot=None, fs=fs)  # 返回滤波器的频率响应

plt.figure(1)  # 创建一个新的图形
plt.subplot(2, 1, 1)  # 在2行1列的子图中选择第1个
plt.plot(w, 20*np.log10(abs(h)))  # 绘制幅频特性曲线
plt.title('Frequency response of the digital lowpass filter')  # 设置标题
plt.xlabel('Frequency [Hz]')  # 设置x轴标签
plt.ylabel('Magnitude [dB]')  # 设置y轴标签
plt.grid()  # 显示网格线

plt.subplot(2, 1, 2)  # 在2行1列的子图中选择第2个
plt.plot(w, np.angle(h))  # 绘制相频特性曲线
plt.xlabel('Frequency [Hz]')  # 设置x轴标签
plt.ylabel('Phase [rad]')  # 设置y轴标签
plt.grid()  # 显示网格线
plt.show()  # 显示图形
