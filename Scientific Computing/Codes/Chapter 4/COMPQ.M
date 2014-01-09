
function numI = CompQ(fname,a,b,m,n)
%
% Pre:
%   fname    string that names an available function of the
%            form f(x) that is defined on [a,b]. f should
%            return a column vector if x is a column vector.
%     a,b    real scalars 
%       m    integer that satisfies 2 <= m <=11
%       n    positive integer
%    rule    a string that specifies the rule type:
%                 'NCOpen'  open Newton-Cotes
%                 'GL'      Gaus-Legendre
%
% Post:
%    numI    the composite m-point Newton-Cotes approximation of the 
%            integral of f(x) from a to b. The rule is applied on
%            each of n equal subintervals of [a,b].

Ntotal = n*m;
h=(b-a)/(2*Ntotal);
[ws,xs] = WGL(m);
xvals1= kron(linspace(a+h,b-h,n)',ones(m,1))
xvals2= kron(ones(n,1),xs)
fval=feval(fname,xvals);
w = kron(ones(n,1),ws);  