# encoding utf-8
# python 3.10

import numpy as np
import matplotlib.pyplot as plt

omega0 = [
    -np.pi / 6, -np.pi / 3, -np.pi / 2, 0,
    np.pi / 6, np.pi / 3, np.pi / 2
]

for i in range(7):
    a = 0.9 * np.exp(1j * omega0[i])
    w = np.linspace(-np.pi, np.pi, 1000)
    H = 1 / (1 - a * np.exp(-1j * w))

    plt.subplot(2, 4, i + 1)

    plt.plot(w, abs(H))
    plt.xlabel('$\omega$')
    plt.ylabel('$|H(e^{j \omega})|$')
    omega_display = round(omega0[i], 2)
    plt.title(f'$\omega_0 = $ {omega_display}')
    plt.grid()

plt.show()
