% Script File: ExpPlot
% Examines the function f(x) = ((1 + x/24)/(1 - x/12 + x^2/384))^8
% as an approximation to exp(z) across [0,1].
close all
x = linspace(-1,1,16);
num  = 1 + x/24;
denom = 1 - x/12 + (x/384).*x;
quot = num./denom;
y = quot.^8;
% plot(x,y,x,exp(x))
 plot(x,y,'ro',x,exp(x),'b')
