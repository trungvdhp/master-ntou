% Script File: ShowHermite
% Plots a succession of cubic interpolants to cos(x).
% x(2) converges to x(1) = 0 and x(3) converges to x(4) = 3pi/2.

close all
z = linspace(-pi/2,2*pi,100);
CosValues = cos(z);
for d = [1 .5  .3  .1  .05 .001]
   figure
   xvals = [0;d;(3*pi/2)-d;3*pi/2];
   yvals = cos(xvals);
   c = InterpN(xvals,yvals);
   CubicValues = HornerN(c,xvals,z); 
   plot(z,CosValues,z,CubicValues,'--',xvals,yvals,'*')
   axis([-.5 5 -1.5 1.5])
   title(sprintf('Interpolation of cos(x). Separation = %5.3f',d))
end