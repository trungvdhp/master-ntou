% Script File: ShowGN 
% Illustrates Gauss-Newton with line search applied to the problem of fitting a
% two-parameter ellipse to some noisy, nearly-elliptical data.

A0 = 5; P0 = 1;  % Parameters of the "true" ellipse.
del = .1;        % Noise factor.
m = 50;          % Number of points.

con_size = 20;        % Size of contour plot
kmax     = 25 ;       % Maximum number of GN steps.
Lmax     = 8;         % Maximum step length factor
tol      = .000001;   % Size of gradient for termination.

% Generate a noisy orbit
theta = linspace(0,2*pi,m)';
c = cos(linspace(0,2*pi,m)');
r = ((2*A0*P0)./(P0*(1-c) + A0*(1+c))).*(1 + del*randn(m,1));
plist = [r c];

% Plot the true orbit and the radius vector samples
close all
figure
axis equal
planet = struct('A',A0,'P',P0,'phi',0);

%Orbit(linspace(0,2*pi,200),planet,'-');
hold on
x = r.*c;
y = r.*sin(theta);
plot(x,y,'o')
hold off  

% Generate Contour Plot
range = linspace(.9*min(r),1.5*max(r),con_size);
Z = zeros(con_size,con_size);
for i=1:con_size
   for j=1:con_size
      f = rho([range(j);range(i)],plist);
      Z(i,j) = (f'*f)/2;
   end
end
figure
C = contour(range,range,Z,20);
title('Enter Contour Labels (Optional). To quit, strike <return>.')
xlabel('A'); ylabel('P'); Clabel(C,'manual')

% Initialize for iteration
title('Enter Starting Point for Gauss-Newton')
zc = zeros(2,1);
[zc(1),zc(2)] = ginput(1); 
Jc = Jrho(zc,plist);
Fc =  rho(zc,plist);
wc = (Fc'*Fc)/2;
k=0;
gnorm = norm(Jc'*Fc);

clc
disp(sprintf('"True A" = %5.3f,  "True P" = %5.3f',A0,P0))
disp(sprintf('Relative Noise = %5.3f,  Samples = %3.0f\n',del,m))
disp('Iteration     wc         A          P          norm(grad)')
disp('----------------------------------------------------------')
disp(sprintf('   %2.0f   %10.4f %10.6f %10.6f       %5.3e ',k,wc,zc(1),zc(2),gnorm))
figure(3)

% Gauss-Newton with linesearch
while (gnorm > tol ) & (k<kmax)
   if k<=2
      [zc,Fc,wc,Jc] = GNStep('rho','Jrho',zc,Fc,wc,Jc,plist,Lmax,0);
   else 
      [zc,Fc,wc,Jc] = GNStep('rho','Jrho',zc,Fc,wc,Jc,plist,Lmax,1);
   end
   k=k+1;
   gnorm = norm(Jc'*Fc);
   disp(sprintf('   %2.0f   %10.4f %10.6f %10.6f       %5.3e ',k,wc,zc(1),zc(2),gnorm))
end
figure(1)
planetModel = struct('A',zc(1),'P',zc(2),'phi',0);
hold on
Orbit(linspace(0,2*pi),planetModel,'-');
hold off