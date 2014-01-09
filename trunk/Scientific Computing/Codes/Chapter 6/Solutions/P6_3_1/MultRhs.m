function X = MultRhs(A,B)
% X = MultRhs(A,B)
%
% A is an n-by-n nonsingular matrix.
% B is an n-by-r matrix.
%
% X is an n-by-r matrix that satisfies AX = B.
[n,r] = size(B);
X = zeros(n,r);
[L,U,piv] = GEpiv(A);
for k=1:r
   y = LTriSol(L,B(piv,k));
   X(:,k) = UTriSol(U,y);
end