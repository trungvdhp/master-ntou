% Problem P6_1_1
%
% Solving certain singular lower triangular systems.

clc 
n = 6;
L = tril(randn(n,n));
L(1,1) = 0
x = LTriSol1(L)
disp('L*x =')
disp(L*x)