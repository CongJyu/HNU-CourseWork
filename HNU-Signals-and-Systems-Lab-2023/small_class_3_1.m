% 小班课

% Fourier 级数
t = -6:0.01:6;
d = -6:2:6;
fxx = pulstran(t, d, 'rectpuls');
f1 = fourierseries(3, t);
f2 = fourierseries(5, t);
f3 = fourierseries(7, t);
f4 = fourierseries(9, t);

% 绘制图像
subplot(2, 2, 1);
plot(t, fxx, 'r', t, f1, 'b');
xlabel('t');
ylabel('f(t)');
title('3 次谐波');
grid on;
axis([-6 6 -0.1 1.1]);
subplot(2, 2, 2);
plot(t, fxx, 'r', t, f2, 'b');
xlabel('t');
ylabel('f(t)');
title('5 次谐波');
grid on;
axis([-6 6 -0.1 1.1]);
subplot(2, 2, 3);
plot(t, fxx, 'r', t, f3, 'b');
xlabel('t');
ylabel('f(t)');
title('7 次谐波');
grid on;
axis([-6 6 -0.1 1.1]);
subplot(2, 2, 4);
plot(t, fxx, 'r', t, f4, 'b');
xlabel('t');
ylabel('f(t)');
title('9 次谐波');
grid on;
axis([-6 6 -0.1 1.1]);

function y = fourierseries(m, t)
    y = 0.5;

    for n = 1:m
        y = y + 2 * sin(n * pi / 2) / (n * pi) .* cos(n * pi .* t);
    end

end
