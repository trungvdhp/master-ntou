function numI = AdaptQNC1(fname,a,b,m,tol,OldEvals)
%
% fname is a string that names an available function of the
%     form f(x) that is defined on [a,b]. f should
%     return a column vector if x is a column vector.
% a,b are real scalars 
% m is an integer that satisfies 2 <= m <=11
% tol is a positive real
% OldEvals is the value of f at linspace(a,b,m) (optional)
%
% numI is the composite m-point Newton-Cotes approximation of the 
%     integral of f(x) from a to b, with the abscissae chosen adaptively. 

% Compute the integral two ways and estimate the error.
xvals = linspace(a,b,(2*m-1))';
if nargin == 5
   OldEvals = feval(fname,xvals(1:2:(2*m-1)));
end
NewEvals = feval(fname,xvals(2:2:(2*m-2)));
fEvals = zeros(2*m-1,1);
fEvals(1:2:(2*m-1)) = OldEvals;
fEvals(2:2:(2*m-2)) = NewEvals;
A1 = (b-a)*NCweights(m)'*fEvals(1:2:(2*m-1));
A2 = ((b-a)/2)*NCweights(m)'*(fEvals(1:m) + fEvals(m:(2*m-1)));

d = 2*floor((m-1)/2)+1;
error = (A2-A1)/(2^(d+1)-1);
if abs(error) <= tol
   % A2 is acceptable
   numI = A2 + error;
else
   % Sum suitably accurate left and right integrals
   mid = (a+b)/2;
   numI = AdaptQNC1(fname,a,mid,m,tol/2,fEvals(1:m)) + ...
      AdaptQNC1(fname,mid,b,m,tol/2,fEvals(m:2*m-1));
end