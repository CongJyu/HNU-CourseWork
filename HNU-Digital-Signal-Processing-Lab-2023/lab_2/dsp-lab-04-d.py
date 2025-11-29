# encoding utf-8
# python 3.10

import numpy as np
from matplotlib import pyplot as plt

n = np.arange(1024)
x = np.exp(1j * 0.48 * np.pi * n) + np.exp(1j * 0.52 * np.pi * n)
x[128:1024] = 0

X = np.fft.fft(x)

plt.subplot(4, 1, 1)
plt.plot(n, x)
plt.xlabel('n')
plt.ylabel('x(n)')
plt.grid(True)

plt.subplot(4, 1, 2)
plt.stem(n, x)
plt.xlabel('n')
plt.ylabel('x(n)')
plt.grid(True)

plt.subplot(4, 1, 3)
plt.plot(n, np.abs(X))
plt.xlabel('n')
plt.ylabel('$ X(\omega) $')
plt.grid(True)

plt.subplot(4, 1, 4)
plt.stem(n, np.abs(X))
plt.xlabel('n')
plt.ylabel('$ X(\omega) $')
plt.grid(True)

plt.show()
