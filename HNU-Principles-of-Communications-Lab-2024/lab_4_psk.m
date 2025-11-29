% 通信原理 实验 4 2ASK/2FSK/2PSK/2DPSK+AWGN

% 2PSK
clc;
clear;

fs = 50;
fc = 15;
t = 0:1/fs:10;
n = length(t);
f = (0:n-1) * fs / n - fs / 2;

% 双极性基带信号 m(t)
r = 2 * round(rand(1, 10)) - 1;  % 随机生成 01 序列
m = zeros(1, 10 * fs);
for i = 1:10
    m(fs * (i - 1) + 1:fs * i) = r(i); 
end
m=[m, m(length(m))];

% 2PSK 信号
c = cos(2 * pi * fc * t);  % 载波 c(t)
e = m .* c; 
subplot(2, 1, 1);
plot(t, e);
xlim([0 8]);
ylim([-1.1 1.1]);
title('e_{2PSK}(t)');
E = fftshift(fft(e));
subplot(2, 1, 2);
plot(f, abs(E));
xlim([-25 25]);
title('|E_{2PSK}(f)|');

% 星座图
M = 2;
data = randi([0 M - 1], 1000, 1);
txSig = pskmod(data, M, pi / M);
rxSig = awgn(txSig, 10);
h = scatterplot(rxSig);
hold on
scatterplot([-1i 1i],[],[],'*',h); 
hold off

% 相干解调
en = awgn(e, 10);
[b1, a1] = butter(6, [fc-5 fc+5] / (fs / 2));
en1 = filter(b1, a1, en);  % 带通滤波
figure;
plot(t, en1);
xlim([0 8]);
title('en1');
en2 = en1 .* c;  % 相乘器
figure;
plot(t, en2);
xlim([0 8]);
title('en2');
[b2, a2] = butter(10, 5 / (fs / 2));
en3 = filter(b2, a2, en2);  % 低通滤波
figure;
plot(t, en3);
xlim([0 8]);
title('en3');

% 抽样判决
C = ones(1, 10);
for i = 1:10
    if(en3((i - 1) * fs + fs / 2) < 0)
        C(i) = -1;
    end
end

% 比较
x = zeros(1, 10 * fs);  % 解调信号 x(t)
for i = 1:10
    x(fs * (i - 1) + 1:fs * i) = C(i);
end
x=[x, x(length(x))];
figure;
plot(t, m, t + 0.5, x);
xlim([0 8]);
ylim([-1.1 1.1]);
legend('原始基带信号m(t)','解调信号x(t)');
