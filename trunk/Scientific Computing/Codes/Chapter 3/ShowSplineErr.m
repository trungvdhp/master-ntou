% Script File: ShowSplineErr
% Examines error in the not-a-knot spline interpolant of 
% sin(2pi*x) across the interval [0,1]. Two equally-spaced knot
% cases are plotted: h =.05  and h = .005.  

close all
z = linspace(0,1,500)';
SinVals = sin(2*pi*z);
k=0;
for n=[21 201 ]
   x = linspace(0,1,n)';
   y = sin(2*pi*x);
   [a,b,c,d] = CubicSpline(x,y);
   Svals = pwCEval(a,b,c,d,x,z);
   k=k+1;
   subplot(1,2,k)
   semilogy(z,abs(SinVals-Svals)+eps);
   axis([0 1 10^(-12) 10^(-3)])
   xlabel(sprintf('Knot Spacing = %5.3f',1/(n-1)))
end