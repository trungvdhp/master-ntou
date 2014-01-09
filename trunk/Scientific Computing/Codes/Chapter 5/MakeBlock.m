  function A = MakeBlock(A_scalar,p)
% A = MakeBlock(A_scalar,p)
% A_scalar is an n-by-n matrix and p divides n. A is an (n/p)-by-(n/p) 
% cell array that represents A_scalar as a block matrix with p-by-p blocks. 

[n,n] = size(A_scalar);
m = n/p;
A = cell(m,m);
for i=1:m
   for j=1:m
      A{i,j} = A_scalar(1+(i-1)*p:i*p,1+(j-1)*p:j*p);
   end
end