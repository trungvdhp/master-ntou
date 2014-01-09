function C = BandMatMatSax(A,B,p)
% A is an n-by-n matrix.
% B is an n-by-n matrix, bandwidth p
% C = A*B (Saxpy Version)
S
[n,n] = size(A);
C = zeros(n,n);
for j=1:n
   % Compute j-th column of C.
   for k=max([1 j-p]):min([j+p n])
      C(:,j) = C(:,j) + A(:,k)*B(k,j);
   end
end