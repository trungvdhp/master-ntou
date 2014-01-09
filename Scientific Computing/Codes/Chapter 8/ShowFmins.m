% Script Files: ShowFmins
% Illustrates the multidimensional minimizer fmins.

close all
planet1 = struct('A',10,'P',2,'phi', pi/8); 
planet2 = struct('A', 4,'P',1,'phi',-pi/7);
% Plot the orbots
tVals = linspace(0,2*pi);
Orbit(tVals,planet1,'-');
hold on
Orbit(tVals,planet2,'--');

% Call fmins
trace = 0;
steptol = .000001;
ftol = .000001;
options = [trace steptol ftol];
t0=[5;2];
[t,options] = Fmins('Sep',t0,options,[],planet1,planet2);

% Show Solution
pt1 = Orbit(t(1),planet1,'o');
pt2 = Orbit(t(2),planet2,'o');
plot([pt1.x pt2.x],[pt1.y pt2.y])
hold off
its = options(10);
gval = norm(gSep(t,planet1,planet2));
title(sprintf('t_{*} = ( %8.6f , %8.6f ), Steps = %3.0f,  norm(gradient) = %5.3e',t,its,gval))
axis off equal