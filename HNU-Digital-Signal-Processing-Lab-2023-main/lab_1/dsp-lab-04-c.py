# encoding utf-8
# python 3.10

import numpy as np
import matplotlib.pyplot as plt

T_s = [1.0, 0.5, 0.1]


def sample_signal(t_s, omega):
    return np.abs(t_s * (t_s * np.exp(1 + 1j * omega)) / (1 - np.exp(-t_s * (1 + 1j * omega))) ** 2)


def original_signal(omega):
    return np.abs(1 / (1 + 1j * omega) ** 2)


for i in range(3):
    Omega = np.arange(-np.pi / T_s[i], np.pi / T_s[i], 0.0001)
    # Omega = np.arange(-30, 30, 0.0001)

    plt.subplot(3, 1, i + 1)
    plt.plot(Omega, original_signal(Omega))
    plt.plot(Omega, sample_signal(T_s[i], Omega))
    plt.xlabel('$ \Omega $')
    plt.ylabel(f'$ T_s = {T_s[i]} $')
    plt.grid(True)

plt.show()
