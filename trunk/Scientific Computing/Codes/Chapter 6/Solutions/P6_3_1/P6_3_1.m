% Problem P6_3_1
%
% Multiple righthand side solver.

clc
n = 6;
r = 4;
A = randn(n,n)
B = randn(n,r)
X = MultRhs(A,B)
disp(sprintf('norm(AX-B)/(norm(A)*norm(X)) = %8.3e',norm(A*X-B)/(norm(A)*norm(X))))