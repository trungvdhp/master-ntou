% Script P5_2_9
%
% Illustrate Krylov matrix set-up

clc
A = magic(4);
B = A(:,3:4);
p = 3
C = Krylov(A,B,p)