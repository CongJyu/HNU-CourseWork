% sp_lab_4_3

a = 1;
N = 2000;

u = normrnd(0, a, 1, N);

x = zeros(1, 1998);
x(1) = u(1);
x(2) = 0.9 * x(1) + u(2);

for n = 3:N
    x(n) = 0.9 * x(n - 1) - 0.2 * x(n - 2) + u(n);
end

m1 = 0;
m2 = 0;
m3 = 0;
m4 = 0;
n1 = 0;
n2 = 0;

for n = 3:1500
    m1 = m1 + x(n - 1) ^ 2;
    m2 = m2 + x(n - 1) * x(n - 2);
    m3 = m3 + x(n - 1) * x(n - 2);
    m4 = m4 + x(n - 2) ^ 2;
    n1 = n1 + x(n) * x(n - 1);
    n2 = n2 + x(n) * x(n - 2);
end

A = [m1, m2; m3, m4];
% A1 = inv(A);
B = [n1; n2];
C = A \ B;
a = C(1);
b = C(2);

disp([0.9, -0.2]);
disp([a, b]);
