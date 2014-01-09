% Problem P4_3_3
%
% Illustrates AdaptQNC for a range of tol values and a range of
% underlying NC rules. Uses the humps function for an integrand
% and displays information about the function evaluations.
%
global FunEvals VecFunEvals
clc
home
for tol = [.01  .001  .0001 .00001]
   for m=3:2:9
      disp(' ')
      disp(sprintf('tol = %8.5f  m = %1.0f',tol,m ))
      FunEvals = 0;
      VecFunEvals = 0;
      num = AdaptQNC('SpecHumps',0,1,m,tol);
      disp(sprintf('   AdaptQNC:   %4.0f  %4.0f',FunEvals,VecFunEvals))
      
      FunEvals = 0;
      VecFunEvals = 0;
      num0 = AdaptQNC1('SpecHumps',0,1,m,tol);
      disp(sprintf('   AdaptQNC1:  %4.0f  %4.0f',FunEvals,VecFunEvals))
   end
end