  function [x,y] = pwLStatic(fname,M2,alpha,beta,delta)
% [x,y] = pwLStatic(fname,M2,alpha,beta,delta)
% Generates interpolation points for a piecewise linear approximation of
% prescribed accuracy. 
%
% fname is string that names an available function f(x).
% Assume that f can take vector arguments.
% M2 is an upper bound for|f"(x)| on [alpha,beta].
% alpha and beta are scalars with alpha<beta.
% delta is a positive scalar.
%
% x and y  column n-vectors with the property that y(i) = f(x(i)), i=1:n. 
% The piecewise linear interpolant L(x) of this data satisfies 
% |L(z) - f(z)| <= delta for x(1) <= z <= x(n).

n = max(2,ceil(1+(beta-alpha)*sqrt(M2/(8*delta))));
x = linspace(alpha,beta,n)';
y = feval(fname,x);