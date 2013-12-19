
% Script File: ShowQNCError
% Examines the quality of the Newton-Cotes error bound.

% clc
disp('Easy case: Integral from 0 to pi/2 of sin(x)')
disp(' '), disp('Take DerBound = 1.'), disp(' ')
disp('  m         QNC(m)	          Error     Error Bound')
disp(' ')
for m=2:11
   numI = QNC('sin',0,pi/2,m);
   exact = 1;
   err = abs(numI-exact);
   errBound = QNCError(0,pi/2,m,1);
   s = sprintf('%20.16f  %10.3e   %10.3e',numI,err,errBound) ;
   disp([ sprintf(' %2.0f  ' ,m) s]) 
end