% Problem P5_4_3
%
% Test generalized strassen multiply.

clc
n = input('Enter n:');
nmin = input('Enter nmin:');
A = randn(n,n);
B = randn(n,n);
C = MyStrass(A,B,nmin);
err = norm(C-A*B)