  function G = CholGax(A)
% G = CholGax(A)
% Cholesky factorization of a symmetric and positive definite matrix A.
% G is lower triangular so A = G*G'.

[n,n] = size(A);
G = zeros(n,n);
s = zeros(n,1);
for j=1:n
   if j==1
      s(j:n) = A(j:n,j);
   else
      s(j:n) = A(j:n,j) - G(j:n,1:j-1)*G(j,1:j-1)';
   end
   G(j:n,j)  = s(j:n)/sqrt(s(j));
end