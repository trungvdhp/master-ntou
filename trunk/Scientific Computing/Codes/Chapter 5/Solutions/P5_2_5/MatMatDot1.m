function C = MatMatDot1(A,B)
% A and B are n-by-n lower triangular matrices.
% C = A*B (Dot Product Version)

[n,n] = size(A);
C = zeros(n,n);
for j=1:n
   % Compute j-th column of C.
   for i=1:n
      s = 1:min([i j]);
      C(i,j) = A(i,s)*B(s,j);
   end
end