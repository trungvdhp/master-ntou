% Problem P3_1_7
%
% Applying pwLAdapt to sqrt

close all
[x,y] = pwLAdapt('sqrt',0,0,1,1,.001,.01);
z = linspace(0,1);
plot(z,sqrt(z),x,y,x,y,'o')
axis([-.1 1.1 -.2 1.2])
hold on
plot(x,zeros(size(x)),'.')
hold off