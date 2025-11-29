# encoding utf-8
# python 3.10

from scipy import signal
import matplotlib.pyplot as plt
import numpy as np

plt.rcParams['font.sans-serif'] = ['Unifont']
plt.rcParams['axes.unicode_minus'] = False

# 设计滤波器
fs = 1000  # 采样频率
f1 = 150  # 通带截止频率
f2 = 100  # 阻带截止频率
rp = 1  # 通带最大衰减
rs = 40  # 阻带最小衰减
wp = f1 / (fs / 2)  # 归一化通带截止频率
ws = f2 / (fs / 2)  # 归一化阻带截止频率
N, Wn = signal.buttord(wp, ws, rp, rs)  # 计算巴特沃斯滤波器的阶数和归一化截止频率
b, a = signal.butter(N, Wn, 'low')  # 生成巴特沃斯滤波器的系数

# 绘制幅度响应
w, h = signal.freqz(b, a)
plt.subplot(2, 2, 1)
plt.title('数字滤波器幅度响应')
plt.plot(w, 20 * np.log10(abs(h)), 'b')
plt.ylabel('幅度 [dB]', color='b')
plt.xlabel('频率 [rad/sample]')
plt.grid(True)

# 产生模拟信号x(n)的150个采样样本x(nT)
t = np.linspace(0, 0.3, 150, endpoint=False)
x_a = 5 * np.sin(200 * np.pi * t) + 2 * np.cos(300 * np.pi * t)
x = signal.resample(x_a, 1500)

# 将所得序列输入到a)中设计的IIR数字滤波器中，求滤波器的输出序列
y = signal.lfilter(b, a, x)

# 内插形成模拟输出信号y_a(t)
t_new = np.linspace(0, 0.3, 1500, endpoint=False)
y_a = np.interp(t_new, np.linspace(0, 0.3, 1500, endpoint=False), y)

# 绘制滤波器输入输出信号
plt.subplot(2, 2, 3)
plt.stem(t, x_a)
plt.title('输入信号采样')
plt.grid(True)

plt.subplot(2, 2, 2)
plt.plot(t, x_a)
plt.title('输入信号')
plt.grid(True)

plt.subplot(2, 2, 4)
plt.plot(t_new, y_a)
plt.title('输出信号')
plt.grid(True)

plt.show()
plt.subplot(2, 2, 2)
plt.plot(t, x_a)
plt.title('输入信号')
plt.grid(True)
