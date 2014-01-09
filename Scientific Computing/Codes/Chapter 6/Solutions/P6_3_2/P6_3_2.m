% Problem P6_3_2
%
% Illustrates computation of a 5-by-5 LU factorization
% with parameterized pivoting.

clc
format short
disp('Steps through Gaussian elimination of a 5-by-5')
disp('matrix showing pivoting.')
alfa = input('Enter alfa (0 < alfa <= 1): ');
input('Strike Any Key to Continue.');
clc
n = 7;
A = magic(n);
[n,n] = size(A); 
L = eye(n,n);
piv = 1:n;
for k=1:n-1
   clc
   [maxv,r] = max(abs(A(k+1:n,k)));
   if abs(A(k,k)) >= alfa*maxv
      % No Interchange
      q = k;
   else
      q = r+k;
   end
   Before = A
   disp(sprintf('piv = [ %1.0f  %1.0f  %1.0f  %1.0f  %1.0f  %1.0f  %1.0f  %1.0f ]',piv))
   disp(' ')
   disp(sprintf('Interchange rows k = %1.0f and q = %1.0f',k,q))
   piv([k q]) = piv([q k]);
   A([k q],:) = A([q k],:);
   After = A
   disp(sprintf('piv = [ %1.0f  %1.0f  %1.0f  %1.0f  %1.0f  %1.0f  %1.0f  %1.0f ]',piv))
   disp(' ')
   disp(sprintf('Zero A(%1.0f:%1.0f,%1.0f):',k,k+1,k))
   input('Strike Any Key to Continue.');
   clc 
   if A(k,k) ~= 0
      L(k+1:n,k) = A(k+1:n,k)/A(k,k);
      A(k+1:n,k+1:n) = A(k+1:n,k+1:n) - L(k+1:n,k)*A(k,k+1:n);
      A(k+1:n,k) = zeros(n-k,1); 
   end
end
clc
L=L
U = A
piv = piv