function z = Ainv(A,i,j)
% z = Ainv(A,i,j)
%
% A is an n-by-n nonsingular matrix.
% i,j  integers with 1<=i<=n and 1<=j<=n.
%
% z is the (i,j) entry of A^-1.

[n,n] = size(A);
[L,U,piv] = GEpiv(A);
b = zeros(n,1);
b(j) = 1;
y = LTriSol(L,b(piv));
% Just need the i-th component of the solution to Ux = y.
xtilde = UTriSol(U(i:n,i:n),y(i:n));
z = xtilde(1);