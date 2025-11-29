% 通信原理 实验 1 正弦波加高斯白噪声并通过窄带系统

clc;
clear;

% 1. 设置采样频率和时间间隔
Fs = 100;  % 采样频率为100Hz
Ts = 1/Fs;  % 采样时间间隔，单位秒

% 2. 生成正弦信号
f = 10;  % 正弦信号频率为10Hz
amp = 1;  % 正弦信号幅度
t = 0:Ts:1-Ts;  % 时间序列
sinusoidal_signal = amp * sin(2*pi*f*t);  % 正弦信号

% 3. 生成高斯白噪声
noise_power = 0.25;  % 噪声功率为0.25W
noise = sqrt(noise_power) * randn(size(t));  % 高斯白噪声

% 4. 叠加正弦信号和噪声信号
combined_signal = sinusoidal_signal + noise;

% 5. 绘制时域波形
subplot(2, 3, 1);
plot(t, sinusoidal_signal);
title('正弦信号');
xlabel('时间 (s)');
ylabel('幅度');
subplot(2, 3, 4);
plot(t,noise);
title('噪声信号');
xlabel('时间 (s)');
ylabel('幅度');
subplot(2, 3, 2);
plot(t, combined_signal);
title('叠加后的信号 (正弦信号 + 噪声)');
xlabel('时间 (s)');
ylabel('幅度');

% 6. 计算并绘制频谱
N = length(combined_signal);
fft_combined = fftshift(fft(combined_signal))/N; % 采样结果的N点FFT
frequencies = linspace(-Fs/2, Fs/2, N);
subplot(2, 3, 5);
plot(frequencies, abs(fft_combined));
title('频谱');
xlabel('频率 (Hz)');

% 7. 通过中心频率 omega0 的窄带系统
omega0 = 100;  % 自行设定中心频率为 100
filtered_signal = filter(ones(1, 10), 1, combined_signal); % 窄带滤波

% 8. 绘制通过后的时域波形和频谱
subplot(2, 3, 3);
plot(t, filtered_signal);
title('滤波后的信号 (中心频率 ω₀)');
xlabel('时间 (s)');
ylabel('幅度');
subplot(2, 3, 6);
plot(abs(fftshift(fft(filtered_signal))/N));
title('滤波后的信号频谱');
xlabel('频率 (Hz)');
grid on;
