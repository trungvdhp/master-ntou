% Script File: AveNorms
% Examines average value of norms.

clc
disp('r1 = norm(x,1)/norm(x,''inf'')')
disp('r2 = norm(x,2)/norm(x,''inf'')')
disp(' ')
disp('    n          r1           r2')
disp('----------------------------------')
r = 100;
for n = 10:10:100
   s1 = 0;
   s2 = 0;
   for k=1:r
      x = randn(n,1);
      s1 = s1 + norm(x,1)/norm(x,'inf');
      s2 = s2 + norm(x,2)/norm(x,'inf');
   end
   disp(sprintf(' %4d    %10.3f   %10.3f',n,s1/r,s2/r))
end