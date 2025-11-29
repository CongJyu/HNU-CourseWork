% 信号与系统实验二
% 2023-04-19

% 信号一
n = -10:10;
f1 = (2 - 0.5 .^ (-n)) .* heaviside(n);
subplot(2, 1, 1);
stem(n, f1, "fill");
xlabel('n');
ylabel('f1');
title('信号 (2 - {0.5}^{n}) * u(n)');
grid on;

% 信号二
n = -10:50;
f2 = (3/2) .^ n .* sin((n * pi) / 5);
subplot(2, 1, 2);
stem(n, f2, "fill");
xlabel('n');
ylabel('f2');
title('信号 {(3/2)}^{n} * sin((n {\pi}) / 5)');
grid on;
