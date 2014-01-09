% Script P5_2_6
%
% Illustrate A*(Banded B)

p = 2;
A = rand(6,6)
B = triu(tril(rand(6,6),p),-p)
C = BandMatMatSax(A,B,p)
Error = C - A*B