% Script File: ShowAxes

F = 'Times-Roman'; n = 12;
close all
t = linspace(0,2*pi); c = cos(t); s = sin(t);
plot(c,s)
axis([-1.3 1.3,-1.3 1.3])
axis equal

title('The Circle ({\itx-a})^{2} + ({\ity-b})^{2} = {\itr}^{2}','FontName',F,'FontSize',n)
xlabel('x','FontName',F,'FontSize',n)
ylabel('y','FontName',F,'FontSize',n)
set(gca,'XTick',[-.5 0 .5])
set(gca,'YTick',[-.5 0 .5])
grid on




