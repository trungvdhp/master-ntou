% Script File: ShowTriD
% Tridiagonal Solver test

clc
disp('Set L and U as follows:')
L = [1 0 0 0 0; 2 1 0 0 0 ; 0 3 1 0 0; 0 0 4 1 0; 0 0 0 5 1]
U = [2 3 0 0 0; 0 1 -1 0 0; 0 0 2 1 0; 0 0 0 3 1; 0 0 0 0 6]
%
input('Strike Any Key To Continue');
clc
disp('Form A = LU and set b so solution to Ax=b is ones(5,1).')
pause(2)
A = L*U
b = A*ones(5,1)
input('Strike Any Key To Continue');
%
clc
disp('Extract diagonal part of A:')
A = A
d = diag(A)'
input('Strike Any Key To Continue');
clc
disp('Extract subdiagonal part of A:')
A = A
e(2:5) = diag(A,-1)
input('Strike Any Key To Continue');
clc
disp('Extract superdiagonal part of A:')
A = A
f(1:4) = diag(A,1)
input('Strike Any Key To Continue');
%
clc
disp('Solve Ax = b via TriDiLU, LBiDisol, and UBiDiSol')
[l,u] = TriDiLU(d,e,f);
y = LBiDiSol(l,b);
x = UBiDiSol(u,f,y)