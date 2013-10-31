function circle(r)

% Script File:  circle
% Plot a circle with radius 1 centered at the origin

theta = linspace(0,2*pi,361) ;
c = r*cos(theta);
s = r*sin(theta);
plot(c,s,'r')
axis equal
