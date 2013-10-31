% Script File: SinePlot
% Displays increasingly smooth plots of sin(2*pi*x).
close all
for n = [4 8 12 16 20 60 100 200 400]
   x = 2*pi*linspace(0,1,n+1);
   % y = sin(2*pi*x);
   y = SineValue(n);   % Compute the values of sine by symmetry. 
   plot(x, y)
   title(sprintf('Plot of sin(2*pi*x) based upon n = %3.0f points.',n))
   xlabel('values of x')
   ylabel('values of y')
   pause(2)
end