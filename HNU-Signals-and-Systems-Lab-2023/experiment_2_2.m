% 信号与系统实验二
% 2023-04-19

n = -5:1:5;
y = initalsignal(n);
subplot(3, 2, 1);
stem(n, y, "fill");
xlabel('n');
ylabel('f');
title('初始信号');
grid on;

% 一阶后向差分
n = -5:1:5;
y = initalsignal(n);
dy = y - [-5, y(1:end - 1)]; % 一阶后向差分
subplot(3, 2, 2);
stem(n, dy, "fill");
xlabel('n');
ylabel('dy');
title('一阶后向差分');
grid on;

% f(3 - 2n)
n = -5:1:5;
y3 = initalsignal(3 - 2 * n);
subplot(3, 2, 3);
stem(n, y3, "fill");
xlabel('n');
ylabel('y3');
title('f(3-2n)');
grid on;

% 累加和
n = -5:1:5;
y2 = initalsignal(n);
result = cumsum(y2);
subplot(3, 2, 4);
stem(n, result, "fill");
xlabel('n');
ylabel('result');
title('累加和');

% 卷积
n = -5:1:5;
x = initalsignal(n);
h = initalsignal(3 - 2 * n);
conv_result = conv(x, h, 'same');
subplot(3, 2, 5);
stem(n, conv_result, "fill");
xlabel('n');
ylabel('result');
title('卷积');

function y = initalsignal(n)
    oldparam = sympref('HeavisideAtOrigin', 1);
    y = heaviside(n) - heaviside(n - 4);
end
