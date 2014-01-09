% Script File: FindConj
% Estimates spacing between Mercury-Earth Conjunctions

clc
GapEst = input('Spacing Estimate = ');
disp(sprintf('Next ten conjunctions, Spacing Estimate = %8.3f',GapEst))
disp(' ')
t = zeros(11,1);
disp('Conjunction    Time       Spacing')
disp('-----------------------------------')
for k=1:10;
   t(k+1) = fzero('SineMercEarth',k*GapEst);
   disp(sprintf('    %2.0f       %8.3f    %8.3f',k,t(k+1),t(k+1)-t(k)))
end