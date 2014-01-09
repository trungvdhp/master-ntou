% Problem P6_1_5
%
% The inverse of upper triangular matrix.

clc 
n = 6;
U = triu(randn(n,n))
X = UTriInv(U)
disp(sprintf('norm(U*X - eye(n,n))/norm(X) = %8.3e',norm(U*X - eye(n,n))/norm(X) ));