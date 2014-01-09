function [x,y] = pwLAdapt1(fname,xL,fL,xL1,fL1,xR1,fR1,xR,fR,delta,hmin)
% fname is a string that names an available function of the form y = f(u).
% xL,fL are scalars where fL = f(xL)
% xL1,fL1 are scalars where fL1 = f(xL1)
% xR,fR are scalars where fR = f(xR)
% xR1,fR1 are scalars where fR1 = f(xR1)
%
% xL1 = (2L + R)/3 and xR1 = L + 2R)/3
% delta is a positive real
% hmin is a positive real
%
% x is a column n-vector with the property that
%              xL = x(1) < ... < x(n) = xR. 
% Each subinterval [L,R] is either <= hmin in length or has the property
% that |f(m) - L(m)| <= delta for m = (2L+R)/3 or (L+2R)/3 and where L(x) 
% is the line that connects (xL,fL) and (xR,fR).
%                 
% y is a column n-vector with the property  that y(i) = f(x(i)).

if (xR-xL) <= hmin
   % Subinterval is acceptable
   x = [xL;xR]; 
   y = [fL;fR];
else
   if abs((2*fL+fR)/3 - fL1) <= delta  & abs((fL+2*fR)/3 - fR1) <= delta
      % Subinterval accepted. 
      x = [xL;xR];
      y = [fL;fR];
   else
      % Produce left and right partitions, then synthesize.
      mid = (xL+xR)/2;
      fmid = feval(fname,mid);
      zL = (5*xL+xR)/6;
      fzL = feval(fname,zL);
      zR = (xL+5*xR)/6;
      fzR = feval(fname,zR);
      [xLeft,yLeft]   = pwLAdapt1(fname,xL,fL,zL,fzL,xL1,fL1,mid,fmid,delta,hmin);
      [xRight,yRight] = pwLAdapt1(fname,mid,fmid,xR1,fR1,zR,fzR,xR,fR,delta,hmin);
      x = [ xLeft;xRight(2:length(xRight))];
      y = [ yLeft;yRight(2:length(yRight))];
   end
end