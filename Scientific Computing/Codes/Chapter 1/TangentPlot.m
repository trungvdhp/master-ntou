% Script File: TangentPlot
% Plots the function tan(x), -pi/2 <= x <= 9pi/2

close all
ymax = 10;
x = linspace(-pi/2,pi/2,40);
y = tan(x);
plot(x,y)
axis([-pi/2 9*pi/2 -ymax ymax])
title('The Tangent Function')
xlabel('x')
ylabel('tan(x)')
hold on
for k=1:4
   xnew = x+ k*pi;
   plot(xnew,y);
end
hold off