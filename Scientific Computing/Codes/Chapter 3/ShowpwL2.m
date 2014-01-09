% Script File: ShowPWL2
% Compares pwLStatic and pwLAdapt on [0,3] using the function
%
%   humps(x) = 1/((x-.3)^2 + .01)  +  1/((x-.9)^2+.04)
%

close all

% Second derivative estimate based on divided differences
z = linspace(0,1,101);
humpvals = humps(z);
M2 = max(abs(diff(humpvals,2)/(.01)^2));
for delta = [1 .5 .1 .05 .01]
   figure
   [x,y] = pwLStatic('humps',M2,0,3,delta);
   subplot(1,2,1)
   plot(x,y,'.');
   title(sprintf('delta = %8.4f Static  n= %2.0f',delta,length(x)))
   [x,y] = pwLAdapt('humps',0,humps(0),3,humps(3),delta,.001);
   subplot(1,2,2)
   plot(x,y,'.');
   title(sprintf('delta = %8.4f  Adapt n= %2.0f',delta,length(x))) 
end