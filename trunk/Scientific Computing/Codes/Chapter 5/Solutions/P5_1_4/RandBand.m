function A = RandBand(m,n,p,q)
% m, n, p, and q are  positive integers
% random m-by-n matrix with lower bandwidth p and upper bandwidth q.

A = triu(tril(rand(m,n),q),-p);