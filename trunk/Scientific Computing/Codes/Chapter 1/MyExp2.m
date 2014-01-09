  function y = MyExp2(x)
% y = MyExp2(x)
% x is an n-vector and y is an n-vector with with the same shape
% and the property that y(i) is a Taylor approximation to 
% exp(x(i)) for i=1:n.

  y = ones(size(x));
  nTerms = 17;
  term = ones(size(x));
  for k=1:nTerms
     term = x.*term/k;
     y = y + term;
  end