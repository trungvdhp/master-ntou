function C = Circulant2(a)
% C = Circulant2(a) is a circulant matrix with first row equal to a.
  
n = length(a);
C = zeros(n,n);
C(1,:) = a;
for i=2:n
   C(i,:) = [ C(i-1,n) C(i-1,1:n-1) ];    
end