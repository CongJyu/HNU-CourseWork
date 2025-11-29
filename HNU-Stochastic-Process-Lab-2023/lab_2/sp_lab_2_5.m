% sp_lab_2_5

% 给定参数
N = 128;
N_prime = 32;
omega = 0.2 * pi;
n_0 = 64;
S = 1;

n = 1:N_prime;
s = cos(omega * n);
s = [zeros(1, n_0), s, zeros(1, N - n_0 - N_prime)];
subplot(3, 1, 1);
stem((1:128), s);
xlabel('n');
ylabel('s(n)');
title('Wave of s(n)');

% 设置噪声样本序列的均值和标准差
% rng(2023);
mu = 0;

sigma = 0.2;

% 生成正态分布随机噪声样本序列
u = normrnd(mu, sigma, [1, N]);
subplot(3, 1, 2);
stem((1:128), u);
xlabel('n');
ylabel('u(n)');
title('Wave of u(n)');

x = s + u;
subplot(3, 1, 3);
stem((1:128), x);
xlabel('n');
ylabel('x(n)');
title('Wave of x(n)');

rxsN = zeros(1, 97);

for m = 0:96

    for n = m + 1:m + N_prime
        rxsN(m + 1) = rxsN(m + 1) + x(n) * cos(omega * (n - m));
    end

    rxsN(m + 1) = rxsN(m + 1) / N_prime;
end

stem((0:96), rxsN);
xlabel('n');
ylabel('r_{xsN}(m)');
title('Wave of r_{xsN}(m) when input signals');
