# encoding utf-8
# python 3.10

import numpy as np
from matplotlib import pyplot as plt

n = np.arange(128)
x = np.exp(1j * 0.48 * np.pi * n) + np.exp(1j * 0.52 * np.pi * n)
X = np.fft.fft(x)

plt.subplot(2, 1, 1)
plt.stem(n, x)
plt.xlabel('n')
plt.ylabel('x(n)')
plt.grid(True)

plt.subplot(2, 1, 2)
plt.stem(n, np.abs(X))
plt.xlabel('n')
plt.ylabel('$ X(\omega) $')
plt.grid(True)

plt.show()
