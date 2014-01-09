% Script File: ShowSparseLS
% Illustrate sparse backslash solving for LS problems

clc
n = 50;
disp(' m      n   full A flops   sparse A flops')
disp('----------------------------------------')
for m = 100:100:1000
   A = tril(triu(rand(m,m),-5),5);
   p = m/n;
   A = A(:,1:p:m);
   A_sparse = sparse(A);
   b = rand(m,1);
   % Solve an m-by-n LS problem where the A matrix has about
   % 10 nonzeros per column. In column j these nonzero entries
   % are more or less A(j*m/n+k,j), k=-5:5.
   flops(0)
   x = A\b;      
   f1 = flops;
   flops(0)
   x = A_sparse\b; 
   f2 = flops;
   disp(sprintf('%4d  %4d  %10d  %10d  ',m,n,f1,f2))
end
