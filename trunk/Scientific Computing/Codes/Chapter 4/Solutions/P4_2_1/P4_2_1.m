% Problem P4_2_1
%
% Error bound for composite NC rules applied to the integral
% of sin(x) from 0 to pi/2.

clc 

disp('  m     n=1        n=10        n=100')
disp('--------------------------------------')
for m=2:11
   e1 = CompNCerror(0,pi/2,m,1,1);
   e2 = CompNCerror(0,pi/2,m,1,10);
   e3 = CompNCerror(0,pi/2,m,1,100);
   disp(sprintf('%3.0f  %8.3e  %8.3e  %8.3e',m,e1,e2,e3))
end