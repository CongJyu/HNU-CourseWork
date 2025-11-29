% 通信原理 实验 2 AM/DSB/SSB/VSB/FM 调制解调波形（时域与频域）

clc;
clear;

% 1. 设定信号参数
T = 20;
Ts = 0.0001;
t = 0:Ts:T;
N = length(t);
Fs = 1 / Ts;
df = Fs / N;
f = -Fs / 2:df:Fs/2 - df;

% 2. 产生调制信号
mt = sin(6 .* pi .* t);
figure(1);
subplot(2, 1, 1);
plot(t, mt);
axis([0 1 -1.1 1.1]);
title('调制信号 m(t)');
xlabel('时间 (s)');
ylabel('电压 (V)');
grid on;

fmt = fft(mt);
fmt = fftshift(fmt);
fmtAmp = abs(fmt);
subplot(2, 1, 2);
plot(f, fmtAmp);
xlim([-10 10]);
xlabel('频率 (Hz)');
ylabel('频谱幅度');
title('调制信号幅度频率特性');
grid on;

% 3. 产生载波信号
ct = cos(120 .* pi .* t);
figure(2);
plot(t, ct);
axis([0 1 -1.1 1.1]);
title('载波信号 c(t)');
xlabel('时间 (s)');
ylabel('电压 (V)');
grid on;

% 4. 进行 AM 调制
A0 = 2;
AM = (A0 + mt) .* ct;
figure(3);
subplot(2, 1, 1);
plot(t, AM);
axis([0 1 -(A0+1) (A0+1)]);
title('AM 已调制信号 s(t)');
xlabel('时间 (s)');
ylabel('电压 (V)');
grid on;

subplot(2, 1, 2);
f_st_am = abs(fftshift(fft(AM)));
plot(f, f_st_am);
title('AM 已调制信号幅度频率特性');
xlabel('频率 (Hz)');
ylabel('频谱幅度');
xlim([-70 70]);
grid on;

% 5. 进行 DSB 调制
DSB = mt .* ct;
figure(4);
subplot(2, 1, 1);
plot(t, DSB);
axis([0 1 -1.1 1.1]);
title('DSB 已调制信号 s(t)');
xlabel('时间 (s)');
ylabel('电压 (V)');
grid on;

subplot(2, 1, 2);
f_st_dsb = abs(fftshift(fft(DSB)));
plot(f, f_st_dsb);
title('DSB 已调制信号幅度频率特性');
xlabel('频率 (Hz)');
ylabel('频谱幅度');
xlim([-70 70]);
grid on;

% 6. 进行 SSB 调制
figure(5);
% 高通滤波
subplot(2, 1, 1);
fpass = 60;
fstop = 100;
[f1, spf] = ideal_filter(N, Fs, fpass, fstop, fft(DSB));
spf1 = fftshift(spf);
plot(f1, abs(spf1));
maxY = max(abs(spf1));
minY = min(abs(spf1));
axis([-70 70 minY-0.1 maxY+0.1]);
title('SSB 单边带上边带已调制信号幅频特性');
xlabel('频率 (Hz)');
ylabel('频谱幅度');
grid on;

% 对理想低通滤波之后的 FFT 结果进行 IFFT 计算得到 mt1
Rt = real(ifft(spf));
subplot(2, 1, 2);
plot(t, Rt);
axis([0 1 -1 1]);
title('SSB 单边带上边带已调制信号');
xlabel('时间 (s)');
ylabel('电压 (V)');
grid on;

% 7. 进行 FM 调制
FM = cos(120 .* pi .* t + 15 .* sin(6 .* pi .* t));

figure(6);
subplot(2, 1, 1);
plot(t, FM);
axis([0 1 -1.1 1.1]);
title('FM 已调制信号');
xlabel('时间 (s)');
ylabel('电压 (V)');
grid on;

subplot(2, 1, 2);
f_st_fm = abs(fftshift(fft(FM)));
plot(f, f_st_fm);
xlim([-150 150]);
title('FM 已调制信号幅度频率特性曲线');
xlabel('频率 (Hz)');
ylabel('频谱幅度');
grid on;

%     N - FFT 变换结果长度
%     Fs - 采样频率，Nyquist 频率的两倍
%     fpass - 理想带通滤波器的通带起始频率
%     fstop - 理想带通滤波器的通带截止频率
%     fx - 输入的时域信号的 FFT 变换结果
%     f - 滤波后的频率向量
%     spf - 理想低通/带通滤波器滤波后的 FFT 变换频谱
function [f, spf] = ideal_filter(N, Fs, fpass, fstop, fx)
    sp_lpr = zeros(1, N);
    Npass = fpass * N / Fs + 1;
    Nstop = fstop * N / Fs;

    sp_lpr(Npass:Nstop) = fx(Npass:Nstop);
    sp_lpr(N - Nstop + 1:N - Npass + 1) = fx(N - Nstop + 1:N - Npass + 1);

    f = linspace(-Fs / 2, Fs / 2, N);
    spf = sp_lpr;
end
