% Script File: Smooth
% Solicits n, draws an n-gon, and then smooths it.

close all
n = input('Enter the number of edges:');
figure
axis([0 1 0 1])
axis square
hold on
x = zeros(n,1);
y = zeros(n,1);
for k=1:n
   title(sprintf('Click in %2.0f more points.',n-k+1))
   [x(k) y(k)] = ginput(1);
   plot(x(1:k),y(1:k), x(1:k),y(1:k),'*')
end
x0 = x; y0 = y;
x = [x;x(1)];
y = [y;y(1)];
plot(x,y,x,y,'*')
title('The Original Polygon') 
hold off
k=0;
xlabel('Click inside window to smooth, outside window to quit.')  
[a,b] = ginput(1);
v = axis;
while (v(1)<=a) & (a<=v(2)) & (v(3)<=b) & (b<=v(4));
   k = k+1;
   x = [(x(1:n)+x(2:n+1))/2;(x(1)+x(2))/2]; 
   y = [(y(1:n)+y(2:n+1))/2;(y(1)+y(2))/2]; 
   m = max(abs([x;y]));
   x = x/m;
   y = y/m;
   figure
   plot(x,y,x,y,'*')

   axis square
   title(sprintf('Number of Smoothings = %1.0f',k)) 
   xlabel('Click inside window to smooth, outside window to quit.')   
   v = axis;
   [a,b] = ginput(1);
end