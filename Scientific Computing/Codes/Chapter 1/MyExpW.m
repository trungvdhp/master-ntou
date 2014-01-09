  function y = MyExpW(x)
% y = MyExpW(x)
% x is a scalar and y is a Taylor approximation to exp(x).

y = 0;
term = 1;
k=0;
while abs(term) > eps*abs(y)
   k = k + 1;
   y = y + term;
   term = x*term/k;
end