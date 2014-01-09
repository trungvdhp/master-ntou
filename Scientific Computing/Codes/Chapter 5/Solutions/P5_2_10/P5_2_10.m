% Script P5_2_10
%
% Illustrate row scaling

clc
A = magic(5); A = A(:,1:3)
d = 1:5
B = ScaleRows(A,d)