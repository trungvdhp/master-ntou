function [numIs, L] = MySplineQ (x, y)
% x, y  n-vectors with x(1) < ... < x(n)
% numIs is the integral from x(1) to x(n) of the not-a-knot spline
%         interpolant of (x(i), y(i)), i = 1 : n
% L is number of integral intervals + 1.
S = spline (x, y);
[x, rho, L, k] = unmkpp(S);
numIs(1) = 0;
for i = 1 : L
   % Add in the integral from x(i) to x(i+1)
   h = x(i+1) - x(i);
   subI = h * (((rho(i,1)*h/4 + rho(i,2)/3)*h + rho(i,3)/2)*h + rho(i,4));
   numIs(i+1) = numIs(i) + subI;
end
L = L + 1;