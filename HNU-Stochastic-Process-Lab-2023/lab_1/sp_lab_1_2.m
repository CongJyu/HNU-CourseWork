% sp_lab_1_2

% 定义均值和方差
m = 0;
sigma = 1;

% 定义序列长度
N = 100000;

% 生成两个独立的均匀分布序列
u1 = rand (N, 1);
u2 = rand (N, 1);

% 用 Box-Muller 方法生成正态分布序列
e = sigma * sqrt (-2 * log (u1)) .* cos (2 * pi * u2) + m;

subplot(3, 2, 1);
plot(u1, '.');
title('u_1(n)');
subplot(3, 2, 2);
histogram(u1);
title('Histogram for u_1(n)');

subplot(3, 2, 3);
plot(u2, '.');
title('u_2(n)');
subplot(3, 2, 4);
histogram(u2);
title('Histogram for u_2(n)');

subplot(3, 2, 5);
plot(e, '.');
title('e(n)');
subplot(3, 2, 6);
histogram(e);
title('Histogram for e(n)');
