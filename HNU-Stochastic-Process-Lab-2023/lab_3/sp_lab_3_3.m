% sp_lab_3_3

i = 1:1000;
omega = i * 0.001 * pi;
S = (abs(1 - 0.36 .* exp(-1j * omega) + 0.85 .* exp(-2j * omega))) .^ 2;
stem(S, '.');
title('S_\omega(i \times 0.001 \pi)');
