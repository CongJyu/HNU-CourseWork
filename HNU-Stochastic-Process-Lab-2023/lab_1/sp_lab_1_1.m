% sp_lab_1_1

% 创建一个 1 x 100000 的向量，用来存储 u_1(n) 的值
u_1 = zeros(1, 100000);

% 创建一个 1 x 100000 的向量，用来存储 u_2(n) 的值
u_2 = zeros(1, 100000);

% 使用 rand 函数生成 [0, 1] 区间的随机数
for n = 1:100000
    u_1(n) = rand;
    u_2(n) = rand;
end

% 使用 plot 函数绘制 u_1(n) 和 u_2(n) 的散点图，以观察它们的分布情况
subplot(2, 2, 1);
plot(u_1, '.');
title('Scatter plot of u_1(n)');

subplot(2, 2, 2);
histogram(u_1);
title('Histogram for u_1(n)');

subplot(2, 2, 3);
plot(u_2, '.');
title('Scatter plot of u_2(n)');

subplot(2, 2, 4);
histogram(u_2);
title('Histogram for u_2(n)');
