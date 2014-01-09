% Script File: Show2DQuad
% Integral of SampleF2 over [0,2]x[0,2] for various 2D composite
% QNC(7) rules.

clc
m = 7;
disp(' Subintervals    Integral            Time')
disp('------------------------------------------------')
for n = [32 64 128 256]
   tic, numI2D = CompQNC2D('SampleF2',0,2,0,2,m,n,m,n); time = toc;
   disp(sprintf(' %7.0f  %17.15f  %11.4f',n,numI2D,time))
end