%% upDown1.m  Sec.1.3  p.32
%% Create the up/down sequence
%% find its max and growth factor.

clear
upDown;
[xmax, imax] = max(x);
disp(sprintf(' \n x(%1.0f) = %1.0f is the maximum', imax, xmax));
density = sum(x <= x(1)) / x(1);
disp(sprintf(' The density is %5.3f', density));
GrowthFactor = max(x) / x(1);
disp(sprintf(' The growth factor is %5.3f', GrowthFactor));