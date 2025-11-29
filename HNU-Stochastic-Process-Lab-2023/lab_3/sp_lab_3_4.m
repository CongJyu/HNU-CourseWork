% sp_lab_3_4

Rx = rand(1, 6);

for m = 1:1:6
    sum = 0;

    for n = (3 + m):1:2000
        sum = sum + x(n) * x(n - m + 1);
    end

    Rx(m) = sum / (1990 - m);
end

disp('实验值: ');
disp(Rx);

theoretical = [1.1296, -0.666, 0.85, 0, 0, 0];
disp('理论值: ');
disp(theoretical);
