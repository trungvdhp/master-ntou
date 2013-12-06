% Problem P3_3_12
% 
% Illustrate not-a-knot spline interpolants using build-in function spline.
z = linspace(0,2);
x = linspace(0,2,21);
y1 = sin(x);
y2 = exp(x);
y3 = y1.*y2;
y4 = 2*y1 + 3*y2;
sval1 = spline(x,y1,z);
sval2 = spline(x,y2,z);
sval3 = spline(x,y3,z);
sval4 = spline(x,y4,z);
plot(z,sval1,'g',z,sval2,'b',z,sval3,'r',z,sval4,'m',x,y1,'go',x,y2,'bo',x,y3,'ro',x,y4,'mo');
hleg = legend('S_1(x) = sin(x)','S_2(x) = e^x','S_3(x) = sin(x) + e^x','S_4(x) = 2sin(x) + 3e^x');
set(hleg,'Location','Best');

