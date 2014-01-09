  function [tvals,yvals,fvals] = ABStart(fname,t0,y0,h,k)
% [tvals,yvals,fvals] = ABStart(fname,t0,y0,h,k)
% Generates enough starting values for the kth order Adams-Bashforth method.
% Uses k-th order Runge-Kutta to generate approximate solutions to
%
%               y'(t) = f(t,y(t))   y(t0) = y0
%
% at t = t0, t0+h, ... , t0 + (k-1)h. 
%
% fname is a string that names the function f.
% t0 is the initial time.
% y0 is the initial value.
% h is the step size.
% k is the order of the RK method used.
%
% tvals is a column vector with tvals(j) = t0 + (j-1)h, j=1:k
% yvals is a matrix with yvals(j,:) = approximate solution at tvals(j), j=1:k
% For j =1:k, fvals(:,j) = f(tvals(j),yvals(j,:)).

tc = t0;    
yc = y0;     
fc = feval(fname,tc,yc);
tvals = tc; 
yvals = yc'; 
fvals = fc;
for j=1:k-1
   [tc,yc,fc] = RKstep(fname,tc,yc,fc,h,k);
   tvals = [tvals; tc]; 
   yvals = [yvals; yc']; 
   fvals = [fc fvals];
end