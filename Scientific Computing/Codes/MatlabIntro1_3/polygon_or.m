% polygon_or.m  Polygon orginal in p.39 Sec.1.3.3
% to plot a polygon with clicking the vertices. 

n = input('Enter the number of edges: ');
figure
axis([0 1 0 1])
axis square
hold on
x = zeros(n,1);
y = zeros(n,1);
for k = 1:n
   [x(k), y(k)] = ginput(1);
   plot(x(1:k), y(1:k), x(1:k), y(1:k),'*')
   title(sprintf('Click in %2.0f more points.', n-k+1))
end
x = [x; x(1)];
y = [y; y(1)];
plot(x, y, x, y, '*')
title('The Original Polygon')
hold off

% xnew = [(x(1:n)+x(2:n+1)) / 2; (x(1)+x(2)) / 2];
% ynew = [(y(1:n)+y(2:n+1)) / 2; (y(1)+y(2)) / 2];
% plot(xnew, ynew)