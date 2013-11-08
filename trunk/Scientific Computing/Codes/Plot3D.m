close all
z=peaks(36);
mesh(z);
colormap(hsv)
surf(z);
colormap(z)
{Error using <a href="matlab:helpUtils.errorDocCallback('colormap', 'D:\MATLAB\R2013a\toolbox\matlab\graph3d\colormap.m', 96)" style="font-weight:bold">colormap</a> (<a href="matlab: opentoline('D:\MATLAB\R2013a\toolbox\matlab\graph3d\colormap.m',96,0)">line 96</a>)
Colormap must have 3 columns: [R,G,B].
} 
colormap(jet)
surfl(z);
shading interp;
colormap(pink);
contour(z,20);
colormap(hsv)
x=-2:.2:2;
y=-1:.2:1;
[xx,yy]=meshgrid(x,y)

xx =

  Columns 1 through 4

   -2.0000   -1.8000   -1.6000   -1.4000
   -2.0000   -1.8000   -1.6000   -1.4000
   -2.0000   -1.8000   -1.6000   -1.4000
   -2.0000   -1.8000   -1.6000   -1.4000
   -2.0000   -1.8000   -1.6000   -1.4000
   -2.0000   -1.8000   -1.6000   -1.4000
   -2.0000   -1.8000   -1.6000   -1.4000
   -2.0000   -1.8000   -1.6000   -1.4000
   -2.0000   -1.8000   -1.6000   -1.4000
   -2.0000   -1.8000   -1.6000   -1.4000
   -2.0000   -1.8000   -1.6000   -1.4000

  Columns 5 through 8

   -1.2000   -1.0000   -0.8000   -0.6000
   -1.2000   -1.0000   -0.8000   -0.6000
   -1.2000   -1.0000   -0.8000   -0.6000
   -1.2000   -1.0000   -0.8000   -0.6000
   -1.2000   -1.0000   -0.8000   -0.6000
   -1.2000   -1.0000   -0.8000   -0.6000
   -1.2000   -1.0000   -0.8000   -0.6000
   -1.2000   -1.0000   -0.8000   -0.6000
   -1.2000   -1.0000   -0.8000   -0.6000
   -1.2000   -1.0000   -0.8000   -0.6000
   -1.2000   -1.0000   -0.8000   -0.6000

  Columns 9 through 12

   -0.4000   -0.2000         0    0.2000
   -0.4000   -0.2000         0    0.2000
   -0.4000   -0.2000         0    0.2000
   -0.4000   -0.2000         0    0.2000
   -0.4000   -0.2000         0    0.2000
   -0.4000   -0.2000         0    0.2000
   -0.4000   -0.2000         0    0.2000
   -0.4000   -0.2000         0    0.2000
   -0.4000   -0.2000         0    0.2000
   -0.4000   -0.2000         0    0.2000
   -0.4000   -0.2000         0    0.2000

  Columns 13 through 16

    0.4000    0.6000    0.8000    1.0000
    0.4000    0.6000    0.8000    1.0000
    0.4000    0.6000    0.8000    1.0000
    0.4000    0.6000    0.8000    1.0000
    0.4000    0.6000    0.8000    1.0000
    0.4000    0.6000    0.8000    1.0000
    0.4000    0.6000    0.8000    1.0000
    0.4000    0.6000    0.8000    1.0000
    0.4000    0.6000    0.8000    1.0000
    0.4000    0.6000    0.8000    1.0000
    0.4000    0.6000    0.8000    1.0000

  Columns 17 through 20

    1.2000    1.4000    1.6000    1.8000
    1.2000    1.4000    1.6000    1.8000
    1.2000    1.4000    1.6000    1.8000
    1.2000    1.4000    1.6000    1.8000
    1.2000    1.4000    1.6000    1.8000
    1.2000    1.4000    1.6000    1.8000
    1.2000    1.4000    1.6000    1.8000
    1.2000    1.4000    1.6000    1.8000
    1.2000    1.4000    1.6000    1.8000
    1.2000    1.4000    1.6000    1.8000
    1.2000    1.4000    1.6000    1.8000

  Column 21

    2.0000
    2.0000
    2.0000
    2.0000
    2.0000
    2.0000
    2.0000
    2.0000
    2.0000
    2.0000
    2.0000


yy =

  Columns 1 through 4

   -1.0000   -1.0000   -1.0000   -1.0000
   -0.8000   -0.8000   -0.8000   -0.8000
   -0.6000   -0.6000   -0.6000   -0.6000
   -0.4000   -0.4000   -0.4000   -0.4000
   -0.2000   -0.2000   -0.2000   -0.2000
         0         0         0         0
    0.2000    0.2000    0.2000    0.2000
    0.4000    0.4000    0.4000    0.4000
    0.6000    0.6000    0.6000    0.6000
    0.8000    0.8000    0.8000    0.8000
    1.0000    1.0000    1.0000    1.0000

  Columns 5 through 8

   -1.0000   -1.0000   -1.0000   -1.0000
   -0.8000   -0.8000   -0.8000   -0.8000
   -0.6000   -0.6000   -0.6000   -0.6000
   -0.4000   -0.4000   -0.4000   -0.4000
   -0.2000   -0.2000   -0.2000   -0.2000
         0         0         0         0
    0.2000    0.2000    0.2000    0.2000
    0.4000    0.4000    0.4000    0.4000
    0.6000    0.6000    0.6000    0.6000
    0.8000    0.8000    0.8000    0.8000
    1.0000    1.0000    1.0000    1.0000

  Columns 9 through 12

   -1.0000   -1.0000   -1.0000   -1.0000
   -0.8000   -0.8000   -0.8000   -0.8000
   -0.6000   -0.6000   -0.6000   -0.6000
   -0.4000   -0.4000   -0.4000   -0.4000
   -0.2000   -0.2000   -0.2000   -0.2000
         0         0         0         0
    0.2000    0.2000    0.2000    0.2000
    0.4000    0.4000    0.4000    0.4000
    0.6000    0.6000    0.6000    0.6000
    0.8000    0.8000    0.8000    0.8000
    1.0000    1.0000    1.0000    1.0000

  Columns 13 through 16

   -1.0000   -1.0000   -1.0000   -1.0000
   -0.8000   -0.8000   -0.8000   -0.8000
   -0.6000   -0.6000   -0.6000   -0.6000
   -0.4000   -0.4000   -0.4000   -0.4000
   -0.2000   -0.2000   -0.2000   -0.2000
         0         0         0         0
    0.2000    0.2000    0.2000    0.2000
    0.4000    0.4000    0.4000    0.4000
    0.6000    0.6000    0.6000    0.6000
    0.8000    0.8000    0.8000    0.8000
    1.0000    1.0000    1.0000    1.0000

  Columns 17 through 20

   -1.0000   -1.0000   -1.0000   -1.0000
   -0.8000   -0.8000   -0.8000   -0.8000
   -0.6000   -0.6000   -0.6000   -0.6000
   -0.4000   -0.4000   -0.4000   -0.4000
   -0.2000   -0.2000   -0.2000   -0.2000
         0         0         0         0
    0.2000    0.2000    0.2000    0.2000
    0.4000    0.4000    0.4000    0.4000
    0.6000    0.6000    0.6000    0.6000
    0.8000    0.8000    0.8000    0.8000
    1.0000    1.0000    1.0000    1.0000

  Column 21

   -1.0000
   -0.8000
   -0.6000
   -0.4000
   -0.2000
         0
    0.2000
    0.4000
    0.6000
    0.8000
    1.0000

zz=xx.*exp(-xx.^2-yy.^);
 zz=xx.*exp(-xx.^2-yy.^);
                       |
{Error: Unbalanced or unexpected
parenthesis or bracket.
} 
zz=xx.*exp(-xx.^2-yy.^2);
[px,py]=gradient(zz,.2,.2);
quiver(x,y,px,py,2);
quiver(x,y,px,py,4);
quiver(x,y,px,py,0);
quiver(x,y,px,py,1);
quiver(x,y,px,py,1);
quiver(x,y,px,py,10);
quiver(x,y,px,py,100);
quiver(x,y,px,py,1000);
diary off
