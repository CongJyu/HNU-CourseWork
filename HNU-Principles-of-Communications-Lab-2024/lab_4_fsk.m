% 通信原理 实验 4 2ASK/2FSK/2PSK/2DPSK+AWGN

% 2FSK
clc;
clear;

% 初始化
Fs = 1000;  % 采样频率
Ts = 1;  % 码元周期
T = 0:1/Fs:200;  % 时间范围

% 生成基带信号 m(t)
% 产生单极性不归零基带信号 m(t)
m = zeros(size(T));
for k = 1:length(T)
    if mod(floor(T(k)), 2) == 0  % 生成随机的 0 和 1
        m(k) = 1;
    end
end

m = m(:)';  % 转换为列向量

% 生成载波信号
f1 = 5;  % 5 Hz 载波
f2 = 15;  % 15 Hz 载波
carrier1 = sin(2 * pi * f1 * T);
carrier2 = sin(2 * pi * f2 * T);

% FSK 调制
FSK_signal = zeros(size(T));
FSK_signal(m == 0) = carrier1(m == 0);
FSK_signal(m == 1) = carrier2(m == 1);

% 时域波形图
figure;
subplot(2, 1, 1);
plot(T(1:8000), m(1:8000), 'b');
xlabel('时间 (s)');
ylabel('幅度 (V)');
title('基带信号');
ylim([-0.1 1.1]);

subplot(2, 1, 2);
plot(T(1:8000), FSK_signal(1:8000), 'r');
xlabel('时间 (s)');
ylabel('幅度 (V)');
title('FSK 调制信号');
ylim([-1.1 1.1]);

% 功率谱密度图
M = length(T);
M2 = 2^nextpow2(M);
f_m = Fs * (-M2 / 2:M2 / 2 - 1) / M2;
PSD_m = abs(fftshift(fft(m, M2))).^2/M2;

f_FSK = Fs*(-M2 / 2:M2 /2 - 1) / M2;
PSD_FSK = abs(fftshift(fft(FSK_signal, M2))) .^ 2 / M2;

figure;
subplot(2, 1, 1);
plot(f_m, PSD_m);
xlabel('频率 (Hz)');
ylabel('归一化功率谱密度');
title('基带信号的归一化功率谱密度');
xlim([-5 5]);

subplot(2, 1, 2);
plot(f_FSK, PSD_FSK);
xlabel('频率 (Hz)');
ylabel('归一化功率谱密度');
title('FSK 信号的归一化功率谱密度');
xlim([-25 25]);

% 添加噪声
SNR = 10;  % 信噪比
FSK_signal_noisy = awgn(FSK_signal, SNR, 'measured');

% 噪声叠加后的时域波形图
figure;
plot(T(1:8000), FSK_signal_noisy(1:8000), 'r');
xlabel('时间 (s)');
ylabel('幅度 (V)');
title('噪声叠加后的FSK信号');

% 星座图
scatterplot(FSK_signal_noisy(1:8000));
title('星座图');

% 理想滤波
% 低通滤波 (f1 = 5Hz)
[b, a] = butter(6, 2*f1/Fs);
m1 = filtfilt(b, a, FSK_signal_noisy);

% 带通滤波 (f2 = 15Hz)
d = designfilt('bandpassiir','FilterOrder',20, ...
               'HalfPowerFrequency1',f2-1,'HalfPowerFrequency2',f2+1, ...
               'SampleRate',Fs);
m2 = filtfilt(d, FSK_signal_noisy);

% 时域波形图
figure;
subplot(2,1,1);
plot(T(1:8000), m1(1:8000), 'r');
xlabel('时间 (s)');
ylabel('幅度 (V)');
title('理想低通滤波后的信号 m1(t)');

subplot(2,1,2);
plot(T(1:8000), m2(1:8000), 'r');
xlabel('时间 (s)');
ylabel('幅度 (V)');
title('理想带通滤波后的信号 m2(t)');

% 频谱图
M = length(T);
M2 = 2^nextpow2(M);
f_m1 = Fs*(-M2/2:M2/2-1)/M2;
PSD_m1 = abs(fftshift(fft(m1, M2))).^2/M2;

f_m2 = Fs*(-M2/2:M2/2-1)/M2;
PSD_m2 = abs(fftshift(fft(m2, M2))).^2/M2;

figure;
subplot(2,1,1);
plot(f_m1, PSD_m1);
xlabel('频率 (Hz)');
ylabel('归一化功率谱密度');
title('m1(t) 的归一化功率谱密度');

subplot(2,1,2);
plot(f_m2, PSD_m2);
xlabel('频率 (Hz)');
ylabel('归一化功率谱密度');
title('m2(t) 的归一化功率谱密度');

% 全波整流
m1_rect = abs(m1);
m2_rect = abs(m2);

% 理想低通滤波
[b, a] = butter(6, 2*(f1+1)/Fs);
m1_demod = filtfilt(b, a, m1_rect);

[b, a] = butter(6, 2*(f2+1)/Fs);
m2_demod = filtfilt(b, a, m2_rect);

% 判决基带信号
samples_m1 = m1_demod(Ts/2:Ts:end);
samples_m2 = m2_demod(Ts/2:Ts:end);

C = samples_m1 > samples_m2;
C = double(C);

% 绘制还原的基带信号
restored_signal = zeros(1, length(T));
restored_signal(Ts/2:Ts:end) = C;
restored_signal = repmat(restored_signal, Fs, 1);
restored_signal = restored_signal(:)';

figure;
plot(T(1:8000), m(1:8000), 'b');
hold on;
plot(T(1:8000), restored_signal(1:8000), 'r');
xlabel('时间 (s)');
ylabel('幅度 (V)');
title('原始基带信号与还原基带信号比较');
legend('原始基带信号', '还原基带信号');
ylim([-0.1 1.1]);
