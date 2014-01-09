function C = EmbedToep(col,row)
% col is a column n-vector
% row is a row n-vector with row(1) = col(1)
%
% C is a circulant matrix of size 2n-1 with the property
% that C(1:n,1:n) = T where T is an n-by-n Toeplitz
% matrix with T(:,1) = col and T(1,:) = row.
n = length(col);
m = 2*n-1;
C = zeros(m,m);
C(1,:) = [row col(n:-1:2)'];
for k=2:m
   C(k,:) = [C(k-1,m) C(k-1,1:m-1)];
end
