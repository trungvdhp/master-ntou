% Problem P3_3_3
%
% Natural spline interpolant of x^3.

close all
x = [-3;-1;1;3];
y = x.^3;
[a,b,c,d] = CubicSpline(x,y,2,0,0);
S0 = pwCEval(a,b,c,d,x,0);
z = linspace(-3,3);
Cvals = pwCEval(a,b,c,d,x,z);
plot(z,Cvals,x,y,'o')
title(sprintf('S(0) = %8.4e',S0))