# encoding utf-8
# python 3.10

# 导入所需的模块
import numpy as np
import matplotlib.pyplot as plt
from scipy.signal import cheby1, freqz, cheb1ord

# 定义滤波器的参数
fs = 8000  # 采样频率
fpass = 1000  # 通带截止频率
fstop = 1400  # 阻带截止频率
rp = 2  # 通带最大衰减
rs = 20  # 阻带最小衰减
nyq = fs / 2  # 奈奎斯特频率
wp = fpass / nyq  # 通带截止频率的归一化值
ws = fstop / nyq  # 阻带截止频率的归一化值

# 设计切比雪夫 I 型低通滤波器，返回滤波器的阶数和系数
n, wn = cheb1ord(wp, ws, rp, rs)  # 计算滤波器的阶数和临界频率
b, a = cheby1(N=n, rp=rp, Wn=wn, btype='low',
              analog=False, output='ba')  # 计算滤波器的分子和分母系数

# 计算滤波器的频率响应
w, h = freqz(b, a, worN=8000)  # 返回滤波器的频率和复数增益
f = w * nyq / np.pi  # 将频率转换为赫兹
mag = 20 * np.log10(np.abs(h))  # 将增益转换为分贝
phase = np.angle(h)  # 计算相位

# 绘制滤波器的幅频特性图
plt.subplot(2, 1, 1)
plt.plot(f, mag, 'b')  # 用蓝色线条绘制幅度曲线
plt.title('Chebyshev Type-I Filter Amptitude Response')  # 设置标题
plt.xlabel('Frequency (Hz)')  # 设置x轴标签
plt.ylabel('Gain (dB)')  # 设置y轴标签
plt.ylim(-60, 5)  # 设置y轴范围
plt.grid()  # 显示网格线
plt.axvline(fpass, color='k')  # 用黑色线条绘制通带截止频率
plt.axvline(fstop, color='k')  # 用黑色线条绘制阻带截止频率
plt.axhline(-rp, color='k')  # 用黑色线条绘制通带最大衰减
plt.axhline(-rs, color='k')  # 用黑色线条绘制阻带最小衰减

# 绘制滤波器的相频特性图
plt.subplot(2, 1, 2)
plt.plot(f, phase, 'b')  # 用蓝色线条绘制相位曲线
plt.title('Chebyshev Type-I Filter Phase Response')  # 设置标题
plt.xlabel('Frequency (Hz)')  # 设置x轴标签
plt.ylabel('Phase (rad)')  # 设置y轴标签
plt.grid()  # 显示网格线
plt.tight_layout()  # 调整子图间距
plt.show()  # 显示图像
