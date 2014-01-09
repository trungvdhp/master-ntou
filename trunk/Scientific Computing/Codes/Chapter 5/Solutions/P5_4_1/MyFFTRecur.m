function y = MyFFTRecur(x)
% x is a column vector with power-of-two length.
% y is the DFT of x.

global w         % Precomputed weight vector
n = length(x);
if n ==1
   y = x;
else
   m = n/2;
   yT = MyFFTRecur(x(1:2:n));
   yB = MyFFTRecur(x(2:2:n));
   
   % The required weight vector is a subvector of the precomputed weight vector.
   n_orig = 2*length(w);
   s = n_orig/n;
   d = w(1:s:length(w));
   
   z = d.*yB;
   y = [ yT+z ; yT-z ];
end