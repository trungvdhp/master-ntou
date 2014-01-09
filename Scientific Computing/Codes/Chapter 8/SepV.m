  function z = SepV(t,planet1,planet2)
% z = SepV(t,planet1,planet2)
% The vector from the t(1) point on the planet1 orbit
% to the t(2) point on the planet2 orbit.

pt1 = Orbit(t(1),planet1);
pt2 = Orbit(t(2),planet2);
z = [pt2.x-pt1.x;pt2.y-pt1.y];
