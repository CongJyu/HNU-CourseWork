% sp_lab_1_4

u1 = rand(1, 100000);
u2 = rand(1, 100000);

en = sqrt(-2 * log(u1)) .* cos(2 * pi * u2);
alpha = 0.6;
x(1) = 2 * sqrt(1 - alpha * alpha) * en(1);

% 均值
sum = 0;

for i = 1:100000
    sum = sum + x(i);
end

mx = sum / 100000;

% 均方值
sum = 0;

for i = 1:100000
    sum = sum + x(i) * x(i);
end

ax = sqrt(sum / 100000);

for k = 1:4
    sum = 0;

    for j = 1:100000 - k
        sum = sum + x(j) * x(j + k);
    end

    r(k) = sum / (100000 - k);
end

disp(mx);
disp(ax);
r(1)
r(2)
r(3)
r(4)
