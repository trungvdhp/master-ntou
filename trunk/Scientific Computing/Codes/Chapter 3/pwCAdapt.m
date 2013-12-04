  function [x,y,s] = pwCAdapt(fname,fpname,xL,fL,sL,xR,fR,sR,delta,hmin)
% fname is a string that names an available function of the form y = f(u).
% fpname is a string that names a function that is the derivative of f.
% xL is real and fL = f(xL) and sL = f'(xL).
% xR is real and fR = f(xR) and sR = f'(xR).
% delta is a positive real
% hmin is a positive real
%
% x is a column n-vector with the property that
%     xL = x(1) < ... < x(n) = xR. Each subinterval
%     is either <= hmin in length or has the property
%     that at its midpoint m, |f(m) - q(m)| <= delta
%     where q(x) is the cubic hermite interpolant of
%     (xL,fL,sL) and (xR,fR,sR).
%                
% y is a column n-vector with the property  that
%     y(i) = f(x(i)).
%
% s is a column n-vector with the property  that
%     s(i) = f'(x(i)).

if (xR-xL) <= hmin
   % Subinterval is acceptable
   x = [xL;xR];
   y = [fL;fR];
   s = [sL;sR];
else
   mid  = (xL+xR)/2;
   fmid = feval(fname,mid);
  
   % Compute the cubic hermite interpolant and evaluate at the midpoint:
   [alfa,beta,gamma,eta] = HCubic(xL,fL,sL,xR,fR,sR);
   qeval = pwCEval(alfa,beta,gamma,eta,[xL;xR],mid);
   if abs(qeval - fmid) <= delta
      % Subinterval accepted.
      x = [xL;xR];
      y = [fL;fR];
      s = [sL;sR];
   else
      % Produce left and right partitions and synthesize.
     
      smid = feval(fpname,mid);
     
      [xLeft,yLeft,sLeft]    = pwCAdapt(fname,fpname,xL,fL,sL,mid,fmid,smid,delta,hmin);
      [xRight,yRight,sRight] = pwCAdapt(fname,fpname,mid,fmid,smid,xR,fR,sR,delta,hmin);
      x = [ xLeft;xRight(2:length(xRight))];
      y = [ yLeft;yRight(2:length(yRight))];
      s = [ sLeft;sRight(2:length(sRight))];
   end
end
