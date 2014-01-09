% Script File: ShowN
% Random cubic interpolants of sin(x) on [0,2pi].
% Uses the Newton representation.

close all
x0 = linspace(0,2*pi,100)';
y0 = sin(x0);
for eg=1:20
   x = 2*pi*sort(rand(4,1));
   y = sin(x);
   c = InterpN(x,y);
   pvals = HornerN(c,x,x0);
   plot(x0,y0,x0,pvals,x,y,'*')
   axis([0 2*pi -2 2])
   pause(1)
end