function [l,u] = TriDiLU(d,e,f)
%
% Tridiagonal LU without pivoting. d,e,f are  n-vectors that define a tridiagonal matrix 
% A = diag(e(2:n),-1) + diag(d) + diag(f(1:n-1),1). Assume that A has an LU factorization.
% l and u are n-vectors with the property that if L = eye + diag(l(2:n),-1)
% and U = diag(u) + diag(f(1:n-1),1), then A = LU.

n = length(d); 
l = zeros(n,1); 
u = zeros(n,1);
u(1) = d(1);
for i=2:n
   l(i) = e(i)/u(i-1);
   u(i) = d(i) - l(i)*f(i-1);
end