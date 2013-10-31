% a dart_target 

circle(1)      % call circle.m to plot a unit circle
hold on
n = 20;
t = linspace(-1,1,n);

x = [t, ones(1,n), -t, -ones(1,n)];
y = [-ones(1,n), t, ones(1,n), -t];
plot(x, y)      % plot a square with side length 2
tf = title('The Target of Throwing Dart Game');
set(tf, 'FontSize', 15);
axis([-1.5 1.5 -1.5 1.5]);
axis equal
hold off