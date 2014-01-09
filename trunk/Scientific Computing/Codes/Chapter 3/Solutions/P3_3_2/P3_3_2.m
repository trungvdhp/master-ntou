% Problem P3_3_2
%
% 4-point not-a-knot spline interpolant

close all
x = sort(rand(4,1));
y = rand(4,1);
[a,b,c,d] = CubicSpline(x,y);
z = linspace(x(1),x(4))';
Cvals = pwCEval(a,b,c,d,x,z);
a = InterpV(x,y);
z0 = linspace(x(1),x(4),20)';
pvals = HornerV(a,z0);
plot(z,Cvals,x,y,'*',z0,pvals,'o')
title('n=4 not-a-knot is just cubic interpolation.')
