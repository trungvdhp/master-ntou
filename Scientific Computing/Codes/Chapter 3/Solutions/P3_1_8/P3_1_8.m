% Problem P3_1_8
%
% Examine pwLAdapt with feval max  on [0,1] using the function
%
%       humps(x) = 1/((x-.3)^2 + .01)  +  1/((x-.9)^2+.04)
%
close all

eMax = 50;

for delta = [1 .5 .1 .05 .01]
   [x,y,eTaken] = pwlAdapt2('humps',0,humps(0),1,humps(1),delta,.001,eMax);
   figure
   plot(x,y,'.');
   axis([0 1 0 100])
   title(sprintf('delta = %8.4f      x(%1.0f) = %5.3f',delta,length(x),x(length(x)))) 
   pause
end