  function G = CholBlock(A,p)
% G = CholBlock(A,p)
% Cholesky factorization of a symmetric and positive definite n-by-n matrix A.
% G is lower triangular so A = G*G'. p is the block size and must divide n.

% Represent A and G as m-by-m block matrices where m = n/p.
[n,n] = size(A);
m = n/p;
A = MakeBlock(A,p);
G = cell(m,m);
for i=1:m
   for j=1:i
      S = A{i,j};
      for k=1:j-1
         S = S - G{i,k}*G{j,k}';
      end
      if j<i
         G{i,j} = (G{j,j}\S')';
      else
         G{i,i} = CholScalar(S);
      end
   end
end
% Convert G to a scalar matrix.
G = MakeScalar(G);






