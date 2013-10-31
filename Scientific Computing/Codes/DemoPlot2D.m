% DemoPlot.m  % http://www.mathworks.com/help/matlab/examples

close all
% 1. 2D plots
% Line Plot for functions
figure(1)
ezplot('x^2+y^2-4')
figure(2)
ezplot('sin(x)/(1+x^2)', [-6, 6])
figure(3)
x = linspace(-5,5,100); 
% % Y = [sin(x)', sin(2*x)', sin(4*x)'];
Y = [sin(x)', sin(2*x)', sin(x)'./(1+x.^2)'];
plot(x,Y)

% Bar Plot of a Bell Shaped Curve
figure(4)
x = -2.9:0.2:2.9;
bar(x,exp(-x.*x));

% Histogram Plot
figure(5)
x = rand(1000,1);
% hist(x)         % default n =10;
hist(x,21)

% Stairstep Plot of a Sine Wave
figure(6)
x = 0:0.25:10;
stairs(x,sin(x));

% Errorbar Plot
figure(7)
x = -2:0.1:2;
y = erf(x);
e = rand(size(x))/10;
errorbar(x,y,e);

% Polar Plot
figure(8)
ezpolar('sin(t)/t', [-6*pi, 6*pi])
figure(9)
t = 0:0.01:2*pi;
polar(t,abs(sin(2*t).*cos(2*t)));

% Stem Plot
figure(10)
x = 0:0.1:4;
y = sin(x.^2).*exp(-x);
stem(x,y)

t1=title(' y = sin(x^2).*exp(-x) ');
set(t1, 'FontSize', 15);
x1=xlabel('X');  set(x1, 'FontSize', 15);
y1=ylabel('Y');  set(y1, 'FontSize', 15);
