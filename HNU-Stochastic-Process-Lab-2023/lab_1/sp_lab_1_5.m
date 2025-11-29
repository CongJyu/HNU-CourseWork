% sp_lab_1_5

u1 = rand(1, 100000);
u2 = rand(1, 100000);

en = sqrt(-2 * log(u1)) .* cos(2 * pi * u2);
a = 0.5;

x(1) = 2 * sqrt(1 - a * a) * en(1);

for n = 1:99999
    x(n + 1) = a * x(n) + 2 * sqrt(1 - a * a) * en(n + 1);
end

num1 = 0;
num2 = 0;
num3 = 0;
num4 = 0;

for i = 1:100000

    if (x(i) < -2)
        num1 = num1 + 1;
    elseif (x(i) >= -2) && (x(i) <= 0)
        num2 = num2 + 1;
    elseif (x(i) > 0) && (x(i) <= 2)
        num3 = num3 + 1;
    else
        num4 = num4 + 1;
    end

end

disp('Calculated:');
p1 = num1 / 100000;
p2 = num2 / 100000;
p3 = num3 / 100000;
p4 = num4 / 100000;
p = 0;
disp(p1);
disp(p2);
disp(p3);
disp(p4);

for i = 1:200000
    p = p + 1 / (sqrt(2 * pi) * 2) * exp(- (i * 0.00001) * (i * 0.00001) / (2 * 2 * 2)) * 0.00001;
end

disp('Therom: ');
p1 = 0.5 - p;
p2 = p;
p3 = p;
p4 = p1;
disp(p1);
disp(p2);
disp(p3);
disp(p4);
