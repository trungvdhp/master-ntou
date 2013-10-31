
function R = PadeCoef(p,q) 

% P = PadeCoef(p,q) 
% p and q are nonnegative integers and R is a representation of the 
% (p,q)-Pade approximation N(x)/D(x)  to exp(x). 
% 
% R.num is a row (p+1)-vector whose entries are the coefficients of the
%       p-degree numerator polynomial N(x). 
% R.den is a row (q+1)-vector whose entries are the coefficients of the
%       q-degree denomerator polynomial D(x).
%  Thus,
%                   R.num[1] + R.num[2]x + R.num[3]x^2
%                  -----------------------------------
%                         R.den[1] + R.den[2]x
% is the (2,1) Pade approximation.

numer = [1]; denom =[1]; 
for k = 1:p,
  numCoef = factorial(p+q-k)*factorial(p)/(factorial(p+q)*factorial(k)*factorial(p-k));
  numer = [numer numCoef];
end
for k = 1:q,  
  denCoef = factorial(p+q-k)*factorial(q)/(factorial(p+q)*factorial(k)*factorial(q-k));
  denom = [denom denCoef];
end
R = struct('num',numer, 'den',denom);


