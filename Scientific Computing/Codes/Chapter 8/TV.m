function V = TV(theta)
% V = TV(theta)
% 
% theta  real in interval [-pi/2,pi/2]
% V is a negative multiple of the volume of a tetrahedron
% that is inscribed in the unit sphere. One vertex is at the north 
% pole (0,0,1) and the other three form an equilateral triangle in the plane 
% z = sin(theta).  
  
s = sin(theta);     
V = (1-s.^2).*(s-1);