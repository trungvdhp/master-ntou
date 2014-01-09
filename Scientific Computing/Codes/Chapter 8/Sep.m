  function d = Sep(t,planet1,planet2)
% d = Sep(t,planet1,planet2)
%
% t is a 2-vector and planet1 and planet2 are orbit structures.
% t(1) defines a planet1 orbit point, t(2) defines a planet2 orbit point,
% and d is the distance between them.


pLoc1 = Orbit(t(1),planet1);
pLoc2 = Orbit(t(2),planet2);
d = ((pLoc1.x-pLoc2.x)^2 + (pLoc1.y-pLoc2.y)^2)/2;