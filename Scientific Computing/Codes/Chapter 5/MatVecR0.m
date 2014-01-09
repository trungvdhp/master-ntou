function y = MatVecR0(A,x)
% y = MatVecRO(A,x)
% Computes the matrix-vector product y = A*x (via saxpys) where
% A is an m-by-n matrix and x is a columnn-vector.

[m,n] = size(A);
y = zeros(m,1);
for i=1:m
   y(i) = A(i,:)*x;
end