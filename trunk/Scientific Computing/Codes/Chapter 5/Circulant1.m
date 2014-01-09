  function C = Circulant1(a)
% C = Circulant1(a) is a circulant matrix with first row equal to a.

n = length(a);
C = zeros(n,n);
for i=1:n
   for j=1:n
     C(i,j) = a(rem(n-i+j,n)+1);
   end   
end