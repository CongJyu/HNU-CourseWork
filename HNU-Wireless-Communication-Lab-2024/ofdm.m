% 无线通信实验：OFDM 系统降低 PAPR 方法
% MATLAB 版本 R2021b

clear;
clc;

CR = 1.2; % 限幅比：限幅电平 / OFDM 信号 RMS
b = 2; % 每一个 QPSK 信号的比特数
N = 128; % FFT 大小
Ncp = 32; % 循环前缀 CP 的长度
fs = 1e6; % 采样频率
L = 8; % 过采样因子
Tsym = 1 / (fs / N); % 采样频率
Ts = 1 / (fs * L); % 采样周期
fc = 2e6; % 载波频率
wc = 2 * pi * fc; % 载波频率
t = [0:Ts:2 * Tsym - Ts];
t0 = t((N / 2 - Ncp) * L);
f = [0:fs / (N * 2):L * fs 0 - fs / (N * 2)] - L * fs / 2;
Fs = 8; % 滤波器采样频率
Norder = 104; % 采样阶数
dens = 20; % 密度因子
FF = [0 1.4 1.5 2.5 2.6 Fs / 2]; % 阻带/通带/阻带频率边缘向量
WW = [10 1 10]; % 加权向量
h = firpm(Norder, FF / (Fs / 2), [0 0 1 1 0 0], WW, {dens}); % BPF 系数

% QPSK 调制
% 使输入的比特流 b 映射到 QPSK 符号 X。每个符号携带 2 比特信息，通过改变信号的相位来表示不同的数据值。
% 在 QPSK 中信号被分成正弦波和余弦波两路。每路传输一个独立的比特流，两路的相位相差 90 度，因此是正交相移。
X = mapper(b, N);
X(1) = 0; % 将第一位符号设为 0，用于同步和校准。
% IFFT 过采样
x = IFFT_oversampling(X, N, L); % 使用 IFFT 来进行过采样操作，生成过采样之后的信号，增加信号的抗干扰性和频谱利用率。
% 添加循环前缀 CP
% 在信号 x 前添加循环前缀，减小多径效应对信号的影响，用于消除 ISI。
x_b = add_CP(x, Ncp * L);
% 过采样
x_b_os = [zeros(1, (N / 2 - Ncp) * L), x_b, zeros(1, N * L / 2)];
x_p = sqrt(2) * real(x_b_os .* exp(1j * 2 * wc * t)); % 把信号从基带搬移到通频带
x_p_c = clipping(x_p, CR); % 对信号进行裁剪，限制信号的幅度范围
X_p_c_f = fft(filter(h, 1, x_p_c)); % 使用 FFT 把信号从通频带还原到基带
% X_p_c_f = fft(x_p_c); % 使用 FFT 把信号从通频带还原到基带，没有滤波
x_p_c_f = ifft(X_p_c_f); % 使用 IFFT 得到基带信号
x_b_c_f = sqrt(2) * x_p_c_f .* exp(-1j * 2 * wc * t); % 从通频带到基带

figure(1);
nn = (N / 2 - Ncp) * L + [1:N * L];
nn1 = N / 2 * L + [-Ncp * L + 1:0];
nn2 = N / 2 * L + [0:N * L];

subplot(2, 2, 1);
plot(t(nn2) - t0, abs(x_b_os(nn2)), "-");
hold on;
plot(t(nn1) - t0, abs(x_b_os(nn1)), '-');
axis([t([nn1(1) nn2(end)]) - t0 0 max(abs(x_b_os))]);
title('含循环前缀 CP 的基带信号');
xlabel('t (符号间隔归一化)');
ylabel('abs(x(m))');
grid on;

subplot(2, 2, 3);
XdB_p_os = 20 * log10(abs(fft(x_b_os)));
plot(fftshift(XdB_p_os) - max(XdB_p_os));
title('过采样信号 x_{bos} 的功率谱密度');
xlabel('频率 Frequency (Hz)');
ylabel('功率谱密度 PSD (dB)');
grid on;
% axis([f([1 end]) -100 0]);

subplot(2, 2, 2);
% 旧版本 MATLAB 中绘制直方图方式，已弃用
% [pdf_x_p, bin] = hist(x_p(nn));
% bar(bin, pdf_x_p / sum(pdf_x_p), 'k');
histogram(x_p(nn), FaceAlpha = 1, NumBins = 50);
xlabel('x');
ylabel('概率密度函数 PDF');
title('未限幅时的通频带信号');
grid on;

subplot(2, 2, 4);
XdB_p = 20 * log10(abs(fft(x_p)));
plot(fftshift(XdB_p) - max(XdB_p));
title('通频带信号 x_p 的功率谱密度');
xlabel('频率 Frequency (Hz)');
ylabel('功率谱密度 PSD (dB)');
grid on;
% axis([f([1 end]) -100 0]);

figure(2);
% 限幅后的信号幅度应该低于限幅电平
subplot(2, 2, 1);
% 旧版本 MATLAB 中绘制直方图方式，已弃用
% [pdf_x_p_c, bin] = hist(x_p_c(nn), 50);
% bar(bin, pdf_x_p_c / sum(pdf_x_p_c), 'k');
histogram(x_p_c(nn), FaceAlpha = 1, NumBins = 50);
title(['限幅的通频带信号, CR =' num2str(CR)]);
xlabel('x');
ylabel('概率密度函数 PDF');
grid on;

subplot(2, 2, 3);
XdB_p_c = 20 * log10(abs(fft(x_p_c))); % 限幅之后的通频带信号功率谱密度
plot(fftshift(XdB_p_c) - max(XdB_p_c));
xlabel('频率 Frequency (Hz)');
ylabel('功率谱密度 PSD (dB)');
title('限幅之后通频带信号 x_{pc} 的功率谱密度');
grid on;

subplot(2, 2, 2);
% 旧版本 MATLAB 中绘制直方图方式，已弃用
% [pdf_x_p_c_f, bin] = hist(x_p_c_f(nn), 50);
% bar(bin, pdf_x_p_c_f / sum(pdf_x_p_c_f), 'k');
histogram(x_p_c_f(nn), FaceAlpha = 1, NumBins = 50);
title(['限幅和滤波后的通频带信号, CR =' num2str(CR)]);
grid on;

subplot(2, 2, 4);
XdB_p_c_f = 20 * log10(abs(X_p_c_f));
plot(fftshift(XdB_p_c_f) - max(XdB_p_c_f));
xlabel('频率 (Hz)');
ylabel('PSD (dB)');
title('限幅并滤波后的通频带信号 x_{pc} 的功率谱密度');
grid on;

figure(3);
subplot(2, 2, 1);
stem(h);
title('滤波器系数幅度响应');
xlabel('抽头数');
ylabel('滤波器系数 h(n)');
axis([1, length(h), min(h), max(h)]);
grid on;

subplot(2, 2, 2);
HdB = 20 * log10(abs(fft(h, length(X_p_c_f))));
plot(fftshift(HdB));
title('滤波器频率响应');
xlabel('频率 (Hz)');
ylabel('频率响应 H(dB)');
grid on;

subplot(2, 2, 3);
% 旧版本 MATLAB 中绘制直方图方式，已弃用
% [pdf_x_p_c_f, bin] = hist(abs(x_b_c_f(nn)), 50);
% bar(bin, pdf_x_p_c_f / sum(pdf_x_p_c_f), 'k');
histogram(abs(x_p_c_f(nn)), FaceAlpha = 1, NumBins = 50)
title(['限幅和滤波后的基带信号, CR =' num2str(CR)]);
xlabel('|x|');
ylabel('概率密度函数 PDF');
grid on;

subplot(2, 2, 4);
XdB_b_c_f = 20 * log10(abs(fft(x_b_c_f)));
plot(fftshift(XdB_b_c_f) - max(XdB_b_c_f));
title('基带信号的功率谱密度');
xlabel('频率 (Hz)');
ylabel('PSD (dB)');
grid on;

% 随机生成 N 个二进制 PSK/QAM 调制符号
function [modulated_symbols, Mod] = mapper(b, N)
    A = 1;
    M = 2 ^ b;
    Mod = 'QPSK';
    modulated_symbols = pskmod(randi([0 M - 1], N, 1), M, pi / M) * A;
end

% 添加循环前缀 CP
function y = add_CP(x, Ncp)
    y = [x(:, end - Ncp + 1:end) x];
end

% 限幅法
function [x_clipped, sigma] = clipping(x, CL, sigma)

    if nargin < 3
        x_mean = mean(x);
        x_dev = x - x_mean;
        sigma = sqrt(x_dev * x_dev' / length(x));
    end

    CL = CL * sigma;
    x_clipped = x;
    ind = find(abs(x) > CL);
    x_clipped(ind) = x(ind) ./ abs(x(ind)) * CL;
end

% 过采样函数
function [xt, time] = IFFT_oversampling(X, N, L)

    if nargin < 3
        L = 1;
    end

    NL = N * L;
    T = 1 / NL;
    time = [0:T:1 - T];
    X = X(:).';
    xt = L * ifft([X(1:N / 2) zeros(1, NL - N) X(N / 2 + 1:end)], NL);
end
