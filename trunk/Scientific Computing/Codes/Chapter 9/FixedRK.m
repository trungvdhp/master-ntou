  function [tvals,yvals] = FixedRK(fname,t0,y0,h,k,n)
% [tvals,yvals] = FixedRK(fname,t0,y0,h,k,n)
% Produces approximate solution to the initial value problem
%
%      y'(t) = f(t,y(t))     y(t0) = y0
%
% using a strategy that is based upon a k-th order
% Runge-Kutta method. Stepsize is fixed.
%
% fname = string that names the function f.
% t0 = initial time.
% y0 = initial condition vector.
% h  = stepsize.
% k  = order of method. (1<=k<=5).
% n  = number of steps to be taken,
%
% tvals is a column vector with tvals(j) = t0 + (j-1)h, j=1:n+1
% yvals is a matrix with yvals(j,:) = approximate solution at tvals(j), j=1:n+1

tc = t0;
yc = y0;
tvals = tc;
yvals = yc';
fc = feval(fname,tc,yc);
for j=1:n
   [tc,yc,fc] = RKstep(fname,tc,yc,fc,h,k);
   yvals = [yvals; yc' ];
   tvals = [tvals; tc];
end