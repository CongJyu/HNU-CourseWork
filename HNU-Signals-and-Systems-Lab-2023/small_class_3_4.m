% 信号与系统小班课

% 生成周期为1的脉冲
% 生成方形脉冲信号
t1 = linspace(-50, 50, 1000);
x1 = square(t1, 50);
t2 = linspace(-50, 50, 1000);
x2 = square(t2, 70);
t3 = linspace(-50, 50, 1000);
x3 = square(t3, 90);

% 计算频谱
X1 = fftshift(fft(x1));
X2 = fftshift(fft(x2));
X3 = fftshift(fft(x3));

% 绘制时域和频域波形
subplot(2, 3, 1);
plot(t1, x1);
xlabel('Time');
ylabel('Amplitude');
title('Time Domain');
grid on;

subplot(2, 3, 4);
f = linspace(-500, 499, 1000);
plot(t1, abs(X1));
xlabel('Frequency');
ylabel('Magnitude');
title('Frequency Domain');
grid on;

% 绘制时域和频域波形
subplot(2, 3, 2);
plot(t2, x2);
xlabel('Time');
ylabel('Amplitude');
title('Time Domain');
grid on;

subplot(2, 3, 5);
f = linspace(-500, 499, 1000);
plot(t2, abs(X2));
xlabel('Frequency');
ylabel('Magnitude');
title('Frequency Domain');
grid on;

% 绘制时域和频域波形
subplot(2, 3, 3);
plot(t3, x3);
xlabel('Time');
ylabel('Amplitude');
title('Time Domain');
grid on;

subplot(2, 3, 6);
f = linspace(-500, 499, 1000);
plot(t3, abs(X3));
xlabel('Frequency');
ylabel('Magnitude');
title('Frequency Domain');
grid on;
