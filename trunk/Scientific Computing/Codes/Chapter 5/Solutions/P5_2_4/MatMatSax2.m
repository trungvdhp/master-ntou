function C = MatMatSax2(A,B)
% A is an n-by-n matrix.
% B is a p-by-n matrix (upper triangular)
% C     A*B (Saxpy Version)
%
[n,n] = size(A);
C = zeros(n,n);
for j=1:n
   % Compute j-th column of C.
   for k=1:j
      C(1:j,j) = C(1:j,j) + A(1:j,k)*B(k,j);
	end
end
