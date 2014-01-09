  function G = CholRecur(A)
% G = CholRecur(A)
% Cholesky factorization of a symmetric and positive definite matrix A.
% G is lower triangular so A = G*G'.

[n,n] = size(A);
G = zeros(n,n);
if n==1
   G = sqrt(A);
else
   G(1:n-1,1:n-1) = CholRecur(A(1:n-1,1:n-1));
   G(n,1:n-1)     = LTriSol(G(1:n-1,1:n-1),A(1:n-1,n))';
   G(n,n)         = sqrt(A(n,n) - G(n,1:n-1)*G(n,1:n-1)');
end