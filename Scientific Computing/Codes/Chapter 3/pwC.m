  function [a,b,c,d] = pwC(x,y,s)
% [a,b,c,d] = pwC(x,y,s)
% Piecewise cubic Hermite interpolation.
%
% x,y,s  column n-vectors with x(1) < ... < x(n)
%
% a,b,c,d  column (n-1)-vectors that define a continuous, piecewise 
% cubic polynomial q(z) with the property that for i = 1:n,
%
%             q(x(i)) = y(i) and q'(x(i)) = s(i).
%
% On the interval [x(i),x(i+1)], 
%
%      q(z) = a(i) + b(i)(z-x(i)) + c(i)(z-x(i))^2  + d(i)(z-x(i))^2(z-x(i+1)).

n  = length(x); 
a  = y(1:n-1);
b  = s(1:n-1);
Dx = diff(x);
Dy = diff(y);
yp = Dy ./ Dx;
c  = (yp - s(1:n-1)) ./ Dx;
d  = (s(2:n) + s(1:n-1) - 2*yp) ./ (Dx.* Dx);