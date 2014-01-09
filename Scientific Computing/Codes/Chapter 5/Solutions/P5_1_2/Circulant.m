function C = Circulant(v)
% v a column vector
% C is a circulant matrix with first row = v.

C = toeplitz([1; v(length(v):-1:2)],v);