# encoding utf-8
# python 3.10

import numpy as np
import matplotlib.pyplot as plt

n = np.arange(-20, 21, 1)
epsilon_n = np.concatenate(
    (np.zeros([1, 20]), np.ones([1, 21])),
    axis=1
)

plt.stem(n, epsilon_n.transpose())
plt.title('Unit Step Sequence')
plt.xlabel('$ n $')
plt.ylabel('$ u(t) $')
plt.axis([-20, 20, 0, 1.2])
plt.grid(True)

plt.show()
