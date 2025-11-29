% 通信原理 实验 4 2ASK/2FSK/2PSK/2DPSK+AWGN

% 2ASK
clc;
clear;

% 参数设置
Fs = 5000;
Ts = 1;
Fc = 500;
t = 0:1/Fs:200;
num_samples = length(t);

% 产生单极性不归零基带信号 m(t)
m = zeros(size(t));
for k = 1:length(t)
    if mod(floor(t(k)), 2) == 0
        m(k) = 1;
    end
end

% 产生载波信号
carrier = cos(2 * pi * Fc * t);

% 进行 ASK 调制
ask_signal = m .* carrier;

% 绘制波形图
figure(1);
subplot(2, 4, 1);
plot(t, m, 'b');
hold on;
plot(t, ask_signal);
xlabel('Time (s)');
ylabel('Amplitude (V)');
xlim([0 12]);
ylim([-0.1, 1.1]);
title('时域波形');
legend('基带信号', '2ASK 调制信号');
grid on;

% 计算归一化功率谱
baseband_psd = fftshift(abs(fft(m)).^2 / num_samples);
ask_psd = fftshift(abs(fft(ask_signal)).^2 / num_samples);
f_baseband = linspace(-Fs/2, Fs/2, num_samples); % 频率范围
f_ask = linspace(-Fs/2, Fs/2, num_samples);

% 绘制功率谱密度
subplot(2, 4, 2);
plot(f_baseband, baseband_psd);
xlim([-15, 15]);
xlabel('Frequency (Hz)');
ylabel('Power/Frequency (dB/Hz)');
title('基带信号功率谱密度');
grid on;
subplot(2, 4, 3);
plot(f_ask, ask_psd);
xlim([-600, 600]);
xlabel('Frequency (Hz)');
ylabel('Power/Frequency (dB/Hz)');
title('2ASK 信号功率谱密度');
grid on;

% 计算信号功率
signal_power = mean(ask_signal.^2);

% 设置信噪比 SNR = 10 dB
SNR = 10;
noise_power = signal_power / (10^(SNR / 10));

% 生成高斯白噪声
noise = sqrt(noise_power) * randn(size(ask_signal));

% 叠加噪声到 ASK 已调信号
ask_signal_noisy = ask_signal + noise;

% 绘制叠加噪声后的时域波形图
subplot(2, 4, 4);
plot(t, m);
hold on;
plot(t, ask_signal_noisy);
xlabel('Time (s)');
ylabel('Amplitude (V)');
xlim([0 12]);
ylim([-0.1 1.1]);
title('加上噪声后时域图');
legend('基带信号', '2ASK 调制信号');
grid on;

% 绘制星座图
subplot(2, 4, 5);
scatter(real(ask_signal_noisy(1:Fs:end)), imag(ask_signal_noisy(1:Fs:end)), 'r.');
xlabel('In-Phase');
ylabel('Quadrature');
title('加了噪声后的星座图');
grid on;
axis([-2 2 -2 2]);

% 全波整流
full_wave_rectified = abs(ask_signal_noisy);

% 理想低通滤波
f_cutoff = Fc; % 截止频率为载波频率 Fc
N = length(full_wave_rectified);
f = linspace(-Fs/2, Fs/2, N); % 频率范围
H = zeros(size(f));
H(abs(f) <= f_cutoff) = 1; % 理想低通滤波器

% 频域滤波
full_wave_rectified_fft = fftshift(fft(full_wave_rectified));
filtered_signal_fft = full_wave_rectified_fft .* H;
filtered_signal = ifft(ifftshift(filtered_signal_fft));

% 信号放大（乘以放大系数 2）
demodulated_signal = 2 * real(filtered_signal);

% 绘制解调信号与原始基带信号的比较图
subplot(2, 4, 6);
plot(t, m);
hold on;
plot(t, demodulated_signal);
xlabel('Time (s)');
ylabel('Amplitude (V)');
xlim([0 12]);
ylim([-0.1 2.2]);
title('解调信号与发送端原始的二进制基带信号的时域波形');
legend('原始基带信号', '解调信号');
grid on;

% 绘制解调后的星座图
subplot(2, 4, 7);
scatter(real(demodulated_signal(1:Fs:end)), imag(demodulated_signal(1:Fs:end)), 'g.');
xlabel('In-Phase');
ylabel('Quadrature');
title('解调后星座图');
grid on;
axis([-2 2 -2 2]);

% 绘制带噪信号的星座图
subplot(2, 4, 8);
scatter(real(ask_signal_noisy(1:Fs:end)), imag(ask_signal_noisy(1:Fs:end)));
xlabel('In-Phase');
ylabel('Quadrature');
title('带噪信号的星座图');
grid on;
axis([-2 2 -2 2]);
