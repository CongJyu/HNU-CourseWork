% 信号与系统实验三
% 2023-04-24

m = input('输入占空比:');
n = -20:20;
F = zeros(size(n));

for ii = -20:20
    F(ii + 21) = sin(ii * pi * m) / (ii * pi + eps);
end

F(21) = m;
F1 = abs(F);
phaF = angle(F); % 复角

% 幅度谱
subplot(2, 1, 1);
stem(n, F1, 'fill');
xlabel('\bf n \rightarrow');
ylabel('\bf |Fn| \rightarrow');
title('周期矩形脉冲的幅度谱 \tau / T = m');
grid on;

% 相位谱
subplot(2, 1, 2);
stem(n, phaF, 'fill');
xlabel('\bf n \rightarrow');
ylabel('\bf \Psi n \rightarrow');
title('周期矩形脉冲的相位谱 \tau / T = m');
grid on;
