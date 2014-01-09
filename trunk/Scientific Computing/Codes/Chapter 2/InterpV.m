  function a = InterpV(x,y)
% a = InverpV(x,y) 
% This computes the Vandermonde polynomial interpolant where
% x is a column n-vector with distinct components and y is a 
% column n-vector.
%
% a is a column n-vector with the property that if
%
%         p(x) = a(1) + a(2)x + ... a(n)x^(n-1) 
% then
%         p(x(i)) = y(i), i=1:n

n = length(x);
V = ones(n,n);
for j=2:n
   % Set up column j.
   V(:,j) = x.*V(:,j-1);
end
a = V\y;