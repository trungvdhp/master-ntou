% Script P5_3_2
%
% Solving integral equations.

close all
a = 0;
b = 5;
clc 
disp('m   n     Set-up Time ')
disp('-----------------------')
for sigma = [.01 .1]
   j = 1;
   figure
   for m = [3 5]
      for n = [5 10]
         tic;
         Kmat = Kernel(a,b,m,n,sigma);
         tfinish = toc;
         T = etime(tfinish,tstart);
         disp(sprintf('%2.0f  %2.0f    %5.3f',m,n,T))
         x = linspace(a,b,n*(m-1)+1)';
         rhs = 1./((x-2).^2 + .1) + 1./((x-4).^2 + .2);  
         fvals = Kmat\rhs;
         z = linspace(a,b,200)';
         sz = spline(x,fvals,z);
         subplot(2,2,j)
         plot(z,sz)
         title(sprintf('m=%2.0f, n=%2.0f   sigma = %5.2f',m,n,sigma))
         j= j+1;
      end
   end
end