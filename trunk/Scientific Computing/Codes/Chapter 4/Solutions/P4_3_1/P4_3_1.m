% Problem P4_3_1
%
% Uses quad and Adapt to estimate the integral of the
% humps function from 0 to 1.

clc

disp('  Tol           quad         Adapt       Quad Time / Adapt Time')
disp('-----------------------------------------------------------------')
for tol = logspace(-2,-5,4)
   
   tic;
   Q1 = quad('humps',0,1,tol);
   t1 = toc;
   
   tic;
   Q2 = Adapt('humps',0,1,tol);
   t2 = toc;  
   
   disp(sprintf('%7.5f     %10.8f   %10.8f          %8.3f',tol,Q1,Q2,t2/t1))
end