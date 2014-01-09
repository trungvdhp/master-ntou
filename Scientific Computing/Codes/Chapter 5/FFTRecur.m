function y = FFTRecur(x)
% y = FFTRecur(x)
% y is the discrete Fourier transform of a column n-vector x where 
% n is a power of two. 

  n = length(x);
  if n ==1
     y = x;
  else
     m = n/2;
     yT = FFTRecur(x(1:2:n));
     yB = FFTRecur(x(2:2:n));
     d = exp(-2*pi*sqrt(-1)/n).^(0:m-1)';
     z = d.*yB;
     y = [ yT+z ; yT-z ];
  end