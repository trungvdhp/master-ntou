function [xi,yi] = SplineInPlane(x,y,m)
% x and y are columnn-vectors.
% xi and yi are pp-representations of not-a-knot splines with the
% property that they interpolate x(i) and y(i) respectively
% at their knots.

n = length(x);
d = sqrt( (x(2:n)-x(1:n-1)).^2 + (y(2:n)-y(1:n-1)).^2 );
t = [0; cumsum(d)];
ti = linspace(0,t(n),m)';
xi = spline(t,x,ti);
yi = spline(t,y,ti);