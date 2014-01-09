% Problem P4_1_4 
%
% Examines the quality of the Newton-Cotes error bound

global AVAL
AVAL = input('Integrand = 1/(1+a*x). Enter a = ');
clc 
disp(sprintf('Integral from 0 to 1 of 1/(1+%2.0f*x)',AVAL))
disp(' ')
disp('   m           QNC(m)            Error      Error Bound')
disp(' ')
for m=2:11
   numI = QNC('NCTest',0,1,m);
   err = abs(numI-log(AVAL+1)/AVAL);
   if 2*floor(m/2) == m;
      d = m-1;
   else
      d = m;
   end
   DerBound=1;
   for k=1:d
      DerBound = AVAL*k*DerBound;
   end
   
   errBound = NCerror(0,1,m,DerBound);
   s = sprintf('%20.16f   %10.3e    %10.3e',numI,err,errBound);
   disp([ sprintf('  %2.0f   ',m) s])
end