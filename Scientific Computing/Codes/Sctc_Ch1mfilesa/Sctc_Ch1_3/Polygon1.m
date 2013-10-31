% Script File:   Polygon1.m
% Plots  selected regular polygons.

close all
%%  make a concatenation of vectors.
x1 = linspace(1, 10, 10);
x2 = linspace(20, 100, 9);
u = [x1 x2];
y1 = x1';
y2 = x2';
v = [y1; y2];

%% display a regular 360-gon (a circle) with radius 1.
theta = linspace(0,2*pi,361) ;
c = cos(theta);
s = sin(theta);
plot(c,s)
% axis off  
axis equal

%% plot a triangle

x = [c(1) c(121) c(241) c(361)];
y = [s(1) s(121) s(241) s(361)];
plot(x, y)
axis equal
