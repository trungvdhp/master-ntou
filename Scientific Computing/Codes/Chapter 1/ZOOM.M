% Script File: Zoom
% Plots (x-1)^6 near x=1 with increasingly refined scale.
% Evaluation via x^6 - 6x^5 + 15x^4 - 20x^3 + 15x^2 - 6x +1
% leads to severe cancellation.

close all
k=0;
n=100;
for delta = [.1 .01 .008 .007 .005  .003 ]
   x = linspace(1-delta,1+delta,n)';
   y = x.^6 - 6*x.^5 + 15*x.^4 - 20*x.^3 + 15*x.^2  - 6*x + ones(n,1);
   k = k+1;
   subplot(2,3,k)
   plot(x,y,x,zeros(1,n))
   axis([1-delta 1+delta -max(abs(y)) max(abs(y))])
end
