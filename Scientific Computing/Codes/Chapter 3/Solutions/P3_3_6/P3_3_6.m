% Problem P3_3_6
%
% Integral of the splines second derivative.

clc
disp('  n    Natural         Not-a-Knot    Bad Complete')
disp('--------------------------------------------------')

for n = [10 20 40 80 160 320 ]
   x = linspace(0,1,n)';
   y = 1./(1+25*x.^2);
   [a,b,c,d] = CubicSpline(x,y,2,0,0);
   e1 = Energy(ConvertS(a,b,c,d,x));
   [a,b,c,d] = CubicSpline(x,y);
   e2 = Energy(ConvertS(a,b,c,d,x));
   [a,b,c,d] = CubicSpline(x,y,1,30,-15);
   e3 = Energy(ConvertS(a,b,c,d,x));
   disp(sprintf(' %3.0f  %8.5e    % 8.5e     %8.5e',n,e1,e2,e3))
end