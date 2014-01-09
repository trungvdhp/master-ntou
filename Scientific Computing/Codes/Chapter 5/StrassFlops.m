% Script File: StrassFlops
% Compares Strassen method flops with ordinary A*B flops.

clc
nmin = 32;
nmax = 1024;
A0 = rand(nmax,nmax);
B0 = rand(nmax,nmax);
disp('  n   Strass Flops/Ordinary Flops')
disp('-------------------------------------')
n = 32;
while (n<=nmax)
   A = A0(1:n,1:n);
   B = B0(1:n,1:n);
   flops(0);
   C = Strass(A,B,nmin);
   f = flops;
   disp(sprintf('  %4d       %6.3f', n,f/(2*n^3)))
   n = 2*n;
end