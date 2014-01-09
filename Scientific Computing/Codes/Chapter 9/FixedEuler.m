  function [tvals,yvals] = FixedEuler(fname,y0,t0,tmax,M2,tol)
% [tvals,yvals] = FixedEuler(fname,y0,t0,tmax,M2,tol)
% Fixed step Euler method.
%
% fname is a string that names a function of the form f(t,y). 
% M2 a bound on the second derivative of the solution to
%                 y' = f(t,y),   y(t0) = y0
% on the interval [t0,tmax].
%
% Determine positive n so that if tvals = linspace(t0,tmax,n), then
% y(i) is within tol of the true solution y(tvals(i)) for i=1:n.
 
n = ceil(((tmax-t0)^2*M2)/(2*tol))+1;
h = (tmax-t0)/(n-1);
yvals = zeros(n,1);
tvals = linspace(t0,tmax,n)';
yvals(1) = y0;
for n=1:n-1
   fval = feval(fname,tvals(n),yvals(n));
   yvals(n+1) = yvals(n)+h*fval;
end