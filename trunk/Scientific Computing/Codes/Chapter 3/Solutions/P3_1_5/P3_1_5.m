% Problem P3_1_5
%
% Examine the effect of second derivative on pwLAdapt
% f(x) = exp(-x)sin(kx)
% f'(x) = -exp(-x)sin(kx) + 10exp(-x)cos(kx)
% f''(x) = -2exp(-x)cos(x) 

clc 
disp('f(x) = exp(-.3x)sin(6.1x)')
disp('Second derivative bound on [a,b] is 40exp(-.3a) assuming a>=0.')
delta = .0001;
disp(' ')
disp(' [x,y] = pwLAdapt(''MyF315'',a,fa,b,fb,.0001,0)')
disp(' ')
disp('    a        b          bound    min(diff(x))   length(x)')
disp('------------------------------------------------------------')
for k=0:8
   a = k*pi; fa = feval('MyF315',a);
   b = a+pi; fb = feval('MyF315',b);
   [x,y] = pwlAdapt('MyF315',a,fa,b,fb,delta,0);
   n = length(x);
   bound = 40*exp(-.3*a);
   xdiffmin = min(diff(x));
   disp(sprintf(' %6.2f   % 6.2f      %9.6f    %8.4f     %5.0f',a,b,bound,xdiffmin,n))  
end