% 信号与系统实验三
% 2023-04-24

% Fourier 级数
t = -6:0.01:6;
d = -6:2:6;
fxx = pulstran(t, d, 'tripuls');
f1 = fourierseries(3, t);
f2 = fourierseries(9, t);
f3 = fourierseries(21, t);
f4 = fourierseries(45, t);

% 绘制图像
subplot(3, 2, 1);
plot(t, fxx, 'r', t, f1, 'b');
xlabel('t');
ylabel('f(t)');
title('3 次谐波');
grid on;
axis([-6 6 -0.1 1.1]);
subplot(3, 2, 2);
plot(t, fxx, 'r', t, f2, 'b');
xlabel('t');
ylabel('f(t)');
title('9 次谐波');
grid on;
axis([-6 6 -0.1 1.1]);
subplot(3, 2, 3);
plot(t, fxx, 'r', t, f3, 'b');
xlabel('t');
ylabel('f(t)');
title('21 次谐波');
grid on;
axis([-6 6 -0.1 1.1]);
subplot(3, 2, 4);
plot(t, fxx, 'r', t, f4, 'b');
xlabel('t');
ylabel('f(t)');
title('45 次谐波');
grid on;
axis([-6 6 -0.1 1.1]);

% 单边幅度谱
n = 1:10;
a = zeros(size(n));
a(1) = 0.5;

for ii = 2:10
    a(ii) = abs(4 / (ii - 1) ^ 2 * pi ^ 2) * (1 - cos(ii - 2) * pi / 2);
end

n = 0:pi:9 * pi;
subplot(3, 2, 5);
stem(n, a, 'fill', 'linewidth', 2);
xlabel('\Omega = n\Omega 0');
ylabel('An');
title('单边幅度谱');
grid on;

% 单边相位谱
n = 1:10;
a = zeros(size(n));

for i = 1:10
    a(i) = angle(4 / (i ^ 2 * pi ^ 2) * (1 - cos(i * pi / 2)));
end

n = 0:pi:9 * pi;
subplot(3, 2, 6);
stem(n, a, 'fill', 'linewidth', 2);
xlabel('\Omega = n \Omega o');
ylabel('\Psi n');
title('单边相位谱');

function y = fourierseries(m, t)
    y = 0.25;

    for n = 1:m
        % y = y + 2 * sin(n * pi / 2) / (n * pi) .* cos(n * pi .* t);
        y = y + 4 / (n ^ 2 * pi ^ 2) * (1 - cos(n * pi / 2)) .* cos(n * pi .* t);
    end

end
