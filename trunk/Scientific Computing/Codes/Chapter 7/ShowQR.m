% Script File: ShowQR
% Illustrates how the QR factorization is found via Givens Rotations.

m = 5;
n = 3;
disp(' ')
disp('Show upper triangularization of ')
A = rand(m,n);
for j=1:n
   for i=m:-1:j+1
      input('Strike Any Key to Continue');
      clc
      %Zero A(i,j)
      Before = A
      [c,s] = Rotate(A(i-1,j),A(i,j));
      A(i-1:i,j:n) = [c s; -s c]  *A(i-1:i,j:n);
      disp(sprintf('Zero A(%g,%g)',i,j))
      After = A
   end
end
disp('Upper Triangularization Complete.')