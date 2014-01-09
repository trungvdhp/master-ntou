% Problem P3.1.4
%
% Looks at pwLAdapt on [0,1] using the function
%
%   humps(x) = 1/((x-.3)^2 + .01)  +  1/((x-.9)^2+.04)
%
% with delta = 0.

close all
delta = 0;
for d = [128 129];
   hmin = 1/d;
   figure
   [x,y] = pwlAdapt('humps',0,humps(0),1,humps(1),delta,hmin);
   plot(x,y,'.');
   title(sprintf('hmin = 1/%3.0f  Adapt n = %2.0f',d,length(x)))
end