% 通信原理 实验 8 汉明码/线性分组码

clc;
clear;

% 矩阵定义
n = 7;
k = 4;
A = [1 1 1; 1 1 0; 1 0 1; 0 1 1];
% code(5) = code(1) ^ code(2) ^ code(3)
% code(6) = code(1) ^ code(2) ^ code(4)
% code(7) = code(1) ^ code(3) ^ code(4)
G = [eye(k) A];  % 生成矩阵
H = [A' eye(n - k)];  % 奇偶校验矩阵

% 编码
msg = [randi([0, 1]), randi([0, 1]), randi([0, 1]), randi([0, 1])];  % 信息比特
code = mod(msg * G, 2);  % 编码
original = code;

% 模拟在信道中传输时出现错误，随机取一位使其出错
error_bit = randi(7);
code(error_bit) = ~code(error_bit);  % 使特定位置上的码字翻转，模拟出错

received = code;  % 接收机收到的码
syndrome = mod(received * H', 2); % 译码

% 寻找错误码字的位置
find = 0;  % 标志，没有找到错误码字为 0，找到错误码字为 1
for counter = 1:1:n
    if ~find
        error_vec = zeros(1, n);
        error_vec(counter) = 1;
        search = mod(error_vec * H', 2);
        if search == syndrome
            find = 1;  % 寻找到错误码字之后将 find 标志赋值为 1
            index = counter;
        end
    end
end

% 输出结果和日志
disp('原始码字:');
disp(original);
disp('接收码字:');
disp(received);
disp('是否找到:');
disp(find);
disp('错码位置:');
disp(index);
