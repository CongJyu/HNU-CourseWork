# encoding utf-8
# python 3.10

import numpy as np
import matplotlib.pyplot as plt

x = np.array([
    0, 1, 2, 3, 4, 5, 6, 7,
    8, 9, 10, 11, 12, 13, 14, 15
])
h = np.array([1, 1, 1, 1, 1, 1, 1, 1])
N = x.shape[-1]  # 序列长度

# 圆周卷积
result = np.fft.fft(np.fft.ifft(x, n=N) * np.fft.ifft(h, n=N)).real

print(result)
plt.stem(result)
plt.xlabel('n')
plt.ylabel('result')
plt.grid(True)
plt.show()
