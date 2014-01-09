% Script File: ShowAdapts
% Illustrates AdaptQNC for a range of tol values and a range of
% underlying NC rules. Uses the humps function for an integrand
% and displays information about the function evaluations.

global FunEvals VecFunEvals
close all
x = linspace(0,1,100);
y = humps(x);
plot(x,y)
u=[];
for tol = [.01  .001  .0001 .00001]
   for m=3:2:9
      figure
      plot(x,y)
      hold on
      title(sprintf('m = %2.0f   tol = %10.6f',m,tol))
      FunEvals = 0;
      VecFunEvals = 0;
      num0 = AdaptQNC('SpecHumps',0,1,m,tol);
      xLabel(sprintf('Scalar Evals = %3.0f    Vector Evals = %3.0f',FunEvals,VecFunEvals))
      hold off  
      u = [u; FunEvals VecFunEvals];
   end
end