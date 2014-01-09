% Problem P4_1_5
%
% Examines the quality of the Open Newton-Cotes error bound.
clc
disp('Easy case: Integral from 0 to pi/2 of sin(x)')
disp(' ')
disp('Take DerBound = 1.')
disp(' ')
disp('   m         QNCOpen(m)         Error      Error Bound')
disp(' ')
for m=2:7
   numI = QNCopen('sin',0,pi/2,m);
   err = abs(numI-1);
   errBound = NCOpenError(0,pi/2,m,1);
   s = sprintf('%20.16f   %10.3e    %10.3e',numI,err,errBound);
   disp([ sprintf('  %2.0f   ',m) s])
end
