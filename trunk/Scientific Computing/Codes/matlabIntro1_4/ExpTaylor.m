% Script File: ExpTaylor
% Plots, as a function of n, the relative error in the
% Taylor approximation 1 + x + x^2/2! +...+ x^n/n! to exp(x) .
clc
close all
nTerms = 50; err = zeros(50,1); 
for x= [10 5 1 -1 -5 -10]
   figure
   term = 1;  s = 1; 
   f = exp(x)*ones(nTerms,1);
   for k=1:50,
       term = x.*term/k; 
       s = s + term; 
       err(k) = abs(f(k) - s); 
   end
   err
   relerr = err/exp(x)
   semilogy(1:nTerms, relerr)
   ylabel('Relative Error in Partial Sum.')
   xlabel('Order of Partial Sum.')
   title(sprintf('x = %5.2f', x))
   pause(1)
end