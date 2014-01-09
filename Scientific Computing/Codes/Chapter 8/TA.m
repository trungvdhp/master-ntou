  function A = TA(theta)
% A = TA(theta)
%
% theta is a real number in the interval [-pi/2,pi/2].
% A is a negative multiple of the surface area of a tetrahedron
% that is inscribed in the unit sphere. One vertex is at the north 
% pole (0,0,1) and the other three  form an equilateral triangle in the plane 
% z = sin(theta).  
 
c = cos(theta); 
s = sin(theta); 

A = -c.*(sqrt((3*s-5).*(s-1)) + c);