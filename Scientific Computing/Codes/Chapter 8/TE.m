  function E = TE(theta)
% E = TE(theta)
%
% theta is  a real number in the interval [-pi/2,pi/2]
% E is a  negative multiple of the total edge length of a tetrahedron
% that is inscribed in the unit sphere. One vertex is at the north 
% pole (0,0,1) and the other three form an equilateral triangle in the plane 
% z = sin(theta).  

E = -(sqrt((1-sin(theta))) + sqrt(3/2)*cos(theta));