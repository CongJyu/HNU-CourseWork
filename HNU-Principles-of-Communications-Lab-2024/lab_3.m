% 通信原理 实验 3 时域迫零均衡（多径/AWGN/多径+AWGN）和眼图

clc;
clear;

% 1. 产生双极性序列
sequence_length = 1000;  % 序列长度
bipolar_seq = 2 * randi([0, 1], sequence_length, 1) - 1;

% 2. 多抽头滤波器卷积，产生码间串扰
channel_taps = [0.1, 1.5, 0.1];  % 抽头
signal_with_isi = conv(bipolar_seq, channel_taps, 'same');

% 3. 过采样 & 升余弦滤波
sps = 8;  % 过采样率
span = 10;  % 滤波器点数
beta = 0.25;  % 滚降系数

upsampled_signal = zeros(length(signal_with_isi) * sps, 1);
upsampled_signal(1:sps:end) = signal_with_isi;

rcos_filter = rcosdesign(beta, span, sps, 'normal');
shaped_signal = conv(upsampled_signal, rcos_filter, 'same');

% 4. 绘制未均衡眼图
eyediagram(shaped_signal, 2 * sps);
title('未均衡时 眼图');

% 5. 迫零均衡，重复
num_iterations = 3;  % 重复 3 次
equalized_signal = signal_with_isi;

for i = 1:num_iterations
    h_inv = pinv(channel_taps);
    equalized_signal = filter(h_inv, 1, equalized_signal);
    upsampled_equalized_signal = zeros(length(equalized_signal) * sps, 1);
    upsampled_equalized_signal(1:sps:end) = equalized_signal;
    shaped_equalized_signal = conv(upsampled_equalized_signal, rcos_filter, 'same');
    eyediagram(shaped_equalized_signal, 2 * sps);
    title(['迭代后 眼图' num2str(i)]);
end
