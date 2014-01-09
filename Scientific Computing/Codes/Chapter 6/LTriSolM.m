  function X = LTriSolM(L,B)
% X = LTriSolM(L,B)
%
% Solves the non-singular lower triangular system  LX = B
% where L is n-by-n, B is n-by-r, and X is n-by-r.

[n,r] = size(B);
X = zeros(n,r);
for j=1:n-1
   X(j,1:r)     = B(j,1:r)/L(j,j);
   B(j+1:n,1:r) = B(j+1:n,1:r) - L(j+1:n,j)*X(j,1:r);   
end
X(n,1:r) = B(n,1:r)/L(n,n);
