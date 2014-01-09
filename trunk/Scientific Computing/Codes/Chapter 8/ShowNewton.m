% Script File: ShowNewton
% A pure Newton method test environment.

close all
fName  = input('Enter the name of the function (with quotes);');
fpName = input('Enter the name of the derivative function (with quotes);');

a = input('Enter left endpoint of interval of interest:');
b = input('Enter right endpoint of interval of interest:');
xvals = linspace(a,b,100);
fvals = feval(fName,xvals);
figure
plot(xvals,fvals,xvals,0*xvals)
v = axis;
title('Click in Starting Value')
[xc,y] = ginput(1);
fc    = feval(fName,xc);
fpc   = feval(fpName,xc);
Lvals = fc + fpc*(xvals-xc);
hold on
plot(xvals,Lvals,xc,fc,'*')
axis(v)
xlabel(sprintf(' xc = %10.6f      fc = %10.3e',xc,fc))
hold off
for k=1:3
   step = -fc/fpc;
   xc = xc+step;
   a = xc-abs(step);
   b = xc+abs(step);
   xvals = linspace(a,b,100);
   fvals = feval(fName,xvals);
   fc    = feval(fName,xc);
   fpc   = feval(fpName,xc);
   Lvals = fc + fpc*(xvals-xc);
   figure
   plot(xvals,fvals,xvals,Lvals,xvals,0*xvals,xc,fc,'*')
   xlabel(sprintf(' xc = %10.6f      fc = %10.3e',xc,fc))
end 