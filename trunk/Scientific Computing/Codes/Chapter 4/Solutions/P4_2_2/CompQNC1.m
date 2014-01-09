function numI = CompQNC1(fname,a,b,m,n)
% fname is a string that names an available function of the
%       form f(x) that is defined on [a,b]. f should
%       return a column vector if x is a column vector.
% a,b are real scalars 
% m is an integer that satisfies 2 <= m <=11
% n is a positive integer
%
% numI is the the composite m-point Newton-Cotes approximation of the 
%       integral of f(x) from a to b. The rule is applied on
%       each of n equal subintervals of [a,b].

w = CompNCweights(m,n);
x = linspace(a,b,n*(m-1)+1)';
f = feval(fname,x);
numI = (b-a)*w'*f;