function S = ConvertS(a,b,c,d,x)
% x is a column n-vector with x(1) < ... < x(n)
% a,b,c, and d are column n-1 vectors. 
% 
% S is the pp-representation of the piecewise cubic whose
% ith local cubic is defined by
%
%       a(i) + b(i)*(x-x(i)) + c(i)*(x-x(i))^2 + d(i)*(x-x(i))^2*(x-x(i+1))
%
% Note that the i-th local cubic is also prescribed by
% a(i) + b(i)*(x-x(i)) + (c(i)+d(i)(x(i)-x(i+1))*(x-x(i))^2 + d(i)*(x-x(i))^3

rho = [d c-d.*diff(x) b a];
S = mkpp(x,rho);