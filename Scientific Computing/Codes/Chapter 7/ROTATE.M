  function [c,s] = Rotate(x1,x2)
% [c,s] = Rotate(x1,x2)
% x1 and x2 are real scalars and c and s is a cosine-sine pair so
% -s*x1 + c*x2 = 0.

if x2==0
   c = 1;
   s = 0;
else
   if abs(x2)>=abs(x1)
      cotangent = x1/x2;
      s = 1/sqrt(1+cotangent^2);
      c = s*cotangent;
   else
      tangent = x2/x1;
      c = 1/sqrt(1+tangent^2);
      s = c*tangent;
   end
end