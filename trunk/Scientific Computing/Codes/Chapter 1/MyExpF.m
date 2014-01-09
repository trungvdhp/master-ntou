  function y = MyExpF(x,n)
% y = MyExpF(x,n)
% x is a scalar, n is a positive integer
% and y = n-th order Taylor approximation to exp(x).
y = 1;
term = 1;
for k = 1:n
   term = x*term/k;
   y = y + term;
end