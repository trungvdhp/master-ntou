% Script P5_3_1
%
% Integral of SampleF2 over [0,2]x[0,2] for various 2D composite
% QNC(7) rule.

clc
m = 7;
disp(' Subintervals    Integral       Relative Time')
disp('------------------------------------------------')
for n = [4 8 16 32]
   tic;
   numI2D = MyCompQNC2D('SampleF2',0,2,0,2,m,n,m,n);
   t = toc;
   if n==4;
      base = t;
      time = 1;
   else
      time = t/base;
   end
   disp(sprintf(' %7.0f  %17.15f  %11.1f',n,numI2D,time))
end