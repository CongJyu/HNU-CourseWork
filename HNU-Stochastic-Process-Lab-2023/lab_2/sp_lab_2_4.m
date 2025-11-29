% sp_lab_2_4

% 给定参数
N = 128;
N_prime = 32;
omega = 0.2 * pi;
n_0 = 64;
S = 1;

% 设置噪声样本序列的均值和标准差
% rng(2023);
mu = 0;
sigma = 0.2;

% 生成正态分布随机噪声样本序列
u = normrnd(mu, sigma, [1, N]);

rxsN = zeros(1, 97);

for m = 0:96

    for n = m + 1:m + N_prime
        rxsN(m + 1) = rxsN(m + 1) + u(n) * cos(omega * (n - m));
    end

    rxsN(m + 1) = rxsN(m + 1) / N_prime;
end

stem((0:96), rxsN);
xlabel('n');
ylabel('r_{xsN}(m)');
title('Wave of r_{xsN}(m) when no signals');
