% Script P5_2_1
%
% Checks the Hessenberg matrix-vector product.

clc
n = 10;
A = triu(randn(n,n),-1);
z = randn(n,1);
y = HessMatVec(A,z);
err = y - A*z