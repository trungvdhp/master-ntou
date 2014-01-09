  function pLoc = Orbit(t,planet,lineStyle)
% pLoc = Orbit(t,planet,lineStyle)
%
% t is a row vector and for k=1:length(t), pLoc.x(k) = x(t(k)) and 
% pLoc.y(k) = y(t(k)) where
% 
%  x(tau)    cos(phi) sin(phi)   (planet.A-planet.P)/2 + ((planet.A+planet.P)/2)cos(tau)
%         =                    *
%  y(tau)   -sin(phi) cos(phi)             sqrt(planet.A*planet.P)sin(tau)
%
% If nargin==3 then the points are plotted with line style defined by the
% string lineStyle.

c = cos(t); s = sin(t);
x0 = ((planet.P-planet.A)/2) + ((planet.P+planet.A)/2)*c;
y0 = sqrt(planet.A*planet.P)*s;
cphi = cos(planet.phi); sphi = sin(planet.phi);
pLoc = struct('x',cphi*x0 + sphi*y0,'y',-sphi*x0 + cphi*y0);
if nargin==3
   plot(pLoc.x,pLoc.y,lineStyle)
end
