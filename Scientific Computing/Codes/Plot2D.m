close all
figure(1)
ezplot('x^3+y^3-1')
ezplot('x^2-y^2')
ezplot('x^2-y+1')
ezplot('x^2+y^2-4')
ezplot('x^2-y^2-4')
figure(2)
ezplot('sin(x)/(1+x^2)', [-6, 6])
ezplot('2*cos(3.22*pi*x)')
figure(3)
x = linspace(-5,5,100); 
% % Y = [sin(x)', sin(2*x)', sin(4*x)'];
Y = [sin(x)', sin(2*x)', sin(x)'./(1+x.^2)'];
plot(x,Y)
Y=[tan(x)', cot(x)', tan(x)'/cot(x)'];
plot(x,Y)
ymax = 10;
axis([-pi/2 9*pi/2 -ymax ymax])
Y=[tan(x)', cot(x)'];
plot(x,Y)
axis([-pi/2 9*pi/2 -ymax ymax])
ymax = 5;
axis([-pi/2 9*pi/2 -ymax ymax])
axis([-pi/2 5*pi/2 -ymax ymax])
axis([-pi/2 4*pi/2 -ymax ymax])
axis([-pi/2 3*pi/2 -ymax ymax])
axis([-5*pi 5*pi -ymax ymax])
axis([-5*pi/2 5*pi/2 -ymax ymax])
axis([-3*pi/2 5*pi/2 -ymax ymax])
axis([-3*pi/2 3*pi/2 -ymax ymax])
figure(4)
x = -5:0.1:5;
bar(x,cos(-x.*x));
stairs(x,cos(x));
figure(4)
x = -2.9:0.2:2.9;
bar(x,exp(-x.*x));
figure(5)
x = rand(1000,1);
hist(x,21)
hist(x,100)
figure(7)
x = -2:0.1:2;
y = erf(x);
e = rand(size(x))/10;
errorbar(x,y,e);
figure(8)
ezpolar('sin(t)/t', [-6*pi, 6*pi])
figure(9)
t = 0:0.01:2*pi;
polar(t,abs(sin(2*t).*cos(2*t)));
figure(8)
ezpolar('sin(t)/t', [-6*pi, 6*pi])
figure(9)
t = 0:0.01:2*pi;
polar(t,abs(sin(2*t).*cos(2*t)));
figure(8)
ezpolar('sin(2*t)/t^2', [-6*pi, 6*pi])
ezpolar('sin(2*t)/t', [-6*pi, 6*pi])
ezpolar('3.18*cos(t)+sin(3.18*t)', [-6*pi, 6*pi])
ezpolar('3.18*cos(t)+sin(3.18*t)', [-6*pi, 6*pi])
polar(t, 3.18.*cos(t).*cos(3.18*t));
polar(t, 3.18*cos(t).*cos(3.18*t));
x = 0:0.1:4;
y = sin(x.^2).*exp(-x);
stem(x,y)
y = 1./cos(2*x).^2;
stem(x,y)
y = sin(x)./cos(2*x).^2;
stem(x,y)
y = cos(2*x).^2;
stem(x,y)
diary off
