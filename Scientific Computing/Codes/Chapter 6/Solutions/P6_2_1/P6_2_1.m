% Problem P6_2_1
%
% Solving lower Hessenberg systems

n = 6;
A = triu(randn(n,n),-1)
b = A'*ones(n,1)
x = HessTrans(A,b)