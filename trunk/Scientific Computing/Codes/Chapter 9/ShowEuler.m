% Script File: ShowEuler
% Plots a family of solutions to y'(t) = -5y(t)

close all
t= linspace(-.1,.4);
y = exp(-5*t);
plot(t,y);
axis([-.1 .4 0 2])
hold on
tc = 0;
yc = 1;
plot(tc,yc,'*')

hold on
for k=0:4
   title(sprintf('k=%1.0f,  Click t(%1.0f)',k,k+1))
   [tnew,z] = ginput(1);
   hc = tnew-tc;
   fc = -5*yc;
   ynew = yc + hc*fc;
   plot([tc tnew],[yc ynew],'--',tnew,ynew,'o')
   tc = tnew;
   yc = ynew;  
end
title('Five Steps of Euler Method (y''=-5y, y(0)=1) ')
hold off