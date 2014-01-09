% Problem P6_1_4
%
% Solving the lower triangular Sylvester equation SX-XT=B.

clc 
m = 6;
n = 4;
S = tril(randn(m,m))
T = tril(randn(n,n))
B = randn(m,n)
X = Sylvester1(S,T,B)
disp(sprintf('norm(SX-XT-B)/norm(X) = %8.3e',norm(S*X-X*T-B)/norm(X)))