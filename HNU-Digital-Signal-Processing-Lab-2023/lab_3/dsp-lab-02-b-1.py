# encoding utf-8
# python 3.10

import numpy as np
import matplotlib.pyplot as plt
from scipy import signal

# 定义数字滤波器的分子和分母系数
b = [0.0002, 0.0008, 0.0012, 0.0008, 0.0002]
a = [1, -3.618, 5.062, -3.414, 1.162, -0.1919]

# 计算数字滤波器的频率响应
w, h = signal.freqz(b, a)

# 将弧度转换为赫兹
f = w * 955.5 / np.pi

# 绘制幅频特性曲线
plt.subplot(2, 1, 1)
plt.plot(f, 20 * np.log10(abs(h)))
plt.xlabel('Frequency (Hz)')
plt.ylabel('Magnitude (dB)')
plt.title('Magnitude Response')
plt.grid()

# 绘制相频特性曲线
plt.subplot(2, 1, 2)
plt.plot(f, np.angle(h) * 180 / np.pi)
plt.xlabel('Frequency (Hz)')
plt.ylabel('Phase (degrees)')
plt.title('Phase Response')
plt.grid()

# 显示图像
plt.show()
