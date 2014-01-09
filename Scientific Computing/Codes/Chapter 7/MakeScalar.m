  function A = MakeScalar(A_block)
% A = MakeScalar(A_block)
% Represents the m-by-m block matrix A_block as an n-by-n matrix of scalrs with 
% where each block is p-by-p and n=mp.

[m,m] = size(A_block);
[p,p] = size(A_block{1,1});
for i=1:m
   for j=1:m
      if ~isempty(A_block{i,j})
         A(1+(i-1)*p:i*p,1+(j-1)*p:j*p) = A_block{i,j};
      end
   end
end