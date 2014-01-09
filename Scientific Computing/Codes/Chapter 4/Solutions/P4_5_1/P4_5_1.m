% Problem P4_5_1
%
% Scaling tol when adding integrals

a = 0;
b = 2;
tol = .0001;
m=5;
exact = quad8('humps',a,b,tol,.0001);
clc
home
disp('Error bounds are additive with AdaptQNC. Thus, if')
disp('an integral is expressed as the sum of n integrals and')
disp('each of those is computed to within tol, then the best we can')
disp('say about the sum is that it is correct to within n*tol.')
disp(' ')
disp('Illustrate with integral of humps from 0 to 2, tol = .0001 and')
disp('using AdaptQNC with m = 5. Total integral broken into n equal-length')
disp('subintegrals.')
disp(' ')
disp(' Subintegrals       Error')
disp('------------------------------------')
for n=2:10
   numI = 0;
   x = linspace(a,b,n);
   for i=1:n-1
      d =  AdaptQNC('humps',x(i),x(i+1),m,tol);
      numI = numI +d;
   end
   disp(sprintf('  %2.0f               %15.9e',n-1,abs(numI-exact)))
end