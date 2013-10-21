% Script File: CosinePlot
% Displays increasingly smooth plots of cos(x) on [0, 2*pi].
function y = CosinePlot(n, t)
close all
a = 4:4:n;
for k = a
   x = 2*pi*linspace(0,1,k+1);
   y = CosineValue(k);
   plot(x, y)
   title(sprintf('Plot of cos(x) based upon k = %3.0f points.',k))
   xlabel('values of x')
   ylabel('values of y')
   pause(t)
end