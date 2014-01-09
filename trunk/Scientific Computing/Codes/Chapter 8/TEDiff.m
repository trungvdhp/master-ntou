  function E = TEDiff(theta)
% E = TEDiff(theta)
% 
% theta is a real number in the interval [-pi/2,pi/2]
%
% Let T be the tetrahedron with one vertex at the north pole (0.0,1) and the other 
% three forming an equilateral triangle in the plane  z = sin(theta). E is difference
% between a pole to base edge length and the length of a base edge. 
  
E = sqrt((1-sin(theta))) - sqrt(3/2)*cos(theta);