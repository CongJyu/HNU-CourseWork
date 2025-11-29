% sp_lab_1_3

% 定义参数
alpha = 0.6; % alpha 值
sigma_x = 2; % sigma_x 值
sigma = 1; % sigma 值
m = 0; % m 值
N = 100000; % 序列长度

% 生成 e(n) 序列
u1 = rand(N, 1); % 生成 N 个服从均匀分布的随机数 u1(n)
u2 = rand(N, 1); % 生成 N 个服从均匀分布的随机数 u2(n)
e = sigma * sqrt(-2 * log(u1)) .* cos(2 * pi * u2) + m; % 根据公式计算 e(n)

% 生成 x(n) 序列
x = zeros(N, 1); % 初始化 x(n) 序列为零向量
x(1) = alpha * 0 + sigma_x * sqrt(1 - alpha ^ 2) * e(1); % 计算 x(1) 的值

for n = 2:N % 循环计算 x(n) 的值
    x(n) = alpha * x(n - 1) + sigma_x * sqrt(1 - alpha ^ 2) * e(n); % 根据公式计算 x(n)
end

% 绘制 x(n) 的图像
subplot(2, 1, 1);
plot(x, '.'); % 使用 plot 函数绘制 x(n) 的图像
xlabel('n'); % 设置 x 轴的标签为 n
ylabel('x(n)'); % 设置 y 轴的标签为 x(n)
title('x(n) = alpha * x(n-1) + sigma_x * sqrt(1 - alpha ^ 2) * e(n)'); % 设置图像的标题

subplot(2, 1, 2);
histogram(x);
title('Histogram for x(n)');
