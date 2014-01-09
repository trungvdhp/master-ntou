% Script File: ShowGE
% Illustrates computation of a 5-by-5 LU factorization
% without pivoting.

clc
format short
disp('Steps through the LU factorization of a 5-by-5 matrix')
input('Strike Any Key to Continue.');
clc
n = 5;
A = magic(5); 
ASave = A;
[n,n] = size(A); 
v = zeros(n,1);
L = eye(n,n);
for k=1:n-1
   v(k+1:n) = A(k+1:n,k)/A(k,k);
   for i=k+1:n
      clc
      Before = A     
      disp(sprintf('Multiply row %1.0f by %7.4f / %7.4f ',k,A(i,k),A(k,k)))
      disp(sprintf('and subtract from row %1.0f:',i))
      A(i,k:n) = A(i,k:n) - v(i)*A(k,k:n);
      After = A
      input('Strike Any Key to Continue.');
   end
   clc
   disp(sprintf('Have computed column %1.0f of L.',k))
   disp(' ')
   disp('Here is L so far:')
   L(k+1:n,k) = v(k+1:n)
   input('Strike Any Key to Continue.');
end
clc
disp('Factorization is complete:')
L = L
U = triu(A)
pause
clc
disp('Error check. Look at A - L*U:')
Error = ASave - L*U