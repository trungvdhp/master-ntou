function f = StrassCount(n,nmin)
% n and nmin are powers of 2 and nmin<=n
% f is the number of flops required to compute an n-by-n matrix multiply 
% using Strassen if n>nmin and conventional multiplication otherwise.

if n==nmin
   % flops for conventional n-by-n multiply.
   f = 2*n^3;
else
   m = n/2;
   f = 18*m^2 + 7*StrassCount(m,nmin);
end