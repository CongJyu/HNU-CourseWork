% sp_lab_3_6

N = 1000;
p1 = 0;
p2 = 0;
p3 = 0;
p4 = 0;

for n = 1:1:N

    if (x(n) < -1)
        p1 = p1 + 1;
    else

        if (x(n) >= -1 && x(n) <= 0)
            p2 = p2 + 1;
        else

            if (x(n) > 0 && x(n) <= 1)
                p3 = p3 + 1;
            else
                p4 = p4 + 1;
            end

        end

    end

end

disp('实验值: ');

P_1 = p1 / N;
P_2 = p2 / N;
P_3 = p3 / N;
P_4 = p4 / N;
exp_value = [P_1, P_2, P_3, P_4];
disp(exp_value);

P_2 = 0;

for i = 1:100000
    P_2 = P_2 + 1 / (sqrt(2 * pi) * 1.262) * exp(- (i * 0.00001) * (i * 0.00001) / (2 * 1.262 * 1.262)) * 0.00001;
end

P_3 = P_2;
P_1 = (1 - 2 * P_2) / 2;
P_4 = P_1;

ideal_value = [P_1, P_2, P_3, P_4];
disp('理想值: ');
disp(ideal_value);
