% Script File: ShowGEpiv
% Illustrates computation of a 5-by-5 LU factorization
% with pivoting.

clc
format short
disp('Steps through Gaussian elimination of a 5-by-5')
disp('matrix showing pivoting.')
input('Strike Any Key to Continue.');
clc
n = 5;
A = magic(5);
[n,n] = size(A); 
L = eye(n,n);
piv = 1:n;
for k=1:n-1
   clc
   [maxv,r] = max(abs(A(k:n,k)));
   q = r+k-1;
   Before = A
   disp(sprintf('piv = [ %1.0f  %1.0f  %1.0f  %1.0f  %1.0f]',piv(1),piv(2),piv(3),piv(4),piv(5)))
   disp(' ')
   disp(sprintf('Interchange rows k = %1.0f and q = %1.0f',k,q))
   piv([k q]) = piv([q k]);
   A([k q],:) = A([q k],:);
   After = A
   disp(sprintf('piv = [ %1.0f  %1.0f  %1.0f  %1.0f  %1.0f]',piv(1),piv(2),piv(3),piv(4),piv(5)))
   disp(' ')
   disp(sprintf('Zero A(%1.0f:%1.0f,%1.0f):',k,k+1,k))
   input('Strike Any Key to Continue.');
   clc 
   if A(k,k) ~= 0
      L(k+1:n,k) = A(k+1:n,k)/A(k,k);
      A(k+1:n,k+1:n) = A(k+1:n,k+1:n) - L(k+1:n,k)*A(k,k+1:n);
      A(k+1:n,k) = zeros(n-k,1); 
   end
end
clc
home
L=L
U = A
piv = piv