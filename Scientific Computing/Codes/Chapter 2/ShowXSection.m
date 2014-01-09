% Script File: ShowXsection
% Displays a cross section of the Humps2D function.

a = 0; b = 5; n = 300; c = 0; d = 3; m = 200;
fA = SetUp('Humps2D',a,b,n,c,d,m);
x1 = 5; x2 = 0; y1 = 0; y2 = 3; nVals = 100;
xVals = linspace(5,0,nVals); yVals = linspace(0,3,nVals);
for k=1:nVals
   z(k) = LinInterp2D(xVals(k),yVals(k),a,b,c,d,fA);
end
plot(linspace(0,1,nVals),z)
title('Humps2D(5-5t,3t) 0<=t<=1')
