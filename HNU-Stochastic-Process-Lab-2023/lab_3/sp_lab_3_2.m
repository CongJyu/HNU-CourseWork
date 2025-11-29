% sp_lab_3_2

% 设置随机数种子
rng(2023);
N = 2000;
% 设置噪声样本序列的均值和标准差
mu = 0;
sigma = 1;
% 生成正态分布随机噪声样本序列
u = normrnd(mu, sigma, [1, N]);

subplot(2, 1, 1);
stem(u, '.');
title('u(n)');

n = 3:2000;
x(n) = u(n) - 0.36 * u(n - 1) + 0.85 * u(n - 2);
subplot(2, 1, 2);
stem(x, '.');
title('x(n)');
