% Script File: FindTet
% Applies fmin to three different objective functions.

tol = 10e-16;

reps = 20;
disp(' ')
disp('Objective Function     Time           Theta')
disp('----------------------------------------------------')

t0=clock;
for k=1:reps
   OptLat1 = fmin('TA',-pi/2,pi/2,[0 tol]);
end
t1 = etime(clock,t0);
disp(sprintf('      Area       %10.3f    %20.16f',1,OptLat1))
t0 = clock;
for k=1:reps
   OptLat2 = fmin('TV',-pi/2,pi/2,[0 tol]);
end
t2 = etime(clock,t0);
disp(sprintf('    Volume       %10.3f    %20.16f',t2/t1,OptLat2))
t0 = clock;
for k=1:reps
   OptLat3 = fmin('TE',-pi/2,pi/2,[0 tol]);
end
t3 = etime(clock,t0);
disp(sprintf('      Edge       %10.3f    %20.16f',t3/t1,OptLat3))
OptLat0 = fzero('TEdiff',-.3,eps);
disp(sprintf('\n                 fzero method: %20.16f',OptLat0))
disp(sprintf('                        Exact: %20.16f',asin(-1/3)))