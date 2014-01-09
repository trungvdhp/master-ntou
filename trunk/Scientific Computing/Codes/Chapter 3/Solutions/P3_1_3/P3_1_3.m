% Problem P3_1_3
%
% Applying pwLAdapt on sin(x) on [0,2pi].

[x,y] = pwLAdapt('sin',0,0,2*pi,0,.01,.01);
z = linspace(0,2*pi);
plot(z,sin(z),x,y,x,y,'o')