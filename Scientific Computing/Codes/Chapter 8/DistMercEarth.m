  function s = DistMercEarth(t)
% s = DistMercEarth(t)
% The distance between Mercury and Earth at time t.

% Mercury location:
xm = -11.9084 +  57.9117*cos(2*pi*t/87.97);
ym =             56.6741*sin(2*pi*t/87.97);

% Earth location:
xe =  -2.4987 + 149.6041*cos(2*pi*t/365.25);
ye =            149.5832*sin(2*pi*t/365.25);

s = sqrt((xe-xm).^2 + (ye-ym).^2);