  function [x,y] = pwLAdapt(fname,xL,fL,xR,fR,delta,hmin)
% 
%   Pre:
%  fname       string that names an available function of the form
%              y = f(u).
%     xL       real
%     fL       real, fL = f(xL)
%     xR       real
%     fR       real, fR = f(xR)
%  delta       positive real
%   hmin       positive real
%
%  Post:
%      x       column n-vector with the property that
%              xL = x(1) < ... < x(n) = xR. Each subinterval
%              is either <= hmin in length or has the property
%              that at its midpoint m, |f(m) - L(m)| <= delta
%    		   where L(x) is the line that connects (xR,fR).
%                 
%      y       column n-vector with the property  that
%                       y(i) = f(x(i)).
%           
% 
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
