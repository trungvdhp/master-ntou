function B = ScaleRows(A,d)
% A is an m-by-n and d an m-vector
% B = diag(d)*A 
[m,n] = size(A);
B = zeros(m,n);
for i=1:m
   B(i,:) = d(i)*A(i,:);
end