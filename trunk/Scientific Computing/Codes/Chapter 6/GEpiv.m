function [L,U,piv] = GEpiv(A)
% [L,U,piv] = GE(A)
%
% The LU factorization with partial pivoting. If A is n-by-n, then
% piv is a permutation of the vector 1:n and L is unit lower triangular 
% and U is upper triangular so A(piv,:) = LU. |L(i,j)|<=1 for all i and j.

[n,n] = size(A); 
piv = 1:n;
for k=1:n-1
   [maxv,r] = max(abs(A(k:n,k)));
   q = r+k-1;
   piv([k q]) = piv([q k]);
   A([k q],:) = A([q k],:);
   if A(k,k) ~= 0
      A(k+1:n,k) = A(k+1:n,k)/A(k,k);
      A(k+1:n,k+1:n) = A(k+1:n,k+1:n) - A(k+1:n,k)*A(k,k+1:n);
   end
end
L = eye(n,n) + tril(A,-1);
U = triu(A);