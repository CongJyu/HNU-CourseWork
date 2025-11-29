% 信号与系统实验一
% 2023-04-18

% 思考题 1
t = -5:0.001:5;
y = initialsignal(t);
y1 = initialsignal(t + 2);
y2 = initialsignal(-t + 2);
subplot(3, 1, 1);
plot(t, y);
grid on;
xlabel('t');
ylabel('y');
subplot(3, 1, 2);
plot(t, y1);
grid on;
xlabel('t');
ylabel('y1');
subplot(3, 1, 3);
plot(t, y2);
grid on;
xlabel('t');
ylabel('y2');

% 思考题 2
% f = initialsignal (t) ;
% fl = initialsignal (t + 4) ;
% f2 = initialsignal (-2 * t + 4) ;
% f3 = initialsignal (2 * t) ;
% f4 = initialsignal (-2 * t) ;
% f5 = initialsignal(-2 * (t - 2));

function y = initialsignal(t)
    y = t .* (heaviside(t) - heaviside(t - 1)) - heaviside(t - 1) + heaviside(t - 2);
end
