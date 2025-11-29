% sp_lab_2_1

% 设置随机数种子
rng(2023);
% 设置噪声样本序列的长度
N = 128;
% 设置噪声样本序列的均值和标准差
mu = 0;
sigma = 0.2;
% 生成正态分布随机噪声样本序列
u = normrnd(mu, sigma, [1, N]);
% 显示噪声样本序列的图像
stem(u);
xlabel('n');
ylabel('u(n)');
title('Normal distribution random noise sample sequence');
