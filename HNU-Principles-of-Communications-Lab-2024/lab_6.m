% 通信原理 实验 6 匹配滤波器和相关接收

clc;
clear;

% 参数设置
T = 5e-3;  % 时宽（5毫秒）
fs = 1e5;  % 采样率
f0 = 10e3;  % 中心频率
B = 1e4;  % 带宽 10 Hz
alpha = 2 * f0 / T;  % 调频斜率

% 生成 LFM 信号
t = linspace(0, T, 1000);
lfm_signal = exp(1j * pi * B * t .^ 2 / T); % 生成LFM信号

% 绘制 LFM 时域波形
subplot(2, 2, 1);
plot(t, real(lfm_signal));
title('LFM 信号时域波形');
xlabel('时间 (s)');
ylabel('幅度');

% 计算 LFM 频谱
N = length(lfm_signal);
frequencies = (-fs/2):(fs/N):(fs/2 - fs/N);
spectrum = fftshift(fft(lfm_signal));
subplot(2, 2, 2);
plot(frequencies, abs(spectrum));
title('LFM 信号频谱');
xlabel('频率 (Hz)');
ylabel('幅度');

% 添加 AWGN
SNR_dB = 20; % 信噪比（dB）
SNR_linear = 10^(SNR_dB / 10);
noise_power = norm(lfm_signal)^2 / (SNR_linear * length(lfm_signal));
noise = sqrt(noise_power) * (randn(size(lfm_signal)) + 1j * randn(size(lfm_signal)));
lfm_noisy = lfm_signal + noise;

% 匹配滤波
matched_filter = conj(fliplr(lfm_signal));
filtered_signal = conv(lfm_noisy, matched_filter, 'same');

% 进行 DFT
dft_result = fftshift(fft(filtered_signal));

% 绘制匹配滤波后的时域波形
subplot(2, 2, 3);
plot(t, real(filtered_signal));
title('匹配滤波后的时域波形');
xlabel('时间 (s)');
ylabel('幅度');

% 绘制匹配滤波后的频谱
subplot(2, 2, 4);
plot(frequencies, abs(dft_result));
title('匹配滤波后的频谱');
xlabel('频率 (Hz)');
ylabel('幅度');

% 计算误码率（假设二进制相干解调）
threshold = 0;  % 阈值
received_bits = real(filtered_signal) > threshold;
transmitted_bits = real(lfm_signal) > threshold;
bit_errors = sum(received_bits ~= transmitted_bits);
total_bits = length(transmitted_bits);
error_rate = bit_errors / total_bits;
disp(['误码率：', num2str(error_rate)]);
