# encoding utf-8
# python 3.10

import numpy as np
import matplotlib.pyplot as plt

# 定义周期序列
x = np.array([0, 1, 2, 3])

# 计算离散傅立叶级数
X = np.fft.fft(x)

# 绘制幅度特性
plt.stem(np.abs(X))
plt.title('DFS Amplitude Characteristic')
plt.xlabel('k')
plt.ylabel('|X(k)|')
plt.show()
