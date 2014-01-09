% Problem P3_3_10
%
% Spline interpolation in the plane.

close all
theta = linspace(0,2*pi)';
xvals = 5*cos(theta);
yvals = 3*sin(theta);

for n = 5:4:13
   theta = linspace(0,2*pi,n)';
   x = 5*cos(theta);
   y = 3*sin(theta);
   [xi,yi] = SplineInPlane(x,y,100);
   figure
   plot(xvals,yvals,xi,yi,x,y,'o')
   axis('equal')
   pause
end