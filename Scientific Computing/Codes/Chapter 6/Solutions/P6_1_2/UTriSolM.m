function X = UTriSolM(U,B)
% X = UTriSolM(U,B)
%
% U is an n-by-n nonsingular upper triangular matrix
% B is am n-by-r matrix.
%
% X satisfies  UX = B.

[n,r] = size(B);
X = zeros(n,r);
for j=n:-1:2
   X(j,1:r)     = B(j,1:r)/U(j,j);
   B(1:j-1,1:r) = B(1:j-1,1:r) - U(1:j-1,j)*X(j,1:r);   
end
X(1,1:r) = B(1,1:r)/U(1,1);