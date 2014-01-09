% Problem P4_4_4
%
% Using spline to retrieve position from acceleration.

close all
x0 = 0; v0 = -10;
for m = [500 50]
   t = linspace (0, 50, m);
   a = 10 * exp (-t/25) .* sin(t);
   a = a + .01 * randn (size (a));
   Sx = PosVel (a, t, x0, v0);
   t1 = linspace (0, 50, 1000);
   x1 = ppval (Sx, t1);
   x2 = RealX(t1, v0, x0);
   figure
   plot (t1, x1, t1, x2, '--');
   title ('solid:approximation  dash:real');
   xlabel(sprintf ('m = %3.0f : Sx(50) = %8.4f', m, x1(1000)));
end