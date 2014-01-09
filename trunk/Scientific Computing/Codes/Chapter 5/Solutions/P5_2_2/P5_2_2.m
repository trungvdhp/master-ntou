% Script P5_2_2
%
% Checks TriMatVec

clc
m = 5;
n = 3;

A = triu(randn(m,n));
x = randn(n,1);
y = TriMatVec(A,x);
err = y - A*x
A = triu(randn(n,m));
x = randn(m,1);
y = TriMatVec(A,x);
err = y - A*x