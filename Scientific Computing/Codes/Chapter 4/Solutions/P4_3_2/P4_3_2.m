% Problem P4_3_2
%
% Using the linearity of the quadrature problem.

tol = .001;
a = 0;
b = 1;

[numG,countG] = quad('humps',a,b,tol/2);
[numH,countH] = quad('sin',a,b,tol/2); 
numDiff = (numG - numH)/2;
numSum  = (numG + numH)/2;
[numGmH,countGmH] = quad('GmH',a,b,tol);
[numGpH,countGpH] = quad('GpH',a,b,tol);
count = countGmH + countGpH;
clc
home
disp('Method 1 computes the integrals of g and h separately and then combines.')
disp('Method 2 computes the integrals of (g-h)/2 and (g+h)/2 directly.')
disp(' ')
disp('g(x) = humps(x) is hard, h(x) = sin(x) = easy.')
disp(' ')
disp('             Idiff    Isum    g-evals  h-evals')
disp('---------------------------------------------------')
disp(sprintf('Method 1: %8.4f  %8.4f    %4.0f    %4.0f',numDiff,numSum,countG,countH))

disp(sprintf('Method 2: %8.4f  %8.4f    %4.0f    %4.0f',numGmH,numGpH,count,count))