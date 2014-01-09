% Script File: ShowCholBlock
% Effect of block size on performance of block Cholesky.

n = 192;
A = randn(n,n);
A = A'*A;
G0 = chol(A)';
clc
disp(sprintf('n =  %2.0f',n))
disp(' ')
disp(' Block Size   Time / Unblocked Time    ')
disp('---------------------------------------')
k =0;
for p=[ 8 12 16 24 32 48 96]
   tic;
   G = CholBlock(A,p);
   k=k+1;
   t(k) = toc;
   disp(sprintf('     %2.0f       %6.3f  ',p,t(k)/t(1)))
end