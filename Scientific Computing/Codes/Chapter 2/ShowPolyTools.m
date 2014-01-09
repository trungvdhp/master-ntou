% Script File: ShowPolyTools

close all

x = linspace(0,4*pi);
y = exp(-.2*x).*sin(x);

x0 = [.5 4  8 12];
y0 = exp(-.2*x0).*sin(x0);

p = polyfit(x0,y0,length(x0)-1);
pvals = polyval(p,x);

plot(x,y,x,pvals,x0,y0,'o')
axis([0 4*pi -1 1])
set(gca,'XTick',[])
set(gca,'YTick',[])
title('Interpolating {\ite}^{-.2{\itx}}sin({\itx}) with a Cubic Polynomial')



