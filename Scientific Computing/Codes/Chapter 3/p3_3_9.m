% Problem P3_3_9
% 
% Illustrate a 1-knot natural spline.

y = [-2 ; -10 ; -3];
z = 2;
[a,b,c,d] = SmallSpline(z,y);
xL = linspace(z-1,z)';
zL = xL - z;
CL = ((d(1)*zL + c(1)).*zL+b(1)).*zL+a(1);
xR = linspace(z,z+1)';
zR = xR - z;
CR = ((d(2)*zR + c(2)).*zR+b(2)).*zR+a(2); 
plot([xL;xR],[CL;CR],[z-1;z;z+1],y,'o')