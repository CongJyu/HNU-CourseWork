# encoding utf-8
# python 3.10

import numpy as np
import matplotlib.pyplot as plt

x = np.array([
    1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
    11, 12, 13, 14, 15, 16, 17, 18, 19, 20
])
h = np.array([0, -0.5, 0.5, 0.5])
N = 6

circle_conv = np.fft.fft(np.fft.ifft(x, n=N) * np.fft.ifft(h, n=N)).real
print('Circle Conv:\n', circle_conv)

plt.subplot(2, 1, 1)
plt.stem(np.abs(circle_conv))
plt.xlabel('n')
plt.ylabel('circle_conv')
plt.grid(True)

linear_conv = np.convolve(x, h, mode='valid')
print('Linear Conv:\n', linear_conv)

plt.subplot(2, 1, 2)
plt.stem(np.abs(linear_conv))
plt.xlabel('n')
plt.ylabel('linear_conv')
plt.grid(True)

plt.show()
