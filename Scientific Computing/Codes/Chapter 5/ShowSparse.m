% Script File: ShowSparse
% Looks at the effect of the sparse operation on tridiagonal matrix products.

close all
nvals = 100:100:1000;
repeatVal = [200 200  100  50  20  10  10  10  10 5];
for k=1:length(nvals)
   n = nvals(k); x = randn(n,1);
   A = diag(2*(1:n)) - diag(1:n-1,-1) + diag(1:n-1,1);
   S = sparse(A);
   flops(0), y = A*x;  fullA_flops(k)   = flops;
   flops(0), y = S*x;  sparseA_flops(k) = flops;
end
semilogy(nvals,fullA_flops,nvals,sparseA_flops)
xlabel('n')
title('(Tridiagonal A) \times (Vector)')
legend('Flops with Full A','Flops with Sparse A',2)



