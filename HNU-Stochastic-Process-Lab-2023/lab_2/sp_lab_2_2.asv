% sp_lab_2_2

% 给定参数
N = 128;
N_prime = 32;
omega = 0.2 * pi;
n_0 = 64;
S = 1;

n = 1:N_prime;
s = cos(omega * n);
s = [zeros(1, n_0), s, zeros(1, N - n_0 - N_prime)];

stem((1:N), s);
xlabel('n');
ylabel('s(n)');
title('Wave of s(n-n_0)');
