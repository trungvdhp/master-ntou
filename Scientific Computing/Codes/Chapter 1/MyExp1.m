  function y = MyExp1(x)
% y = MyExp1(x)
% x is a column n-vector and y is a column n-vector with the property that
% y(i) is a Taylor approximation to exp(x(i)) for i=1:n.

  nTerms = 17;   
  n = length(x);
  y = ones(n,1);
  for i=1:n
     y(i) = MyExpF(x(i),nTerms);
  end