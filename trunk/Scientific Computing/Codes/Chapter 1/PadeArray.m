  function P = PadeArray(m,n)
% P = PadeArray(m,n)
% m and n are nonnegative integers.
% P is an (m+1)-by-(n+1) cell array.
%
% P{i,j} represents the (i-1,j-1) Pade approximation N(x)/D(x) to exp(x).

P = cell(m+1,n+1);
for i=1:m+1
   for j=1:n+1
      P{i,j} = PadeCoeff(i-1,j-1);
   end
end
  

  function R = PadeCoeff(p,q)
% R = PadeCoeff(p,q)
% p and q are nonnegative integers and R is a representation of the
% (p,q)-Pade approximation N(x)/D(x) to exp(x):
%
%     R.num  is a row (p+1)-vector whose entries are the coefficients of the 
%            p-degree numerator polynomial N(x).
%
%     R.den  is a row (q+1)-vector whose entries are the coefficients of the 
%            q-degree denominator polynomial D(x).
%
% Thus, 
%                  R.num[1] + R.num[2]x + R.num[3]x^2
%                 ------------------------------------
%                          R.den[1] + R.den[2]x
%
% is the (2,1) Pade approximation.

a(1) = 1; for k=1:p, a(k+1) =  a(k)*(p-k+1)/(k*(p+q-k+1)); end
b(1) = 1; for k=1:q, b(k+1) = -b(k)*(q-k+1)/(k*(p+q-k+1)); end
R = struct('num',a,'den',b);
      
      