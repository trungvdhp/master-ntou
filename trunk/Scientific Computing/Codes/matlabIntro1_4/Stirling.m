% Script File: Stirling
% Prints a table showing error in Stirling's formula for n!

clc
disp('                 Stirling             Absolute     Relative')
disp('  n        n!    Approximation         Error        Error')
disp('------------------------------------------------------------')
e = exp(1);
nfact = 1;
for n = 1:20
   nfact = n*nfact;
   s = sqrt(2*pi*n)*((n/e)^n);
   abserror = abs(nfact - s);
   relerror = abserror/nfact;
   s1 = sprintf('  %2.0d  %20.0f  %22.2f ' ,n, nfact, s);
   s2 = sprintf('  %20.2f   %5.2e', abserror, relerror);
   disp([s1 s2])
end