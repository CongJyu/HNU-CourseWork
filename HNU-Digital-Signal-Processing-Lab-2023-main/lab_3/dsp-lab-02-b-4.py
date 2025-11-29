# encoding utf-8
# python 3.10

# 导入所需的库
import numpy as np
import matplotlib.pyplot as plt
from scipy import signal

# 定义滤波器的分子和分母系数
b = [0.0001, 0.0004, 0.0006, 0.0004, 0.0001]
a = [1, -3.741, 5.257, -3.161, 0.646]

# 计算滤波器的频率响应
w, h = signal.freqz(b, a)

plt.rcParams['font.sans-serif'] = ['Unifont']
plt.rcParams['axes.unicode_minus'] = False

# 绘制滤波器的幅频特性曲线
plt.subplot(211)
plt.plot(w / np.pi, 20 * np.log10(abs(h)))
plt.xlabel('归一化频率')
plt.ylabel('增益(dB)')
plt.title('数字低通滤波器的幅频特性')
plt.grid()

# 绘制滤波器的相频特性曲线
plt.subplot(212)
plt.plot(w / np.pi, np.angle(h))
plt.xlabel('归一化频率')
plt.ylabel('相位(rad)')
plt.title('数字低通滤波器的相频特性')
plt.grid()

# 显示图像
plt.show()
