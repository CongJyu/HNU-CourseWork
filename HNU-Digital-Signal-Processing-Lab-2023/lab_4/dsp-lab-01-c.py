# encoding utf-8
# python 3.10

# 导入必要的模块
import numpy as np
import matplotlib.pyplot as plt
from scipy import signal

# 定义单位抽样响应 h(n)
h = np.array([-4, 1, -1, -2, 5, 0, -5, 2, 1, -1, 4])

# 计算系统函数 H(z) 的分子和分母多项式系数
b = np.flip(h)  # 分子系数为 h(n) 的逆序
a = np.zeros(12)  # 分母系数为 z^11
a[0] = 1

# 计算幅度频率响应 |H(w)| 的 dB 值
w, h = signal.freqz(b, a)  # 计算系统函数在单位圆上的复数值
h_dB = 20 * np.log10(np.abs(h))  # 计算幅度的 dB 值

# 绘制幅度频率响应的波形
plt.subplot(2, 2, 1)  # 在 2x2 的画布中选择第一个位置
plt.plot(w / np.pi, h_dB)  # 以 pi 为单位绘制 x 轴，以 dB 为单位绘制 y 轴
plt.ylabel('Magnitude (dB)')  # 设置 y 轴的标签
plt.title('Frequency response of FIR filter')  # 设置标题
plt.grid(True)

plt.subplot(2, 2, 2)
plt.stem(np.array([-4, 1, -1, -2, 5, 0, -5, 2, 1, -1, 4]))
plt.xlabel('$n$')
plt.ylabel('$h(n)$')
plt.grid(True)

# 绘制系统函数波形和零极点图
plt.subplot(2, 2, 3)  # 在 2x2 的画布中选择第三个位置
plt.plot(w / np.pi, np.real(h), 'r')  # 以 pi 为单位绘制 x 轴，以实部为单位绘制 y 轴
plt.plot(w / np.pi, np.imag(h), 'g')  # 以 pi 为单位绘制 x 轴，以虚部为单位绘制 y 轴
plt.ylabel('Real/Imaginary part')  # 设置 y 轴的标签
plt.xlabel('Normalized frequency')  # 设置 x 轴的标签
plt.grid(True)

plt.subplot(2, 2, 4)
z, p, k = signal.tf2zpk(b, a)  # 计算系统函数的零点、极点和增益
plt.plot(np.real(z), np.imag(z), 'o', label='Zeros')  # 绘制零点
plt.plot(np.real(p), np.imag(p), 'x', label='Poles')  # 绘制极点
plt.legend()  # 显示图例
plt.title('Zeros and poles of system function')  # 设置标题
plt.xlabel('Real part')  # 设置 x 轴的标签
plt.ylabel('Imaginary part')  # 设置 y 轴的标签
plt.grid()  # 显示网格
plt.axis('equal')  # 设置 x 轴和 y 轴的比例相等

plt.show()  # 显示图形
