function [x,y,s] = pwCAdapt(fname,fpname,L,fL,DfL,R,fR,DfR,delta,hmin)
% [x,y,s] = pwCAdapt(fname,fpname,L,fL,DfL,R,fR,DfR,delta,hmin)
% Adaptively determines interpolation points for a piecewise cubic hermite
% approximation of a specified function.
%
% fname is a string that specifies a function of the form y = f(u).
% fpname is a string that names a function that is the derivative of f.
% L is real and fL = f(L) and DfL = f'(L).
% R is real and fR = f(R) and DfR = f'(R).
% delta is a positive real
% hmin is a positive real
%
% x is a column n-vector with the property that
%     L = x(1) < ... < x(n) = R
% each subinterval is either <= hmin in length or
% has the property that at its midpoint m, |f(m) - q(m)| <= delta,
% where q(x) is the cubic hermite interpolant of (L,fL,DfL) and (R,fR,DfR).
%
% y is a column n-vector with the property  that y(i) = f(x(i)).
%
% s is a column n-vector with the property  that s(i) = f'(x(i)).

if (R-L) <= hmin
   % Subinterval is acceptable
   x = [L;R];
   y = [fL;fR];
   s = [DfL;DfR];
else
   mid  = (L+R)/2;
   fmid = feval(fname,mid);
   % Compute the cubic hermite interpolant and evaluate at the midpoint:
   % function HCubic in page 117
   [alfa,beta,gamma,eta] = HCubic(L,fL,DfL,R,fR,DfR);
   % function pwCEval in page 119 and 120
   qeval = pwCEval(alfa,beta,gamma,eta,[L;R],mid);
   if abs(qeval - fmid) <= delta
      % Subinterval acceptable
      x = [L;R];
      y = [fL;fR];
      s = [DfL;DfR];
   else
      % Produce left and right partitions, then synthesize without
      % redundancy.
      smid = feval(fpname,mid);
      [xLeft,yLeft,sLeft]    = pwCAdapt(fname,fpname,L,fL,DfL,mid,fmid,smid,delta,hmin);
      [xRight,yRight,sRight] = pwCAdapt(fname,fpname,mid,fmid,smid,R,fR,DfR,delta,hmin);
      x = [ xLeft;xRight(2:length(xRight))];
      y = [ yLeft;yRight(2:length(yRight))];
      s = [ sLeft;sRight(2:length(sRight))];
   end
end
