% 信号与系统实验三
% 2023-04-24

% 时移和频移性质

T = 0.01;
t = -6:0.01:6;
dw = 0.1;
w = -4 * pi:dw:4 * pi;
F1 = rectpuls(t) * exp(-1i * t' * w) * T;
F2 = rectpuls(t - 4) * exp(-1i * t' * w) * T;
a1 = abs(F1);
phaF1 = angle(F1);
a2 = abs(F2);
phaF2 = angle(F2);

figure(1);

% f(t) 幅度谱
subplot(2, 2, 1);
plot(w, a1);
xlabel('fw');
ylabel('|Fn|');
title('f(t)幅度谱');
grid on;

% f(t - 4) 幅度谱
subplot(2, 2, 2);
plot(w, a2);
xlabel('fw');
ylabel('|Fn|');
title('f(t-4)幅度谱');
grid on;

% f(t) 相位谱
subplot(2, 2, 3);
plot(w, phaF1);
xlabel('fw');
ylabel('\Psi n');
title('f(t)相位谱');
grid on;

% f(t - 4) 相位谱
subplot(2, 2, 4);
plot(w, phaF2);
xlabel('fw');
ylabel('\Psi n');
title('f(t - 4)相位谱');
grid on;

% 对称性质

T = 0.01;
t = -6:0.01:6;
dw = 0.1;
w = -4 * pi:dw:4 * pi;
y = sinc(2 * t / pi);
F3 = y * exp(-1i * t' * w) * T;
F4 = (heaviside(-t / 2) - heaviside(t / 2)) * exp(-1i * t' * w) * T;
a3 = abs(F3);
phaF3 = angle(F3);
a4 = abs(F4);
phaF4 = angle(F4);

figure(2);

subplot(2, 2, 1);
plot(w, a3);
xlabel('w');
ylabel('|F3n|');
title('Sa(\Omega_0 t) 幅度谱');

subplot(2, 2, 2);
plot(w, a4);
xlabel('w');
ylabel('|F4n|');
title('g_\tau (t) 幅度谱');

subplot(2, 2, 3);
plot(w, phaF3);
xlabel('w');
ylabel('\Psi 3n');
title('Sa(\Omega_0 t) 相位谱');

subplot(2, 2, 4);
plot(w, phaF4);
xlabel('w');
ylabel('\Psi 4n');
title('g_\tau (t) 相位谱');

% 尺度变换性质

T = 0.01;
t = -6:0.01:6;
dw = 0.1;
w = -4 * pi:dw:4 * pi;
F5 = rectpuls(t) * exp(-1i * t' * w) * T;
F6 = rectpuls(2 * t) * exp(-1i * t' * w) * T;
a5 = abs(F5);
phaF5 = angle(F5);
a6 = abs(F6);
phaF6 = angle(F6);

figure(3);

% f(t) 幅度谱
subplot(2, 2, 1);
plot(w, a5);
xlabel('fw');
ylabel('|F5n|');
title('f(t)幅度谱');
grid on;

% f(2 * t) 幅度谱
subplot(2, 2, 2);
plot(w, a6);
xlabel('fw');
ylabel('|F6n|');
title('f(2t)幅度谱');
grid on;

% f(t) 相位谱
subplot(2, 2, 3);
plot(w, phaF5);
xlabel('fw');
ylabel('\Psi 5n');
title('f(t)相位谱');
grid on;

% f(t - 4) 相位谱
subplot(2, 2, 4);
plot(w, phaF6);
xlabel('fw');
ylabel('\Psi 6n');
title('f(2t)相位谱');
grid on;
