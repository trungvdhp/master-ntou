function C = MatMatVec(A,B)
% C = MatMatVec(A,B)
% This computes the matrix-matrix product C = A*B (via matrix-vector products) 
% where A is an m-by-p matrix, B is a p-by-n matrix. 

[m,p] = size(A);
[p,n] = size(B);
C = zeros(m,n);
for j=1:n
   % Compute j-th column of C.
   C(:,j) = C(:,j) + A*B(:,j);
end