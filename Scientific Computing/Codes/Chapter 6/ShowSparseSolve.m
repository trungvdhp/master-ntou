% Script File: ShowSparseSolve
% Illustrates how the \ operator can exploit sparsity

clc
disp('        n     Flops Full    Flops Sparse ')
disp('------------------------------------------')
for n=[25 50 100 200 400 800]
   T = randn(n,n)+1000*eye(n,n);    
   T = triu(tril(T,1),-1); T(:,1) = .1; T(1,:) = .1;
   b = randn(n,1);
   flops(0); x = T\b; fullFlops   = flops;
   T_sparse = sparse(T);
   flops(0); x = T_sparse\b; sparseFlops = flops;
   disp(sprintf('%10d  %10d  %10d ',n,fullFlops,sparseFlops))
end