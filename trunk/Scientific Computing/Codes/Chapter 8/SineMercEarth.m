  function s = SineMercEarth(t)
% s = SineMercEarth(t)
% The sine of the Mercury-Sun-Earth angle at time t

% Mercury location:
xm = -11.9084 +  57.9117*cos(2*pi*t/87.97);
ym =             56.6741*sin(2*pi*t/87.97);

% Earth location:
xe =  -2.4987 + 149.6041*cos(2*pi*t/365.25);
ye =            149.5832*sin(2*pi*t/365.25);

s = (xm.*ye - xe.*ym)./(sqrt(xm.^2 + ym.^2).*sqrt(xe.^2 + ye.^2));