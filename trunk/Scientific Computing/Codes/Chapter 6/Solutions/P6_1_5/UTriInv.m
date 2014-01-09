function X = UTriInv(U)
% X = UTriInv(U)
%
% U is an n-by-n nonsingular upper triangular matrix.
%
% X is the inverse of U.

[n,n] = size(U);
X = zeros(n,n);
for k=1:n
   v = zeros(k,1);
   v(k) = 1;
   X(1:k,k) = UTriSol(U(1:k,1:k),v);
end