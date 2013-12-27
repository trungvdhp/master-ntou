% Script File: GLvsNC
% Compares the m-point Newton-Cotes and Gauss-Legendre rules
% applied to the integral of sin(x) from 0 to pi/2.
 
% clc
disp('Approximating the integral of sin from 0 to pi/2.')
disp(' ')
disp(' m           NC(m)                 GL(m) ')
disp('------------------------------------------------')
for m=2:6
   NC = QNC('sin',0,pi/2,m);
   err1 = abs(NC-1);
   GL = QGL('sin',0,pi/2,m);
   err2 = abs(GL-1);
   disp(sprintf(' %1.0f  %20.16e   %20.16e',m,err1,err2))
end