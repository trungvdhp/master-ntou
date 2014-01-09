% Script File: ShowColor

close all
plot([-1 16 16 -1 -1],[-3 -3 18 18 -3])
axis off
text(0.5,16.5,'Built-In Colors','FontSize',14)
text(9.5,16.5,'A Gradient','FontSize',14)


% The predefined colors.
x = [3 6 6 3 3];
y = [-.5 -.5 .5 .5 -.5];
hold on
fill(x,y,'c')
text(0,0,'cyan','FontSize',12)
fill(x,y+2,'m')
text(0,2,'magenta','FontSize',12)
fill(x,y+4,'y')
text(0,4,'yellow','FontSize',12)
fill(x,y+6,'r')
text(0,6,'red','FontSize',12)
fill(x,y+8,'g')
text(0,8,'green','FontSize',12)
fill(x,y+10,'b')
text(0,10,'blue','FontSize',12)
fill(x,y+12,'k')
text(0,12,'black','FontSize',12)
fill(x,y+14,'w')
text(0,14,'white','FontSize',12)

% Making your own colors.
a = -.5;
b = 14.5;
L = 11;
R = 15;
n = 100;
k=1;
for f = [.4 .6 .7 .8 .85 .90 .95 1] 
   color = [f 1 1];
   text(x(1)+5,y(1)+(2*(k-1)),sprintf('[ %4.2f , %1d , %1d ]',f,1,1),'VerticalAlign','bottom')
   fill(x+9,y+(2*(k-1)),color)
   k = k+1;
end
hold off