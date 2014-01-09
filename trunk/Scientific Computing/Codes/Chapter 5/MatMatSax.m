function C = MatMatSax(A,B)
% C = MatMatSax(A,B)
% This computes the matrix-matrix product C = A*B (via saxpys) where
% A is an m-by-p matrix, B is a p-by-n matrix. 

[m,p] = size(A);
[p,n] = size(B);
C = zeros(m,n);
for j=1:n
   % Compute j-th column of C.
   for k=1:p
      C(:,j) = C(:,j) + A(:,k)*B(k,j);
   end
end