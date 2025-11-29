# encoding utf-8
# python 3.10

import numpy as np
import matplotlib.pyplot as plt

n = np.arange(-20, 21, 1)
omega = np.pi / 6


def x(n):
    return np.sin(omega * n)


plt.stem(n, x(n))
plt.title('$ x(n) = sin(\\omega n)$')
plt.xlabel('$ n $')
plt.ylabel('$ x(n) $')

plt.show()
