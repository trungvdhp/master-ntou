function numI = CorrTrap(fname,fpname,a,b)
% fname is a string that names a function f(x)
% fpname is a string that names the derivative of f.
% a,b are real numbers
% numI is an approximation to the integral of f(x) from a to b.

fa  = feval(fname,a);
fb  = feval(fname,b);
Dfa = feval(fpname,a);
Dfb = feval(fpname,b);
h = (b-a);
numI = (h/2)*(fa + fb) + (h^2/12)*(Dfa - Dfb);