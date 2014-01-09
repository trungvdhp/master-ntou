function [L,U] = GE(A)
% [L,U] = GE(A)
%
% The LU factorization without pivoting. If A is n-by-n and has an
% LU factorization, then L is unit lower triangular and U is upper
% triangular so A = LU. 

[n,n] = size(A); 
for k=1:n-1
   A(k+1:n,k) = A(k+1:n,k)/A(k,k);
   A(k+1:n,k+1:n) = A(k+1:n,k+1:n) - A(k+1:n,k)*A(k,k+1:n);
end
L = eye(n,n) + tril(A,-1);
U = triu(A);