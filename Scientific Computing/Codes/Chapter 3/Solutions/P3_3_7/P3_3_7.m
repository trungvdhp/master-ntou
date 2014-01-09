% Problem P3_3_7
%
% Max 3rd derivative continuity.

clc
n = input('Enter the number of points to interpolate: ');
x = linspace(0,pi,n)';
y = exp(-x).*sin(x);

S = spline(x,y);
d3 = MaxJump(S)