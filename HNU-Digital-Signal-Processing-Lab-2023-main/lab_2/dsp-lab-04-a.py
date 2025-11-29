# encoding utf-8
# python 3.10

import numpy as np
from matplotlib import pyplot as plt


n = np.arange(8)
x = np.exp(1j * 0.48 * np.pi * n) + np.exp(1j * 0.52 * np.pi * n)
X = np.fft.fft(x)

plt.stem(np.abs(X))
plt.grid(True)
plt.show()
