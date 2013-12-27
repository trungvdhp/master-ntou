% Script File: ShowSplineQ
% Examine spline quadrature on integral of sine from 0 to pi/2.

clc
disp('   m     Spline Quadrature')
disp('----------------------------')
for m=[5 50 500]
   x    = linspace(0,pi/2,m);
   y    = sin(x);
   numI = SplineQ(x,y);
   disp(sprintf(' %3.0f  %20.16f',m,numI))
end