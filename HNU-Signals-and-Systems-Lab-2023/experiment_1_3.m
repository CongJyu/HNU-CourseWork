% 信号与系统实验一
% 2023-04-17

t = -2:0.001:5;
y = t .* (heaviside(t) - heaviside(t - 1)) - heaviside(t - 1) + heaviside(t - 2);
subplot(4, 2, 1);
plot(t, y);
grid on;
xlabel('t');
ylabel('y');
title('f(t)');

% f(t) + f(t)
y1 = y + y;
subplot(4, 2, 2);
plot(t, y1);
grid on;
xlabel('t');
ylabel('y1');
title('f(t)+f(t)');

% f(t) * f(t)
y2 = y .* y;
subplot(4, 2, 3);
plot(t, y2);
grid on;
xlabel('t');
ylabel('y2');
title('f(t)*f(t)');

% 微分
x = sym('x');
y3 = x * (heaviside(x) - heaviside(x - 1)) - heaviside(x - 1) + heaviside(x - 2);
dfy3 = diff(y3);
subplot(4, 2, 4);
fplot(dfy3, [-2, 5]);
grid on;
xlabel('x');
ylabel('dfy');
title('微分');

% 积分
x = sym('x');
y4 = x * (heaviside(x) - heaviside(x - 1)) - heaviside(x - 1) + heaviside(x - 2);
iny4 = int(y4);
subplot(4, 2, 5);
fplot(iny4, [-2, 5]);
grid on;
xlabel('x');
ylabel('iny');
title('积分')

% f(3-4t)
t = -2:0.001:5;
y5 = initialsignal(3 - 4 * t);
subplot(4, 2, 6);
plot(t, y5);
grid on;
xlabel('t');
ylabel('y5');
title('f(3-4t)');

% f(1-t/1.5)
t = -2:0.001:5;
y6 = initialsignal(1 - t / 1.5);
subplot(4, 2, 7);
plot(t, y6);
grid on;
xlabel('t');
ylabel('y6');
title('f(1-t/1.5)');

% 卷积
t = -10:0.01:10; % 生成时间序列，步长为0.01
x = initialsignal(t);
h = initialsignal(3 - 4 * t);
convolution = conv(x, h, 'same'); % 计算卷积
subplot(4, 2, 8);
plot(t, convolution); % 绘制卷积的波形
xlabel('时间');
ylabel('幅值');
title('卷积');

function y = initialsignal(t)
    y = t .* (heaviside(t) - heaviside(t - 1)) - heaviside(t - 1) + heaviside(t - 2);
end
