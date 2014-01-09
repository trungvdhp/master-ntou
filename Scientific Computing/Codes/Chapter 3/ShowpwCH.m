% Script File: ShowpwCH
% Convergence of the piecewise cubic hermite  interpolant to
% exp(-2x)sin(10*pi*x) on [0,1].)

close all
z = linspace(0,1,200)';
fvals = exp(-2*z).*sin(10*pi*z);
for n = [4 8 16 24]
   x = linspace(0,1,n)';
   y = exp(-2*x).*sin(10*pi*x);
   s = 10*pi*exp(-2*x).*cos(10*pi*x)-2*y;
   [a,b,c,d] = pwC(x,y,s);
   Cvals = pwCEval(a,b,c,d,x,z);
   figure
   plot(z,fvals,z,Cvals,'--',x,y,'*');
   title(sprintf('Interpolation of exp(-2x)sin(10pi*x) with pwCH, n = %2.0f',n))
end
legend('e^{-2z}sin(10\pi z)','The pwC interpolant')