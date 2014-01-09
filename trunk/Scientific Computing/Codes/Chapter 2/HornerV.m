  function pVal = HornerV(a,z)
% pVal = HornerV(a,z)
% evaluates the Vandermonde interpolant on z where
% a is an n-vector and z is an m-vector.
%
% pVal is a vector the same size as z with the property that if
%
%          p(x) = a(1) + .. +a(n)x^(n-1)
% then
%          pVal(i) = p(z(i))  ,  i=1:m.

n = length(a); 
m = length(z);
pVal = a(n)*ones(size(z));
for k=n-1:-1:1
   pVal = z.*pVal + a(k);
end