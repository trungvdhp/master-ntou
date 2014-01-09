  function C = Prod3Digit(A,B)
% C = Prod3Digit(A,B)
% This computes the matrix product C = A*B in 3-digit floating point
% arithmetic. A is m-by-p and B is p-by-n.

[m,p] = size(A);
[p,n] = size(B);
C = zeros(m,n);
for i=1:m
   for j=1:n
      s = represent(0);
      for k=1:p
         aik = Represent(A(i,k));
         bkj = Represent(B(k,j));
         s   = Float(s,Float(aik,bkj,'*'),'+');
      end
      C(i,j) = Convert(s);
   end
end