function X = Sylvester(S,T,B)
% X = Sylvester(S,T,B)
%
% S is an m-by-m upper triangular 
% T is an n-by-n upper triangular with no diagonal entries in
%         common with S.
% B is an m-by-n matrix.
% 
% X is an m-by-n so SX-XT=B.

[m,n] = size(B);
X = zeros(m,n);
for k=1:n
   if k==1
      v = B(:,k);
   else
      v = B(:,k) + X(:,1:k-1)*T(1:k-1,k);
   end
   X(:,k) = UTriSol(S-T(k,k)*eye(m,m),v);
end