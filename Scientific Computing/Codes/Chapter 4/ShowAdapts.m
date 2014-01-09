
% Script File: ShowAdapts
% Illustrates AdaptQNC for a range of tol values and a range of 
% underlying NC rules. Uses the humps function for an integrand 
% and displays information about the function evaluations.

global FunEvals VecFunEvals 
close all
tol = [.01  .001  .0001 .00001];
m = [3:2:9];
x = linspace(0,1,100); 
y = humps(x); 
  plot(x,y) 
 % pause 
u=[];
for i = 1:length(tol),
   figure
   for j = 1:length(m),
      subplot(2,2,j)
      plot(x,y)
      hold on
      title(sprintf('m = %2.0f  tol = %10.2e', m(j),tol(i)))
      FunEvals = 0;
      VecFunEvals = 0;
      numO = AdaptQNC('SpecHumps',0,1,m(j),tol(i));
      hold off
      u = [u; FunEvals VecFunEvals];
   end 
end
u