function [a,b,c,d] = CubicSpline1(x,y,derivative,muL,muR)
% x,y are column n-vectors. n >= 4 and x(1) < ... x(n)
% derivative is the order of the spline's derivative that are
%       used in the end conditions (= 1 or 2)
% muL,muR are the values of the specified derivative at the
%       left and right endpoint.
%
% a,b,c,d are column (n-1)-vectors that define the spline.
% On [x(i),x(i+1)], the spline S(z) is specified by the cubic
%  
%  a(i) + b(i)(z-x(i)) + c(i)(z-x(i))^2 + d(i)(z-x(i))^2(z-x(i+1).
%
% Usage:
%   [a,b,c,d] = CubicSpline1(x,y,1,muL,muR)   S'(x(1))  = muL, S'(x(n))  = muR
%   [a,b,c,d] = CubicSpline1(x,y,1)           S'(x(1))  = qL'(x(1)), S'(x(n)) = qR'(x(n))
%   [a,b,c,d] = CubicSpline1(x,y,2,muL,muR)   S''(x(1)) = muL, S''(x(n)) = muR
%   [a,b,c,d] = CubicSpline1(x,y,2)           S''(x(1))  = qL''(x(1)), S''(x(n)) = qR''(x(n))
%   [a,b,c,d] = CubicSpline1(x,y)             S'''(z) continuous at x(2) and x(n-1)
% Here qL = cubic interpolant of (x(i),y(i)), i=1:4 
%      qR = cubic interpolant of (x(i),y(i)), i=n-3:n

if nargin == 3
   % need qL and qR
   n  = length(x);
   cL = InterpN(x(1:4),y(1:4));
   cR = InterpN(x(n:-1:n-3),y(n:-1:n-3));
end
if nargin == 2
   [a,b,c,d] = CubicSpline(x,y);
else
   if derivative == 1
      if nargin == 3
         % Differentiate the Newton interpolants and evaluate.
         muL = cL(2) + cL(3)*(x(1)-x(2))   + cL(4)*((x(1)-x(2))  *(x(1)-x(3)));
         muR = cR(2) + cR(3)*(x(n)-x(n-1)) + cR(4)*((x(n)-x(n-1))*(x(n)-x(n-2)));		  	   
      end
      [a,b,c,d] = CubicSpline(x,y,1,muL,muR); 
   else
      if nargin ==3
         % Differentiate the Newton interpolants twice and evaluate.
         muL = 2*cL(3) + 2*cL(4)*((x(1)-x(2))   + (x(1)-x(3)));

         muR = 2*cR(3) + 2*cR(4)*((x(n)-x(n-1)) + (x(n)-x(n-2)));	   
      end
      [a,b,c,d] = CubicSpline(x,y,2,muL,muR); 	
   end
end