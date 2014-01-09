function [a,b,c,d] = Fit(x,y,s,sigma)
% x,y,s are column n-vectors
% sigma is a positive scalar
%
% a,b,c,d are column (n-1)-vectors so that if
%
%     g(z) = a(i) + b(i)(z-x(i)) + c(i)exp(sigma(z-x(i))) + d(i)exp(-sigma(z-x(i)))
% 
% then g(x(i))= y(i), g'(x(i)) = s(i), g(x(i+1)) = y(i+1), and g'(x(i+1)) = s(i+1)
% for i=1:n.

n = length(x);
a = zeros(n-1,1);
b = zeros(n-1,1);
c = zeros(n-1,1);
d = zeros(n-1,1);

for i=1:n-1
   del = x(i+1)-x(i);
   f = exp(sigma*del);
   M = [1   0      1        1; ...
         1  del     f       1/f; ...
         0   1    sigma   -sigma; ...
         0   1  sigma*f   -sigma/f];
      rhs = [y(i);y(i+1);s(i);s(i+1)];
   u = M\rhs;
   a(i) = u(1);
   b(i) = u(2);
   c(i) = u(3);
   d(i) = u(4);
end