function [omega,x] = wCompNC(a,b,m,n)
% [omega,x] = wCompNC(a,b,m,n)
% 
% m is an integer with 2<=m<=11 and n is a positive integer.
%
% omega is a column vector of weights for the composite m-point 
% Newton-Cotes rule with n equal-length subintervals across [a,b]
% x is column vector of abscissas.

N = n*(m-1)+1;
x = linspace(a,b,N)'; 
w = NCWeights(m);    
omega = zeros(N,1);
for k=1:(m-1):N-m+1
   omega(k:k+m-1) = omega(k:k+m-1) + w;
end
omega = omega/n;