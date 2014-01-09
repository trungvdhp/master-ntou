% Script File: ShowLSFit
% Displays two LS fits to the function f(x) = sqrt(x) on [.25,1].

close all
z = linspace(.25,1);
fz = sqrt(z);
for m = [2 100 ]
   x = linspace(.25,1,m)';
   A = [ones(m,1) x];
   b = sqrt(x);
   xLS = A\b;
   alpha = xLS(1);
   beta  = xLS(2);
   figure
   plot(z,fz,z,alpha+beta*z,'--')
   title(sprintf('m = %2.0f,  alpha = %10.6f,  beta = %10.6f',m,alpha,beta))
end