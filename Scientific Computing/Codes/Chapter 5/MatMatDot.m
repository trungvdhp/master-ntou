function C = MatMatDot(A,B)
% C = MatMatDot(A,B)
% This computes the matrix-matrix product C =A*B (via dot products) where
% A is an m-by-p matrix, B is a p-by-n matrix.

[m,p] = size(A);
[p,n] = size(B);
C = zeros(m,n);
for j=1:n
   % Compute j-th column of C.
   for i=1:m
      C(i,j) = A(i,:)*B(:,j);
   end
end