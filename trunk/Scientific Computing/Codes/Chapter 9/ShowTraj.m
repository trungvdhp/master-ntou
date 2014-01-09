% Script File: ShowTraj
% Plots a family of solutions to y'(t) = -5y(t)

close all
t= linspace(-.1,.4);
y = exp(-5*t);
plot(t,y);
axis([-.1 .4 0 2])
hold on
for c=linspace(0,4,21)
   plot(t,c*y)
end
plot(0,1,'o')
plot(t,y,'LineWidth',2)
hold off
title('Solutions to y''(t)  =  -5 y(t)')