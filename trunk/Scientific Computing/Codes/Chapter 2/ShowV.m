% Script File: ShowV 
% Plots 4 random cubic interpolants of sin(x) on [0,2pi].
% Uses the Vandermonde method.

close all
x0 = linspace(0,2*pi,100)';
y0 = sin(x0);
for eg=1:4
   x = 2*pi*sort(rand(4,1));
   y = sin(x);
   a = InterpV(x,y);
   pVal = HornerV(a,x0);
   subplot(2,2,eg)
   plot(x0,y0,x0,pVal,'--',x,y,'*')
   axis([0 2*pi -2 2])
end
