% polygon_sm    Polygon smoothing in p.39 Sec.1.3.3
% Polygon Smoothing by connecting the side midpoints repeatedly
% NOTE: You have to run "polygon_or.m" first. 

k=0;
xlabel('Click inside window to smooth, outside window to quit.')
[a, b] = ginput(1);  % using mouse-click for graphing input
v = axis;           % assigns to v a 4-vector [x_min, x_max, y_min, y_max]
while (v(1)<=a) & (a<=v(2)) & (v(3)<=b) & (b<=v(4));
   k = k+1;
   x = [(x(1:n)+x(2:n+1))/2; (x(1)+x(2))/2];
   y = [(y(1:n)+y(2:n+1))/2; (y(1)+y(2))/2];
   m = max(abs([x; y]));  x = x/m;  y = y/m;
   figure
   plot(x,y, x,y,'*')
   axis square
   title (sprintf('Number of Smoothings = %1.0f', k))
   xlabel('Click inside window to smooth, outside window to quit.')
   v = axis;
   [a, b] = ginput(1);
end