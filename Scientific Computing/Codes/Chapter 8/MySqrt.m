  function x = MySqrt(A)
% x = MySqrt(A)
% A is a non-negative real and x is its square root.

if A==0
   x = 0;
else
   TwoPower = 1;
   m = A;
   while m>=1
      m = m/4;
      TwoPower = 2*TwoPower;
   end
   while m < .25
      m = m*4;
      TwoPower = TwoPower/2;
   end	  
   % sqrt(A) = sqrt(m)*TwoPower	  
   x = (1+2*m)/3;
   for k=1:4
      x = (x + (m/x))/2;
   end
   x = x*TwoPower;
end