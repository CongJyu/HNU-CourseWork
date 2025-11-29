% 设置方波周期为1，采样率为1000 Hz，采样点数为1000
T = 1;
fs = 1000;
N = 1000;

% 生成方波
t = linspace(0, T, N);
x = square(2 * pi * t / T);

% 求取前7次谐波系数
a0 = 0;
a1 = 2 / T;
a = zeros(1, 6);

for n = 1:length(a)
    a(n) = 4 / (n * pi * T);
end

% 绘制前7次谐波合成波形
t_all = linspace(0, 7 * T, N * 7);
x_harm = zeros(size(t_all));

for n = 1:length(a)
    x_harm = x_harm + a(n) * sin(2 * pi * n * t_all / T);
end

x_harm = x_harm + a0 / 2;
subplot(3, 1, 1)
plot(t_all, x_harm);

% 求取前11次谐波系数
a = zeros(1, 10);

for n = 1:length(a)
    a(n) = 4 / (n * pi * T);
end

% 绘制前11次谐波合成波形
t_all = linspace(0, 11 * T, N * 11);
x_harm = zeros(size(t_all));

for n = 1:length(a)
    x_harm = x_harm + a(n) * sin(2 * pi * n * t_all / T);
end

x_harm = x_harm + a0 / 2;

% 绘制前7次谐波合成波形
x_harm_7 = zeros(size(t_all));

for n = 1:7
    x_harm_7 = x_harm_7 + a(n) * sin(2 * pi * n * t_all / T);
end

x_harm_7 = x_harm_7 + a0 / 2;

% 绘制谐波合成波形比较图
% figure;
subplot(3, 1, 2)
plot(t_all, x_harm_7, 'r', t_all, x_harm, 'b');
legend('前7次谐波合成', '前11次谐波合成');

% 求取3、5、7次谐波系数
a3 = 4 / (3 * pi * T);
a5 = 4 / (5 * pi * T);
a7 = 4 / (7 * pi * T);

% 绘制不含基波的3、5、7次谐波合成波形
x_harm_357 = a3 * sin(2 * pi * 3 * t_all / T) + a5 * sin(2 * pi * 5 * t_all / T) + a7 * sin(2 * pi * 7 * t_all / T);

% 绘制前7次谐波合成波形
x_harm_7 = zeros(size(t_all));

for n = 1:7
    x_harm_7 = x_harm_7 + a(n) * sin(2 * pi * n * t_all / T);
end

x_harm_7 = x_harm_7 + a0 / 2;

% 绘制谐波合成波形比较图
subplot(3, 1, 3)
plot(t_all, x_harm_7, 'r', t_all, x_harm_357, 'b--');
legend('前7次谐波合成', '不含基波的3、5、7次谐波合成');
