function Sx = PosVel (a, t, x0, v0);
% t is an m-vector of equally spaced time values with t(1)=0, m>=2.              
% a is an m-vector of accelerations, a(i) = acceleration at time t(i).
% x0, v0 are position and velocity at t=0.
%
% Sx  the pp-representation of a spline that approximates position. 

[Dvs, Lv] = MySplineQ (t, a);
Vs = Dvs + v0;
[Dxs, Lx] = MySplineQ (t, Vs);
Xs = Dxs + x0;
Sx = spline (t, Xs);