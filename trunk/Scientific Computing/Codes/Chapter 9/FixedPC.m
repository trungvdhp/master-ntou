  function [tvals,yvals] = FixedPC(fname,t0,y0,h,k,n)
% [tvals,yvals] = FixedPC(fname,t0,y0,h,k,n)
% Produces an approximate solution to the initial value problem
%
%      y'(t) = f(t,y(t))     y(t0) = y0
%
% using a strategy that is based upon a k-th order
% Adams Predictor-Corrector framework. Stepsize is fixed.
%
% fname = string that names the function f.
% t0 = initial time.
% y0 = initial condition vector.
% h  = stepsize.
% k  = order of method. (1<=k<=5).
% n  = number of steps to be taken,
%
% tvals is a column vector with tvals(j) = t0 + (j-1)h, j=1:n+1
% yvals is a matrix with yvals(j,:) = approximate solution at tvals(j), j=1:n+1.

[tvals,yvals,fvals] = ABStart(fname,t0,y0,h,k);
tc = tvals(k);
yc = yvals(k,:)';
fc = fvals(:,k);

for j=k:n
   % Take a step and then update.
   [tc,yPred,fPred,yc,fc] = PCstep(fname,tc,yc,fvals,h,k);
   tvals = [tvals; tc];
   yvals = [yvals; yc'];
   fvals = [fc fvals(:,1:k-1)];
end