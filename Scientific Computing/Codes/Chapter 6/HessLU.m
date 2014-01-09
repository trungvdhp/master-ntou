function [v,U] = HessLU(A)
% [v,U] = HessLU(A)
%
% Computes the factorization H = LU where H is an n-by-n upper Hessenberg 
% and L is an n-by-n lower unit triangular and U is an n-by-n upper triangular
% matrix.
%
% v is a column n-by-1 vector with the property that L = I + diag(v(2:n),-1).

[n,n] = size(A);
v = zeros(n,1);
for k=1:n-1
   v(k+1) = A(k+1,k)/A(k,k);
   A(k+1,k:n) = A(k+1,k:n) - v(k+1)*A(k,k:n);
end
U = triu(A);