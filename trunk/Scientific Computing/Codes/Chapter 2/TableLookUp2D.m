% Script File: TableLookUp2D
% Illustrates SetUp and LinearInterp2D.

close all
clc
a = 0; b = 5; n = 11;
c = 0; d = 3; m = 7;
fA = SetUp('Humps2D',a,b,n,c,d,m);
contour(fA)
x = input(sprintf('Enter x (%3.1f <= x <= %3.1f ):',a,b));
y = input(sprintf('Enter y (%3.1f <= y <= %3.1f ):',c,d));
z = LinInterp2D(x,y,a,b,c,d,fA);
disp(sprintf('f(x,y) = %20.16f\n',z))
