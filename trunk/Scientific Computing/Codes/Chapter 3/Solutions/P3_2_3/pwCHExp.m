function [x,y] = pwCHExp(a,b,tol)
% a,b are real scalars with a < b.
% tol is a positive real scalar.
% 
% x,y is a column n-vectors where a = x(1) < x(2) < ... < x(n) = b 
%     and y(i) = exp(-x(i)), i=1:n.
% The partition is chosen so that if C(z) is the piecewise cubic  
%     hermite interpolant of exp(-z) on this partition, 
%     then |C(z) - exp(-z)| <= tol for all z in [a,b].

x = a;
y = exp(-a);
n = 1;
while x(n) < b
   [R,fR] = stretch(x(n),y(n),tol);
   if R < b
      x = [x;R];
      y = [y;fR];
   else
      x = [x;b];
      y = [y;exp(-b)];
   end
   n = n+1;
end