# encoding utf-8
# python 3.10

# 导入库
import numpy as np
import scipy.signal as signal
import matplotlib.pyplot as plt

plt.rcParams['font.sans-serif'] = ['Unifont']
plt.rcParams['axes.unicode_minus'] = False

# 定义单位抽样响应
h = np.array([-4, 1, -1, -2, 5, 6, 6, 5, -2, -1, 1, -4])

# 计算系统函数
b = h  # 分子多项式系数
a = np.array([1])  # 分母多项式系数
H = np.poly1d(b) / np.poly1d(a)  # 用多项式对象表示系统函数

# 计算幅度频率响应
w, Hw = signal.freqz(b, a)  # 返回数字频率和复数频率响应
Hw_dB = 20 * np.log10(np.abs(Hw))  # 转换为 dB 单位

# 计算零极点
z, p, k = signal.tf2zpk(b, a)  # 返回零点、极点和增益

# 绘制波形和零极点图
plt.subplot(2, 2, 1)  # 第一个子图
plt.plot(w, Hw_dB)  # 绘制幅度频率响应
plt.xlabel('Frequency (rad/sample)')  # 设置 x 轴标签
plt.ylabel('Magnitude (dB)')  # 设置 y 轴标签
plt.title('Magnitude response')  # 设置标题
plt.grid()  # 显示网格线

plt.subplot(2, 2, 2)  # 第二个子图
plt.plot(w, np.angle(Hw))  # 绘制相位频率响应
plt.xlabel('Frequency (rad/sample)')  # 设置 x 轴标签
plt.ylabel('Phase (rad)')  # 设置 y 轴标签
plt.title('Phase response')  # 设置标题
plt.grid()  # 显示网格线

plt.subplot(2, 2, 3)
plt.stem(h)
plt.xlabel('$n$')
plt.ylabel('$h(n)$')
plt.title('系统函数')
plt.grid(True)

plt.subplot(2, 2, 4)  # 第四个子图
plt.plot(np.real(z), np.imag(z), 'o', label='Zeros')  # 绘制零点
plt.plot(np.real(p), np.imag(p), 'x', label='Poles')  # 绘制极点
plt.xlabel('Real part')  # 设置 x 轴标签
plt.ylabel('Imaginary part')  # 设置 y 轴标签
plt.title('Zeros and poles')  # 设置标题
plt.legend()  # 显示图例
plt.grid()  # 显示网格线
plt.tight_layout()  # 调整子图间距

plt.show()  # 显示图形
