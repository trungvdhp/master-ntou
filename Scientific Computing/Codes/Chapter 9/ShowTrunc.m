% Script File: ShowTrunc
% Illustrates local truncation error

close all
a=-5;
h=.1;
y0=1;
t = linspace(-h,4*h,100);
clf
y = exp(a*t);
plot(t,y)
text(.2,1.18,sprintf('y'' = %4.1fy, y(0)  = 1',a))
text(.2,1.1,'* = exact solution')
text(.2,1.02,'o = computed solution')
hold on
plot(0,y0,'*')
y1 = (1 + a*h)*y0;
y = (y1/exp(a*h))*exp(a*t);
plot(t,y)
plot(h,exp(a*h),'*')
plot(h,(y1/exp(a*h))*exp(a*h),'o')pause(1)
y2 = (1 + a*h)*y1;
y = (y2/exp(2*a*h))*exp(a*t);
plot(t,y)
plot(2*h,exp(a*2*h),'*')
plot(2*h,(y2/exp(2*a*h))*exp(a*2*h),'o')
y3 = (1 + a*h)*y2;
y = (y3/exp(3*a*h))*exp(a*t);
plot(t,y)
plot(3*h,exp(a*3*h),'*')
plot(3*h,(y3/exp(3*a*h))*exp(a*3*h),'o')
hold off
%
title('Euler Solution (h=0.1) of y''=-5y, y(0) = 1')