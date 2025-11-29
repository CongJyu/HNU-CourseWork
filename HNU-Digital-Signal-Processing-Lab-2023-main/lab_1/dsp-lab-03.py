# encoding utf-8
# python 3.10

import numpy as np
import matplotlib.pyplot as plt
from scipy import signal

t1 = np.linspace(-1, 1, 10000, endpoint=False)
wave1 = signal.square(2 * np.pi * 10 * t1, 1 / 3) + 1

plt.subplot(2, 1, 1)
plt.plot(t1, wave1)
plt.title('Original')
plt.xlim(-0.1, 0.1)
plt.ylim(-1, 3)
plt.grid(True)

t2 = np.linspace(-1, 1, 16 * 2 * 10, endpoint=False)
wave2 = signal.square(2 * np.pi * 10 * t2, 1 / 3) + 1

plt.subplot(2, 1, 2)
plt.stem(t2, wave2)
plt.title('Sample')
plt.xlim(-0.1, 0.1)
plt.ylim(-1, 3)
plt.grid(True)

plt.show()
