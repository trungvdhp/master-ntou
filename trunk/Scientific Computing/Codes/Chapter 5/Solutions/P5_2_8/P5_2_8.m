% Script P5_2_8
%
% y = (polynomial in matrix A)*(vector)

clc
v = randn(8,1);
A = randn(8,8);
c = randn(4,1);
y = HornerM(c,A,v);
Error = y - (c(1)*v + c(2)*A*v + c(3)*A*A*v + c(4)*A*A*A*v)