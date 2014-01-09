% Problem P6_1_2
%
% Solving multiple righthand side upper triangular systems

clc
n = 6;
r = 4;
U = triu(randn(n,n))
B = randn(n,r)
X = UTriSolM(U,B)
disp('U*X - B')
disp(U*X-B)