% Script File: Stirling
% Prints a table showing error in Stirling's formula for n!

close all
clc
disp( '  ')
disp('                       Stirling          Absolute    Relative')
disp('   n          n!     Approximation         Error       Error')
disp('----------------------------------------------------------------')
e=exp(1);
nfact=1;
for n=1:13
   nfact = n*nfact;
   s = sqrt(2*pi*n)*((n/e)^n);
   abserror = abs(nfact - s);
   relerror = abserror/nfact;
   s1 = sprintf('  %2.0f   %10.0f   %13.2f',n,nfact,s);
   s2 = sprintf('   %13.2f    %5.2e',abserror,relerror);
   disp([s1 s2])
end