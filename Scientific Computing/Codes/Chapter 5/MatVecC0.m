function y = MatVecC0(A,x)
% y = MatVecCO(A,x)
% This computes the matrix-vector product y = A*x (via saxpys) where
% A is an m-by-n matrix and x is a columnn-vector.

[m,n] = size(A);
y = zeros(m,1);
for j=1:n
   y = y + A(:,j)*x(j);
end