% Script File: ShowGolden
% Illustrates Golden Section Search

close all
tvals = linspace(900,950);
plot(tvals,DistMercEarth(tvals));
axis([900 950 40 150])
axis('off')
hold on
fname = 'DistMercEarth';
a = 900;
b = 950;
r = (3 - sqrt(5))/2;
c = a + r*(b-a);     fc = feval(fname,c);
d = a + (1-r)*(b-a); fd = feval(fname,d);
y = 78;
step = 0;
plot([900 950],[y y],[a c d b],[y y y y],'o')
text(952,y,num2str(step))
text(950.5,y+8,'Step')
title('Golden Section Search: (a c d b) Trace')
while step<5
   if fc >= fd
      z = c + (1-r)*(b-c); 
      % [a c d b ] <--- [c d z b]
      a = c; 
      c = d; fc = fd;
      d = z; fd = feval(fname,z);
   else
      z = a + r*(d-a); 
      % [a c d b ] <--- [a z c d]
      b = d; 
      d = c; fd = fc;
      c = z; fc = feval(fname,z);
   end
   y = y - 7;
   step = step+1;
   plot([900 950],[y y],[a c d b],[y y y y],'o')
   text(952,y,num2str(step))
   
end
tmin = (c+d)/2;
hold off