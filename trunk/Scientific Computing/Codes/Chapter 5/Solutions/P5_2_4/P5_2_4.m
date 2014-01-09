% Script P5_2_4
%
% Saxpy matrix multiply with both factors triangular.

clc
A = triu(rand(5,5))
B = triu(rand(5,5))
C = MatMatSax2(A,B)
Cexact = A*B