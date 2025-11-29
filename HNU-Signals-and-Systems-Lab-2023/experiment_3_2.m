% 信号与系统实验三
% 2023-04-24

% 单个三角脉冲
t = -6:0.01:6;
f = tripuls(t, 1);
dw = 0.1;
w = -12 * pi:0.1:12 * pi;
F = f * exp(-1i * t' * w) * 0.01;
F1 = abs(F);
phaF = angle(F); % 复角计算
subplot(2, 2, 1);
plot(t, f);
axis([-6 6 0 1]);
xlabel('t');
ylabel('f(t)');
title('单个三角脉冲波形');
grid on;

% 单个三角脉冲的幅度谱
subplot(2, 2, 2);
plot(w, F1);
xlabel('\Omega');
ylabel('幅度');
title('单个三角脉冲的幅度谱');
grid on;

% 单个三角脉冲的相位谱
subplot(2, 2, 3);
plot(w, phaF);
xlabel('\Omega');
ylabel('相位');
title('单个三角波的相位谱');
grid on;
