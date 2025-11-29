% sp_lab_3_1

% 设置随机数种子
rng(2023);
N = 2000;
% 设置噪声样本序列的均值和标准差
mu = 0;
sigma = 1;
% 生成正态分布随机噪声样本序列
u = normrnd(mu, sigma, [1, N]);

stem(u);
xlabel('n');
ylabel('u(n)');
title('噪声 u(n) 波形');
grid on;
