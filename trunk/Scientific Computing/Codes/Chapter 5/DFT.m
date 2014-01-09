function y = DFT(x)
% y = DFT(x)
% y is the discrete Fourier transform of a column n-vector x.  

n = length(x);
y = x(1)*ones(n,1);
if n > 1
   v = exp(-2*pi*sqrt(-1)/n).^(0:n-1)';
   for k=2:n
      z = rem((k-1)*(0:n-1)',n ) +1;
      y = y + v(z)*x(k);
   end
end