  function [xLS,res] = LSq(A,b)
% [xLS,res] = LSq(A,b)  
% Solution to the LS problem min norm(Ax-b) where A is a full
% rank m-by-n matrix with m>=n and b is a column m-vector.
% xLS is the n-by-1 vector that minimizes the norm(Ax-b) and
% res = norm(A*xLS-b).

[m,n] = size(A);
for j=1:n
   for i=m:-1:j+1
      %Zero A(i,j)
      [c,s] = Rotate(A(i-1,j),A(i,j));
      A(i-1:i,j:n) = [c s; -s c]*A(i-1:i,j:n);
      b(i-1:i) = [c s; -s c]*b(i-1:i);
   end
end
xLS = UTriSol(A(1:n,1:n),b(1:n));
if m==n
   res = 0;
else
   res = norm(b(n+1:m));
end