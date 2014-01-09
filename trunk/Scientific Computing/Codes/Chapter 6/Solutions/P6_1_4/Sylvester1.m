function X = Sylvester1(S,T,B)
% X = Sylvester1(S,T,B)
%
% S is an m-by-m lower triangular. 
% T is an n-by-n lower triangular with no diagonal entries in
%         common with S.
% B is an m-by-n matrix.
% 
% X is an m-by-n so SX-XT=B.
%

[m,n] = size(B);
X = zeros(m,n);
for k=n:-1:1
	if k==n
	   v = B(:,n);
	else
	   v = B(:,k) + X(:,k+1:n)*T(k+1:n,k);
	end
   X(:,k) = LTriSol(S-T(k,k)*eye(m,m),v);
end