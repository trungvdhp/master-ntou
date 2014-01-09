  function up = Kepler(t,u)
% up = Kepler(t,u)
% t (time) is a scalar and u is a 4-vector whose components satisfy
%
%            u(1) = x(t)      u(2) = (d/dt)x(t)
%            u(3) = y(t)      u(4) = (d/dt)y(t)
%
% where (x(t),y(t)) are the equations of motion in the 2-body problem.
%
% up is a 4-vector that is the derivative of u at time t.

r3 = (u(1)^2 + u(3)^2)^1.5;
up = [  u(2)     ;...
       -u(1)/r3  ;...
        u(4)     ;...
       -u(3)/r3] ;