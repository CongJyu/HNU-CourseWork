# encoding utf-8
# python 3.10

import numpy as np
import matplotlib.pyplot as plt

omega = np.arange(-10, 10, 0.001)


def X_a(omega):
    return 1 / (1 + 1j * omega) ** 2


plt.plot(omega, np.abs(X_a(omega)))
plt.xlabel('$ \Omega $')
plt.ylabel('$ X_a(j \Omega) $')
plt.grid(True)

plt.show()
