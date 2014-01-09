function [a,b,c,d,x] = pwCStatic(fname,fpname,M4,alpha,beta,delta)
% fname is a string that names an available function f(x).
%       Assume that f can take vector arguments.
% M4 is an upper bound for|f''''(x)| on [alpha,beta].
% alpha and beta are scalars with alpha<beta
% delta is a positive scalar
%
% x is a column n-vector that defines the partition.
% a,b,c,d is a column (n-1)-vectors with the property that C(x(i)) = f(x(i)),
%       i=1:n. The piecewise cubic Hermite interpolant C(x) of this
%       data satisfies |C(x) - f(x)| <= delta, where
%       x = linspace(alpha,beta,n).

n = max(2,ceil(1 + ((beta-alpha)*M4/(384*delta))^.25) );
x = linspace(alpha,beta,n)';
y = feval(fname,x);
s = feval(fpname,x);
a = y(1:n-1);
b = s(1:n-1);
Dx = (beta-alpha)/(n-1);
Dy = diff(y);
yp = Dy/Dx;
c = (yp - s(1:n-1))/Dx;
d = (s(1:n-1) - 2*yp + s(2:n))/Dx^2;