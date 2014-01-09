  function [a,b,c,d] = HCubic(xL,yL,sL,xR,yR,sR)
% [a,b,c,d] = HCubic(xL,yL,sL,xR,yR,sR)
% Cubic Hermite interpolation
% 
% (xL,yL,sL) and (xR,yR,sR) are x-y-slope triplets with xL and xR distinct.
% a,b,c,d are real numbers with the property that if
%            p(z) = a + b(z-xL) + c(z-xL)^2 + d(z-xL)^2(z-xR)
% then p(xL)=yL, p'(xL)=sL, p(xR)=yR, and p'(xR)=sR.

a = yL; 
b = sL;
delx = xR - xL;  
yp = (yR - yL)/delx;
c  = (yp - sL)/delx;
d  = (sL - 2*yp + sR)/(delx*delx);