# encoding utf-8
# python 3.10

import numpy as np
import matplotlib.pyplot as plt
import scipy.signal as signal

plt.rcParams['font.sans-serif'] = ['Unifont']
plt.rcParams['axes.unicode_minus'] = False

# 设置参数
ws1 = 0.2 * np.pi
wp1 = 0.35 * np.pi
ws2 = 0.8 * np.pi
wp2 = 0.65 * np.pi
Ap = 60
Rp = 1

# 计算截止带宽和滤波器阶数
tr_width = min((wp1 - ws1), (ws2 - wp2))
M = int(np.ceil(11 * np.pi / tr_width))

# 计算截止频率和理想滤波器
wc1 = (ws1 + wp1) / 2
wc2 = (wp2 + ws2) / 2
n = np.arange(M)
hd = np.sinc((n - (M - 1) / 2) * wc2 / np.pi) - \
    np.sinc((n - (M - 1) / 2) * wc1 / np.pi)

# 使用布莱克曼窗设计滤波器
w_bla = np.blackman(M)
h = hd * w_bla

# 计算幅度响应并绘图
w, H = signal.freqz(h, 1)

plt.figure()
plt.plot(w, np.abs(H))

fig, axs = plt.subplots(2, 2, figsize=(10, 8))
axs[0, 0].stem(n, hd)
axs[0, 0].set_title('理想单位抽样')
axs[0, 1].stem(n, w_bla)
axs[0, 1].set_title('布莱克曼窗')
axs[1, 0].stem(n, h)
axs[1, 0].set_title('实际单位抽样')
axs[1, 1].plot(w, 20 * np.log10(np.abs(H)))
axs[1, 1].set_title('幅度响应（dB）')
plt.show()
