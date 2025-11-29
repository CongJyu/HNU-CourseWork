# encoding utf-8
# python 3.10

import numpy as np
import matplotlib.pyplot as plt
from scipy import signal


omega0 = [
    -np.pi / 2, -np.pi / 3, -np.pi / 6, 0, np.pi / 6, np.pi / 3, np.pi / 2
]

for i in range(7):
    a = 0.9 * np.exp(1j * omega0[i])
    b = [1]
    a = [1, -a]

    z, p, k = signal.tf2zpk(b, a)

    print(p)

    plt.subplot(2, 4, i + 1)

    plt.scatter(np.real(z), np.imag(z), marker='o', color='red')
    plt.scatter(np.real(p), np.imag(p), marker='x', color='blue')
    plt.axvline(0, color='black')
    plt.axhline(0, color='black')
    plt.grid(True)
    plt.xlabel('Real')
    plt.ylabel('Imaginary')
    plt.xlim(-2, 2)
    plt.ylim(-2, 2)
    omega_display = round(omega0[i], 2)
    plt.title(f'Zero-Pole, $ \omega_0 = {omega_display} $')

plt.show()
