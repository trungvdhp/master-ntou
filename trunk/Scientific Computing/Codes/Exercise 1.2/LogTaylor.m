% Script File: LogTaylor
% Plots, as a function of n, the relative error in the Taylor approximation:
% log(1+x)= x-xˆ2/2+xˆ3/3-xˆ4/4+xˆ5/5-..., for n terms.
clc
close all
n = 50;
err = zeros(n,1); 

for x = [1 2 4]
   figure
   tn = x; 
   s = tn;
   f = log(x+1)*ones(n,1);
   err(1) = abs(f(1) - s); 
   for k=2:n,
       tn = -tn*x*(k-1)/k;
       s = s + tn; 
       err(k) = abs(f(k) - s); 
   end
   relerr = err/log(x+1);
   semilogy(1:n, relerr)
   ylabel('Relative Error in Partial Sum.')
   xlabel('Order of Partial Sum.')
   title(sprintf('x = %5.2f', x+1))
   pause(1)
end