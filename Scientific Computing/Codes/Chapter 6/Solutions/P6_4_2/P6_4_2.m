% Problem P6_4_2
%
% Explore computed relative error.

clc 
xexact = [.1234567890123456 ; 1234.567890123456];
for OurEps = logspace(-5,-16,12)
   % Simulate a computed x so norm(x - xexact)/norm(xexact) is about OurEps*cond
   x = xexact + rand(2,1)*10^4*OurEps*norm(xexact);
   disp(' ')
   disp(sprintf('OurEps = %8.3e',OurEps))
   disp(' ')
   disp(sprintf('xexact = %20.16f  %20.16f',xexact))
   disp(sprintf('x      = %20.16f  %20.16f',x))
end