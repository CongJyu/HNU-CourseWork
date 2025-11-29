# encoding utf-8
# python 3.10

import numpy as np
import matplotlib.pyplot as plt

np.random.seed(2023)

n = np.arange(-10, 11, 1)
x1 = np.random.uniform(-1, 1, 21)
x2 = np.random.uniform(-1, 1, 21)

plt.subplot(3, 1, 1)
plt.stem(n, x1)
plt.title('$ x1 $')
plt.xlabel('$ n $')
plt.ylabel('$ x1 $')

plt.subplot(3, 1, 2)
plt.stem(n, x2)
plt.title('$ x2 $')
plt.xlabel('$ n $')
plt.ylabel('$ x2 $')

x3 = np.roll(x1, -6)
x3[x3.size - 6:x3.size] = 0
plt.subplot(3, 1, 3)
plt.stem(n, x3)
plt.title('$ x3 $')
plt.xlabel('$ n $')
plt.ylabel('$ x3 $')

plt.show()
