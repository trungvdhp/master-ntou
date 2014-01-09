% Problem P6_1_6
%
% Inverse of Forsythe matrix.

n = input('Enter n: ');
A = tril(-ones(n,n) + 2*eye(n,n))
A_inv = eye(n,n);
for j = 1:n
   for i=j+1:n
      A_inv(i,j) = 2^(i-j-1);	
   end
end
A_inv = A_inv