% Script File: ShowTri
% Inverse of the 5-by-5 Forsythe Matrix.

n = 5;
L = eye(n,n) - tril(ones(n,n),-1)
X = LTriSolM(L,eye(n,n))