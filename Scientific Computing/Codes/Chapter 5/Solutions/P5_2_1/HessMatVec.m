function y = HessMatVec(A,z)
% A is m-by-n with A(i,j) = 0, i>j+1, z is n-by-1.
% y = A*z
[n,n] = size(A);
y = z(n)*A(:,n);
for k=1:n-1
   y(1:k+1) = y(1:k+1) + A(1:k+1,k)*z(k);
end