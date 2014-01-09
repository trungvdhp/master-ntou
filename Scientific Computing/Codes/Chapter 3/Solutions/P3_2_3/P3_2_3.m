% Problem P3_2_3
%
% Variable subinterval piecewise cubic hermite interpolation.

close all
[x,y] = pwCHExp(0,5,.0001);
[a,b,c,d] = pwC(x,y,-y);  
z = linspace(0,5)';
Cvals = pwCEval(a,b,c,d,x,z);
plot(z,exp(-z),z,Cvals,x,y,'o')
title('Piecewise cubic hermite interpolant of exp(-x)')