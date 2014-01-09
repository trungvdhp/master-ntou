function numI = CompCorrTrap(fname,fpname,a,b,n)
% fname,fpname are strings that name a function f(x) and its derivative.
% a,b are reals
% n is a positive integer
%
% numI is an approximation of the integral of f from a to b.

h = (b-a)/n;
corr = (h^2/12)*(feval(fpname,a) - feval(fpname,b));
numI = CompQNC(fname,a,b,2,n) + corr;