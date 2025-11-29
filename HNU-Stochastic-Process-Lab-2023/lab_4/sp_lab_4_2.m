% sp_lab_4_2

a = 1;
N = 2000;

u = normrnd(0, a, 1, N);

x = zeros(1, 1998);
x(1) = u(1);
x(2) = 0.9 * x(1) + u(2);

for n = 3:N
    x(n) = 0.9 * x(n - 1) - 0.2 * x(n - 2) + u(n);
end

subplot(2, 1, 1);
stem((1:N), u, '.b');
title('u(n) 波形');
grid on;

subplot(2, 1, 2);
stem((1:N), x, '.r');
title('x(n) 波形');
grid on;
