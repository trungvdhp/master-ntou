% Problem P4_4_1
%
% Gauss Quadrature error bound applied to the integral of
% exp(cx) from a to b. (c>0)
% Em = ((b-a)^(2m+1))/(2m+1) * (m!)^4/((2m)!)^3
a = 0;

c = 1;
Mvals = zeros(1,3);

clc 
disp(' b   tol=10^-3   tol=10^-6   tol=10^-9 ')
disp('-----------------------------------------')
for b = 1:10
   for j = 1:3
      tol = .001^j;
      m = 1;
      E = (b-a)^3*b*exp(c*b)/24;  
      while E > tol
         m = m+1;
         E = E*(b-a)^2 * ((2*m-1)/(2*m+1)) * m * (m/((2*m-1)*2*m))^3;
      end
      Mvals(j) = m;
   end
   disp(sprintf('%2.0f     %2.0f          %2.0f          %2.0f',b,Mvals))
end