function x = LTriSol1(L)
% x = LTriSol1(L)
%
% L is an n-by-n  lower triangular matrix. L(2:n,2:n) is
% nonsingular and L(1,1) = 0.
%
% x satisfies Lx = 0 with x(1) = -1. 

[n,n] = size(L);
x = zeros(n,1);
x(1) = -1;
x(2:n) = LTriSol(L(2:n,2:n),L(2:n,1));