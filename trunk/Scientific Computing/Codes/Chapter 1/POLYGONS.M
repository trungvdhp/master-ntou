% Script File: Polygons
% Plots selected regular polygons.

close all
theta = linspace(0,2*pi,361);
c = cos(theta);
s = sin(theta);
k=0;
for sides = [3 4 5 6 8 10 12 18 24]
   stride = 360/sides;
   k=k+1;
   subplot(3,3,k)
   plot(c(1:stride:361),s(1:stride:361))
   axis([-1.2 1.2 -1.2 1.2])
   axis equal
end