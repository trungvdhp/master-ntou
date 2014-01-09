  function [g,h] = CholTrid(d,e)
% G = CholTrid(d,e)
% Cholesky factorization of a symmetric, tridiagonal positive definite matrix A.
% d and e are column n-vectors with the property that 
% A = diag(d) + diag(e(2:n),-1) + diag(e(2:n),1) 
%           
% g and h are column n-vectors with the property that the lower bidiagonal
% G = diag(g) + diag(h(2:n),-1) satisfies A = GG^T.

n = length(d);
g = zeros(n,1);
h = zeros(n,1);
g(1) = sqrt(d(1));
for i=2:n
   h(i) = e(i)/g(i-1);
   g(i) = sqrt(d(i) - h(i)^2);
end