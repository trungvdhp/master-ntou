% Script P5_2_7
%
% Matrix powers via repeated squaring

clc
k = input('Compute A^k where k = ');
A = randn(5,5);
A = A/norm(A,1);
B = MatPower(A,k);
Error = B - A^k