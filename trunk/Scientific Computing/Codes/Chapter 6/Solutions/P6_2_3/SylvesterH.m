function X = SylvesterH(H,T,B)
% X = SylvesterH(H,T,B)
%
% S is an m-by-m upper Hessenberg matrix.
% T is an n-by-n upper triangular matrix with the property that HX-XT=B
%     is a nonsingular linear system.
% B is an m-by-n matrix.
% 
% X is an m-by-n matrix that satisfies HX-XT=B.
%
[m,n] = size(B);
X = zeros(m,n);
for k=1:n
   if k==1
      r = B(:,k);
   else
      r = B(:,k) + X(:,1:k-1)*T(1:k-1,k);
   end
   [v,U] = HessLU(H-T(k,k)*eye(m,m));
   y = LBiDiSol(v,r);
   X(:,k) = UTriSol(U,y);
end