% Problem P6_2_3
%
% Solve HX-XT=B where H is upper Hessenberg and T is upper triangular.

clc  
m = 6;
n = 4;
H = triu(randn(m,m),-1)
T = triu(randn(n,n))
B = randn(m,n)
X = SylvesterH(H,T,B)
disp(sprintf('norm(H*X-X*T-B)/norm(X) = %8.3e ',norm(H*X-X*T-B)/norm(X)))