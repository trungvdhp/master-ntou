  function [Q,R] = QRRot(A)
% [Q,R] = QRRot(A) 
% The QR factorization of an m-by-n matrix A. (m>=n).
% Q is m-by-m orthogonal and R is m-by-n upper triangular.

[m,n] = size(A);
Q = eye(m,m);
for j=1:n
   for i=m:-1:j+1
      %Zero A(i,j)
      [c,s] = Rotate(A(i-1,j),A(i,j));
      A(i-1:i,j:n) = [c s; -s c]*A(i-1:i,j:n);
      Q(:,i-1:i) = Q(:,i-1:i)*[c s; -s c]';
   end
end
R = triu(A);