% Problem P3_3_4
%
% Illustrate spline-under-tension idea. As sigma increases,
% the approximant looks more and more like a piecewise linear
% function.

close all
n = 10;

x = linspace(0,1,n)';
y = exp(-2*x).*sin(10*pi*x);
s = -2*exp(-2*x).*sin(10*pi*x) + 10*pi*exp(-2*x).*cos(10*pi*x);
z = linspace(0,1)';
fz = exp(-2*z).*sin(10*pi*z);
plot(z,fz,x,y,'o')
sigma = 100;
[a,b,c,d] = Fit(x,y,s,sigma);  
hold on
for i=1:n-1
   xvals = linspace(x(i),x(i+1),100)';
   u = exp(sigma*(xvals-x(i)));
   yvals = a(i) + b(i)*(xvals-x(i)) + c(i)*u + d(i)./u;
   plot(xvals,yvals,'.')	 
end
hold off
title('n=10, f(x) = exp(-2x)sin(10*pi*x), sigma = 100')
for sigma = [ 10 100 250];
   [a,b,c,d] = Fit(x,y,s,sigma);
   figure
   hold on
   for i=1:n-1
      xvals = linspace(x(i),x(i+1),100)';
      u = exp(sigma*(xvals-x(i)));
      yvals = a(i) + b(i)*(xvals-x(i)) + c(i)*u + d(i)./u;
      plot(xvals,yvals,x,y,x,y,'o')	 
   end
   title(sprintf('PWL fit and the tension spline fit with sigma = %6.1f',sigma))
   hold off
end