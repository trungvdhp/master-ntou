  function G = CholSax(A)
% G = CholSax(A)
% Cholesky factorization of a symmetric and positive definite matrix A.
% G is lower triangular so A = G*G'.

[n,n] = size(A);
G = zeros(n,n);
s = zeros(n,1);
for j=1:n
   s(j:n) = A(j:n,j);
   for k=1:j-1
      s(j:n) = s(j:n) - G(j:n,k)*G(j,k);
   end
   G(j:n,j) = s(j:n)/sqrt(s(j));
end