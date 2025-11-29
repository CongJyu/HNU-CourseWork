% 信号与系统实验一
% 2023-04-17

% 生成信号图像：(2 - e^(-t)) * u(t)
t = linspace(-5, 5, 1000); % 生成时间序列
y = (2 - exp(-t)) .* heaviside(t); % 生成信号序列
subplot(3, 1, 1);
plot(t, y); % 绘制信号波形
grid on;
xlabel('时间');
ylabel('幅值');
title('信号波形');

% 生成信号图像：u(cost)
t = linspace(-pi, pi, 1000); % 生成时间序列
y = heaviside(cos(t)); % 生成信号序列
subplot(3, 1, 2);
plot(t, y); % 绘制信号波形
grid on;
xlabel('时间');
ylabel('幅值');
title('信号波形');

% 生成信号图像：周期为 1，幅度为 1，占空比为 0.5 的周期矩形信号
t = linspace(-5, 5, 1000); % 生成时间序列
y = square(2 * pi * t, 50); % 生成周期矩形信号，其中50表示占空比为50 %
subplot(3, 1, 3);
plot(t, y); % 绘制信号波形
grid on;
xlabel('时间');
ylabel('幅值');
title('周期矩形信号');
