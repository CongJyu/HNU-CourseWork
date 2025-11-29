% 通信原理 实验 7 PCM编译码

clc;
clear;

% 生成模拟信号
fs = 1000;  % 采样频率
t = 0:1/fs:1;  % 时间向量
f = 1;  % 信号频率
signal = sin(2 * pi * f * t);  % 生成正弦信号

% 绘制原始信号
subplot(2, 3, 1);
plot(t, signal);
title('原始信号');
xlabel('时间 (s)');
ylabel('幅度');

% 对信号进行抽样
fs_sample = 100;  % 抽样频率
t_sample = 0:1/fs_sample:1;  % 抽样时间向量
sampled_signal = sin(2 * pi * f * t_sample);  % 抽样信号

% 绘制抽样信号与原始信号对比
subplot(2, 3, 2);
stem(t_sample, sampled_signal);
hold on;
plot(t, signal, '--');
title('抽样信号与原始信号对比');
xlabel('时间 (s)');
ylabel('幅度');
legend('抽样信号', '原始信号');

% 对抽样信号进行PCM编码
n_bits = 8;  % 编码位数
quantized_signal = round((sampled_signal + 1) * (2^(n_bits-1) - 1));  % 量化
encoded_signal = de2bi(quantized_signal, n_bits, 'left-msb');  % 二进制编码

% 绘制PCM编码波形
subplot(2, 1, 2);
stairs(reshape(encoded_signal', 1, []));  % 展平编码信号并绘制
title('PCM编码波形');
xlabel('样本');
ylabel('编码值');
ylim([-0.2 1.2]);
grid on;

% 显示某个样本的8位编码
sample_index = 2;  % 选择一个样本
disp(['样本 ', num2str(sample_index), ' 的 8 位编码: ', num2str(encoded_signal(sample_index, :))]);

% PCM解码
decoded_signal = bi2de(encoded_signal, 'left-msb') / (2^(n_bits-1) - 1) - 1;  % 解码并归一化

% 绘制解码信号与原始信号对比
subplot(2, 3, 3);
stem(t_sample, decoded_signal);
hold on;
plot(t, signal, '--');
title('解码信号与原始信号对比');
xlabel('时间 (s)');
ylabel('幅度');
legend('解码信号', '原始信号');

% 失真度分析
decoded_signal_interpolated = interp1(t_sample, decoded_signal, t, 'linear', 'extrap');  % 插值以计算MSE
mse = mean((signal - decoded_signal_interpolated).^2);  % 计算均方误差
disp(['均方误差: ', num2str(mse)]);
