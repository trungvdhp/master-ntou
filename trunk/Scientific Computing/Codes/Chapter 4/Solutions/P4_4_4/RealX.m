function X = RealX (t, v0, x0);
% Find the exact solution of the positions
expt = exp (-t/25);
IcIs = 625/626*(20/25-20/25*expt.*cos(t)+(10-10/625)*expt.*sin(t));
X = x0 + v0*t + 625/626*10*t - 625/626*IcIs;