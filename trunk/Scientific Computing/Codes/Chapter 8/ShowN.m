% Script File: ShowN
% Newton method test environment.

close all
planet1 = struct('A',15,'P',2,'phi', pi/10); 
planet2 = struct('A',20,'P',3,'phi',-pi/8);

itmax = 10;
tol = 1e-14;

% Plot Orbits

figure
axis equal off
t = linspace(0,2*pi);
Orbit(t,planet1,'-');
hold on
Orbit(t,planet2,'--');

% Enter Starting Points
tc = rand(2,1)*2*pi;
Orbit(tc(1),planet1,'*');
Orbit(tc(2),planet2,'*');
title('Initial Guess')
hold off

% Initializations
Fc =  SepV(tc,planet1,planet2);   r = norm(Fc);
Jc = JSepV(tc,planet1,planet2);   c = cond(Jc);
clc
disp('Iteration        tc(1)                  tc(2)             norm(Fc)   cond(Jc)')
disp('------------------------------------------------------------------------------') 
disp(sprintf('    %2.0f   %20.16f   %20.16f     %8.3e   %8.3e',0,tc(1),tc(2),r,c)) 

% The Newton Iteration

k=0;
while (k<itmax) & (r>tol)
   % Take a step and display
   [tc,Fc,Jc] = NStep(tc,Fc,Jc,planet1,planet2);
   
   k=k+1;
   figure
   Orbit(t,planet1,'-');
   hold on
   Orbit(t,planet2,'--');
   Orbit(tc(1),planet1,'*');
   Orbit(tc(2),planet2,'*');
   hold off 
   r = norm(Fc);
   c = cond(Jc);
   title(sprintf(' Iteration = %2.0f   norm(Fc) = %8.3e',k,r))
   disp(sprintf('    %2.0f   %20.16f   %20.16f     %8.3e   %8.3e',k,tc(1),tc(2),r,c)) 
end
sol = Orbit(tc(1),planet1);
disp(sprintf('\n Intersection = ( %17.16f , %17.16f )',sol.x,sol.y))