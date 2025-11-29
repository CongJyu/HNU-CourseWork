# encoding utf-8
# python 3.10

import numpy as np
import matplotlib.pyplot as plt

n = np.arange(-20, 21, 1)
delta_n = np.concatenate(
    (np.zeros([1, 20]), np.ones([1, 1]), np.zeros([1, 20])),
    axis=1
)

plt.stem(n, delta_n.transpose())
plt.xlabel('$ n $')
plt.ylabel('$ \delta (n) $')
plt.title('Unit Sample Sequence')
plt.axis([-20, 20, 0, 1.2])
plt.grid(True)

plt.show()
