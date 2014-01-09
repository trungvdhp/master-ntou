% Script File: ShowQuads
% Uses quad and quad8 to estimate the integral of the
% humps function from 0 to 1.

clc
disp('Tolerance       quad       N-quad   quad8      N-quad8')
disp('------------------------------------------------------')
for tol = logspace(-2,-6,5)
   [Q1,count1] = quad('humps',0,1,tol);
   s1 = sprintf('  %12.7f  %5.0f',Q1,count1);
   [Q2,count2] = quad8('humps',0,1,tol);
   s2 = sprintf('  %12.7f  %5.0f',Q2,count2);
   disp([sprintf('%8.6f ',tol) s1 s2])  
end

disp(sprintf('\n\n\n'))
disp('   alpha   beta      quad')
disp('----------------------------')
for alpha = [-3 -2 -1];
   for beta = 1:3
      G = quad('F4_3_2',0,1,.001,0,alpha,beta);
      disp(sprintf('   %3.0f     %3.0f   %10.6f',alpha,beta,G))
   end
end