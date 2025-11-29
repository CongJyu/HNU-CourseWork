% sp_lab_4_1

a = 1;
N = 2000;

u = normrnd(0, a, 1, N);
stem((1:N), u, '.b');
title('u(n) 波形');
grid on;
