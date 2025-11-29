% 通信原理 实验 5 QPSK/16-QAM/GMSK/OFDM+AWGN

clc;
clear;

N = 10000;
M = 16;
fs = 32;
fc = 4;
t = 0:1/fs:N-1/fs;
n = length(t);
f = (0:n - 1) * fs / n - fs / 2;
x = round(rand(N, 1));

I1 = x(1:2:end - 1);  % 16QAM 调制
Q1 = x(2:2:end);
I2 = bit2int(I1, 2);
Q2 = bit2int(Q1, 2);
I3 = zeros(1, N/4);
Q3 = I3;

for i = 1:N/4
    if (I2(i) == 0)
        I3(i) = 3;
    elseif (I2(i) == 1)
        I3(i) = 1;
    elseif (I2(i) == 3)
        I3(i) = -1;
    elseif (I2(i) == 2)
        I3(i) = -3;
    end
    if (Q2(i) == 0)
        Q3(i) = 3;
    elseif (Q2(i) == 1)
        Q3(i) = 1;
    elseif (Q2(i) == 3)
        Q3(i) = -1;
    elseif (Q2(i) == 2)
        Q3(i) = -3;
    end
end

yI = zeros(1, length(t));
yQ = yI;
for i = 1:N/4
    yI(1 + (i - 1) * 4 * fs:i * 4 * fs) = I3(i);
    yQ(1 + (i - 1) * 4 * fs:i * 4 * fs) = Q3(i);
end

y = yI(i) .* cos(2 * pi * fc * t) - yQ(i) .* sin(2 * pi * fc * t);
Y = fftshift(fft(y));
figure(1);
plot(f, abs(Y));
title('16 QAM 信号频谱图');
xlim([-10 10]);
yd = I3 + 1i * Q3;
scatterplot(yd);
title('16 QAM 信号星座图');

yn = awgn(y, 20);
Yn = fftshift(fft(yn));
figure(3);
plot(f, abs(Yn));
title('叠加噪声后 16 QAM 信号频谱图');
ylim([0 500]);
ydn = awgn(yd, 20);
tmp = scatterplot(ydn);
hold on;
scatterplot(yd, [], [], 'r*', tmp);
hold off; 
title('叠加噪声后 16 QAM 信号星座图');

y = yI .* cos(2*pi*fc*t) - yQ .* sin(2*pi*fc*t);  % 16QAM信号
N_ofdm = 64;  % OFDM参数，子载波数
cyclic_prefix_length = 16;  % 循环前缀长度

X = reshape(y(1:N_ofdm*floor(length(y)/N_ofdm)), N_ofdm, []);  % OFDM调制
ofdm_signal = ifft(X, [], 1);  % IFFT 转换为时域信号

cyclic_prefix = ofdm_signal(end-cyclic_prefix_length+1:end, :);  % 添加循环前缀
ofdm_signal_with_cp = [cyclic_prefix; ofdm_signal];
ofdm_signal_serial = ofdm_signal_with_cp(:).';  % 转换为串行信号

figure;  % 绘制 OFDM 时域信号
plot(real(ofdm_signal_serial));
title('OFDM 时域信号');
xlabel('样本');
ylabel('幅度');

OFDM_spectrum = fftshift(fft(ofdm_signal_serial));  % 频域表示
figure;
plot(abs(OFDM_spectrum));
xlim([0 10]);
title('OFDM 信号幅度谱');
xlabel('频率 (Hz)');
ylabel('幅度');
