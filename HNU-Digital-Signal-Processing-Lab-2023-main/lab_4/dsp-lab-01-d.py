# encoding utf-8
# python 3.10

# 导入必要的库
import numpy as np
import matplotlib.pyplot as plt

# 定义单位抽样响应 h(n)
h = np.array([-4, 1, -1, -2, 5, 6, -6, -5, 2, 1, -1, 4])

# 定义系统函数 H(z) 的系数
H = np.flip(h)  # 将 h(n) 的系数反转，得到 H(z) 的系数

# 定义数字频率的数组，范围是 [-pi, pi]，长度是 512
omega = np.fft.fftfreq(512) * 2 * np.pi

# 定义用于存储 H(omega) 值的数组
Hw = np.zeros(512, dtype=complex)

# 计算 H(omega) 的值，利用 H(z) 在 z=e^(j*omega) 处的模长
for i in range(512):
    z = np.exp(1j * omega[i])  # 计算 z=e^(j*omega)
    Hw[i] = np.abs(np.polyval(H, z))  # 计算 H(z) 在 z 处的值，并取模长

# 将 H(omega) 的值转换成 dB 单位，利用 20*log10(|H(omega)|)
Hw_dB = 20 * np.log10(Hw)

# 绘制幅度频率响应的波形，利用 matplotlib 的 plot 函数
plt.subplot(2, 2, 1)  # 设置子图位置
plt.plot(omega, Hw_dB)  # 绘制波形
plt.xlabel('Digital frequency (rad)')  # 设置 x 轴标签
plt.ylabel('Magnitude (dB)')  # 设置 y 轴标签
plt.title('Magnitude frequency response of the FIR filter')  # 设置标题
plt.grid()  # 显示网格线

plt.subplot(2, 2, 2)
plt.stem(h)
plt.xlabel('$n$')
plt.ylabel('$h(n)$')
plt.grid(True)

# 绘制系统函数波形和零极点图，利用 matplotlib 的 stem 和 plot 函数
plt.subplot(2, 2, 3)  # 设置子图位置
plt.stem(np.arange(12), h)  # 绘制系统函数波形
plt.xlabel('n')  # 设置 x 轴标签
plt.ylabel('h(n)')  # 设置 y 轴标签
plt.title('System function of the FIR filter')  # 设置标题
plt.grid()  # 显示网格线

plt.subplot(2, 2, 4)  # 设置子图位置
plt.plot(np.real(np.roots(H)), np.imag(
    np.roots(H)), 'o', label='Zeros')  # 绘制零点
plt.plot(0, 0, 'x', label='Poles')  # 绘制极点（原点）
plt.xlabel('Real part')  # 设置 x 轴标签
plt.ylabel('Imaginary part')  # 设置 y 轴标签
plt.title('Zero-pole plot of the FIR filter')  # 设置标题
plt.grid()  # 显示网格线
plt.legend()  # 显示图例
plt.axis('equal')  # 设置坐标轴比例相等
plt.show()  # 显示图像
