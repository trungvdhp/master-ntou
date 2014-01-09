% Script File: ShowHessLU
% Illustrates computation of a 5-by-5 LU factorization
% of upper Hessenberg system without pivoting.

clc
disp('Steps through the LU factorization of a 5-by-5')
disp('upper Hessenberg matrix.')
input('Strike Any Key to Continue');
clc
n = 5;
A = rand(n,n);
A = triu(A,-1);
[n,n] = size(A);
v = zeros(n,1);
for k=1:n-1
   clc
   Before = A
   v(k+1) = A(k+1,k)/A(k,k);
   disp(sprintf('Zero A(%1.0f,%1.0f)',k+1,k))
   disp(sprintf('Multiplier = %7.4f / %7.4f = %7.4f',A(k+1,k),A(k,k),v(k+1)))
   A(k+1,k:n) = A(k+1,k:n) - v(k+1)*A(k,k:n);
   After = A
   input('Strike Any Key to Continue')
end
U = A;