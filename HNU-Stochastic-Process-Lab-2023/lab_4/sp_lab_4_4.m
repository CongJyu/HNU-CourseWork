% sp_lab_4_4

a = 1;
N = 2000;

u = normrnd(0, a, 1, N);
x = zeros(1, 1998);
x(1) = u(1);
x(2) = 0.9 * x(1) + u(2);

for n = 3:N
    x(n) = 0.9 * x(n - 1) - 0.2 * x(n - 2) + u(n);
end

y = zeros(1, 2000);
n = (1501:2000);
y(n) = a * x(n - 1) + b * x(n - 2);

stem(x, '.r');
hold on;
stem(y, '.b');
grid on;
