% Problem P3_3_1
%
% Not-a-knot spline interpolation of f(x) = x^3.

x = sort(rand(4,1));
y = x.^3;
[a,b,c,d] = CubicSpline(x,y);
z = linspace(x(1),x(4));
Cvals = pwCEval(a,b,c,d,x,z);
z0 = linspace(x(1),x(4),20);
plot(z,Cvals,z0,z0.^3,'o')
title('Not-a-knot spline interpolant of x^3')