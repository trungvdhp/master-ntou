
function numI = AdaptQNC(fname,a,b,m,tol) 

% numI = AdaptQNC(fname,a,b,m,tol) 
%
% Integrates a function from a to b
% fname is a string that names an available function of the form f(x) that 
% is defined on [a,b] . f should return a column vector if x is a column vector
% a,b are real scalars, m is an integer that satisfies 2 <= m <=11, and
% tol is a positive real.
% numI is a composite m-point Newton-Cotes approximation of the
% integral of f(x) from a to b, with the abscissae chosen adaptively.

A1 = CompQNC(fname,a,b,m,1);
A2 = CompQNC(fname,a,b,m,2);
d = 2*floor((m-1)/2)+1;
error = (A2-A1)/(2^(d+1)-1);
if abs(error) <= tol
   % A2 is acceptable
   numI = A2 + error;
else
   % Sum suitably accurate left and right integrals
   mid = (a+b)/2;
   numI = AdaptQNC(fname,a,mid,m,tol/2) + AdaptQNC(fname,mid,b,m,tol/2);
end