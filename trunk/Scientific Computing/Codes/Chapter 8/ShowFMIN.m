% Script File: ShowFmin
% Illustrates the 1-d minimizer fmin.

clc
tol = .000001;
disp('Local minima of the Mercury-Earth separation function.')
disp(sprintf('\ntol = %8.3e\n\n',tol))
disp(' Initial Interval     tmin        f(tmin)    f evals')
disp('----------------------------------------------------')
options = zeros(18,1);
for k=1:8
   L = 100+(k-1)*112;
   R = L+112;
   options(2) = tol;
   [tmin options] = fmin('DistMercEarth',L,R,options);
   minfeval = options(8);
   nfevals = options(10);
   disp(sprintf('     [%3.0f,%3.0f]     %10.5f   %10.5f, %6.0f',L,R,tmin,minfeval,nfevals))
end