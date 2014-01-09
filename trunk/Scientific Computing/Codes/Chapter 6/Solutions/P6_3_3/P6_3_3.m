% Problem P6_3_3
%
% Computing a specified entry of A^-1.

clc
n = 6;
A = hilb(n)
X = zeros(n,n);
for i=1:n
   for j=1:n
      X(i,j) = Ainv1(A,i,j);
   end
end
disp('Computed inverse using Ainv:')
disp(' ' )
for i=1:n
   disp(sprintf('  %10.0f  %10.0f  %10.0f  %10.0f  %10.0f  %10.0f',X(i,:)))
end
Xexact = invhilb(n)