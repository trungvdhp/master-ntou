% Script File: ShowPWL1
% Convergence of the piecewise linear interpolant to
% humps(x) on [0,3]

close all
z = linspace(0,3,200)';
fvals = humps(z);
for n = [5 10 25 50]
   figure
   x = linspace(0,3,n)';
   y = humps(x);
   [a,b] = pwL(x,y);
   Lvals = pwLEval(a,b,x,z);
   plot(z,Lvals,z,fvals,'--',x,y,'o');
   title(sprintf('Interpolation of humps(x) with pwL, n = %2.0f',n))
end