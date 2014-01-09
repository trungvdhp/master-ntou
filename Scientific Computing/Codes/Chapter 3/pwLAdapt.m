  function [x,y] = pwLAdapt(fname,xL,fL,xR,fR,delta,hmin)
% [x,y] = pwLAdapt(fname,xL,fL,xR,fR,delta,hmin)
% Adaptively determines interpolation points for a piecewise linear
% approximation of a specified function.
%   
% fname is a string that specifies a function of the form y = f(u).
% xL and xR are real scalars and fL = f(xL) and fR = f(xR).
% delta and hmin are positive real scalars that determine accuracy.
%
% x and y are column n-vector with the property that
%              xL = x(1) < ... < x(n) = xR
% and y(i) = f(x(i)), i=1:n. Each subinterval [x(i),x(i+1)] is
% either <= hmin in length or has the property that at its midpoint m,
% |f(m) - L(m)| <= delta where L(x) is the line that connects (x(i),y(i)) 
% and (x(i+1),y(i+1)).
 
if (xR-xL) <= hmin
   % Subinterval is acceptable
   x = [xL;xR]; 
   y = [fL;fR];
else
   mid  = (xL+xR)/2; 
   fmid = feval(fname,mid);
   if (abs(((fL+fR)/2) - fmid) <= delta )
      % Subinterval accepted. 
      x = [ xL;xR];
      y = [fL;fR];
   else
      % Produce left and right partitions, then synthesize.
      [xLeft,yLeft]   = pwLAdapt(fname,xL,fL,mid,fmid,delta,hmin);
      [xRight,yRight] = pwLAdapt(fname,mid,fmid,xR,fR,delta,hmin);
      x = [ xLeft;xRight(2:length(xRight))];
      y = [ yLeft;yRight(2:length(yRight))];
   end
end
