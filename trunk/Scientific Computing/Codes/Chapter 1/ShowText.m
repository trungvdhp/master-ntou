% Script File: ShowText

close all
r = 1;
t = pi/6 + linspace(0,2*pi,7);
x = r*cos(t);
y = r*sin(t);
plot(x,y);

axis equal off
HA = 'HorizontalAlignment';
VA = 'VerticalAlignment';
text(x(1),y(1),'\leftarrow {\itP}_{1}',  HA,'left','FontSize',14)
text(x(2),y(2),'\downarrow',             HA,'center',VA,'baseline','FontSize',14)
text(x(2),y(2),'{  \itP}_{2}',           HA,'left',VA,'bottom','FontSize',14)
text(x(3),y(3),'{\itP}_{3} \rightarrow', HA,'right','FontSize',14)
text(x(4),y(4),'{\itP}_{4} \rightarrow', HA,'right','FontSize',14)
text(x(5),y(5),'\uparrow',               HA,'center',VA,'top','FontSize',14)
text(x(5),y(5),'{\itP}_{5}  ',           HA,'right',VA,'top','FontSize',14)
text(x(6),y(6),'\leftarrow {\itP}_{6}',  HA,'left','FontSize',14)

text(0,1.4*r,'A Labeled Hexagon^{1}',HA,'center','FontSize',14)
text(0,-1.4*r,'^{1} A hexagon has six sides.',HA,'center','FontSize',10)