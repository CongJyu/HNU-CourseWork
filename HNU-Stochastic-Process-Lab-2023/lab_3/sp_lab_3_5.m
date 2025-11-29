% sp_lab_3_5

Rx = rand(1, 6);

for m = 1:1:6
    sum = 0;

    for n = (3 + m):1:2000
        sum = sum + x(n) * x(n - m + 1);
    end

    Rx(m) = sum / (1990 - m);
end

S1 = rand(1, 1000);

for i = 1:1:1000
    S1(i) = Rx(1) + 2 * Rx(2) * cos(i * 0.001 * pi) + 2 * Rx(3) * cos(2 * i * 0.001 * pi);
end

stem(S1);
title('S_1');
