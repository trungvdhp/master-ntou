function y = TriMatVec(A,x)
% A is an m-by-n upper triangular matrix and x n-by-1.
% y = A*x

[m,n] = size(A);
y = zeros(m,1);
for k=1:n
   s = min([k m]);
   y(1:s) = y(1:s) + A(1:s,k)*x(k);
end
