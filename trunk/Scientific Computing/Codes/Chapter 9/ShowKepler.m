% Script File: ShowKepler
% Applies ODE23 and ODE45 to a system of differential equations
% that define an elliptical orbit.

close all
clc

% A simple call to ode23.

tInitial = 0;
tFinal   =  2*pi;
uInitial = [ .4; 0 ; 0 ; 2];
tSpan = [tInitial tFinal];
[t, u] = ode23('Kepler', tSpan, uInitial);
nSteps = length(t)-1;
plot(u(:,1),u(:,3))
axis('equal')
title('Kepler Problem: ode23 with Default Tolerances')
xlabel(sprintf('Number of Steps = %5d',nSteps))
figure
plot(t(2:length(t)),diff(t))
title('Kepler Problem: ode23 with Default Tolerances')
ylabel('Step Length')
xlabel('t')
figure
subplot(2,2,1), plot(t,u(:,1)), title('x(t)')
subplot(2,2,2), plot(t,u(:,3)), title('y(t)')
subplot(2,2,3), plot(t,u(:,3)), title('x''(t)')
subplot(2,2,4), plot(t,u(:,4)), title('y''(t)')

% A call with specified output times.

tSpan = linspace(tInitial,tFinal,20);
[t, u] = ode23('Kepler', tSpan, uInitial);
xvals = spline(t,u(:,1),linspace(0,2*pi));
yvals = spline(t,u(:,3),linspace(0,2*pi));
figure
plot(xvals,yvals,u(:,1),u(:,3),'o')
axis('equal')
title('Kepler Problem: ode23 with Specified Output Times')
legend('Spline Fit','ode23 Output',0)

% A call with a more stringent tolerances

tSpan = [tInitial tFinal];
options = odeset('AbsTol',.00000001,'RelTol',.000001,'stats','on');
disp(sprintf('\n Stats for ODE23 Call:\n'))
[t, u] = ode23('Kepler', tSpan, uInitial,options);
nSteps = length(t)-1;
figure
plot(u(:,1),u(:,3))
axis('equal')
title('Kepler Problem: ode23 with RelTol = 10^{-6} and AbsTol = 10^{-8}')
xlabel(sprintf('Number of Steps = %5d',nSteps))
figure
plot(t(2:length(t)),diff(t))
title('Kepler Problem: ode23 with RelTol = 10^{-6} and AbsTol = 10^{-8}')
ylabel('Step Length')
xlabel('t')


% Use ODE45 on the same problem.

tSpan = [tInitial tFinal];
options = odeset('AbsTol',.00000001,'RelTol',.000001,'stats','on');
disp(sprintf('\n Stats for ode45 Call:\n'))
[t, u] = ode45('Kepler', tSpan, uInitial,options);
nSteps = length(t)-1;
figure
plot(u(:,1),u(:,3))
axis('equal')
title('Kepler Problem: ode45 with RelTol = 10^{-6} and AbsTol = 10^{-8}')
xlabel(sprintf('Number of Steps = %5d',nSteps))
figure
plot(t(2:length(t)),diff(t))
title('Kepler Problem: ode45 with RelTol = 10^{-6} and AbsTol = 10^{-8}')
ylabel('Step Length')
xlabel('t')
