% Problem P6_1_3.
%
% Solving the upper triangular Sylvester equation SX-XT=B.

clc 
m = 6;
n = 4;
S = triu(randn(m,m))
T = triu(randn(n,n))
B = randn(m,n)
X = Sylvester(S,T,B)
disp(sprintf('norm(SX-XT-B)/norm(X) = %8.3e',norm(S*X-X*T-B)/norm(X)))