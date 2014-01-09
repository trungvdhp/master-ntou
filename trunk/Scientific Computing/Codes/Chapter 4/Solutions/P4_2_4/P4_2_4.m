% Problem P4_2_4
%
% Illustrate the corrected trapezoid rule.

a = 0;
b = pi/2;
clc 
disp('Integral of sin(x) from 0 to pi/2')
disp(' ')
disp(' n     Trapezoidal     Corrected Trapezoidal')
disp('           Rule                 Rule')
disp('----------------------------------------------')
for n=[1 2 4 8 16 32 64];
   numI = CompQNC('sin',a,b,2,n);
   numI1 = CompCorrTrap('sin','cos',a,b,n);
   disp(sprintf('%3.0f  %15.12f     %15.12f',n,numI,numI1))
end