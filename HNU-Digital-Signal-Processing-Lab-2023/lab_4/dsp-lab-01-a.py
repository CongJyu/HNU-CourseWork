# encoding utf-8
# python 3.10

# 导入库
import numpy as np
import scipy.signal as signal
import matplotlib.pyplot as plt

plt.rcParams['font.sans-serif'] = ['Unifont']
plt.rcParams['axes.unicode_minus'] = False

# 定义单位抽样响应
h1 = np.array([-4, 1, -1, -2, 5, 6, 5, -2, -1, 1, -4])

# 求系统函数
b1 = h1[::-1]  # 将系数反转
a = np.array([1])  # 定义分母系数
H = np.poly1d(b1)  # 转换为多项式对象
print("系统函数为：")  # 打印提示信息
print(H)  # 打印多项式

# 画出幅度频率响应的波形
plt.subplot(2, 2, 1)  # 创建图形
w, Hw = signal.freqz(b1, a)  # 计算频率响应
Hw = 20 * np.log10(np.abs(Hw))  # 取绝对值并转换为 dB
plt.plot(w, Hw)  # 绘制曲线
plt.xlabel("数字频率 (弧度/采样)")  # 设置 x 轴标签
plt.ylabel("幅度 (dB)")  # 设置 y 轴标签
plt.title("幅度频率响应")  # 设置标题
plt.grid()  # 显示网格

# 画出系统函数波形
plt.subplot(2, 2, 3)  # 创建图形
n = np.arange(0, 11)  # 定义 n 的范围
plt.stem(n, h1)  # 绘制离散信号
plt.xlabel("n")  # 设置 x 轴标签
plt.ylabel("h(n)")  # 设置 y 轴标签
plt.title("系统函数")  # 设置标题
plt.grid()  # 显示网格

# 画出零极点图
plt.subplot(1, 2, 2)  # 创建图形
z, p, k = signal.tf2zpk(b1, a)  # 将传递函数转换为零点、极点和增益
plt.plot(np.real(z), np.imag(z), 'o', label='Zeros')  # 绘制零点
plt.plot(np.real(p), np.imag(p), 'x', label='Poles')  # 绘制极点
plt.xlabel("实部")  # 设置 x 轴标签
plt.ylabel("虚部")  # 设置 y 轴标签
plt.title("零极点图")  # 设置标题
plt.legend()  # 显示图例
plt.grid()  # 显示网格
plt.axis('equal')  # 设置坐标轴比例相等

plt.show()  # 显示图形
