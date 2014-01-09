function C = MatMatSax1(A,B)
% A is an m-by-p matrix.
% B is a p-by-n matrix (upper triangular).
% C     A*B (Saxpy Version)

[m,p] = size(A);
[p,n] = size(B);
C = zeros(m,n);
for j=1:n
   % Compute j-th column of C.
   for k=1:min([j p])
      C(:,j) = C(:,j) + A(:,k)*B(k,j);
   end
end