% Script File: SineTable
% Prints a short table of sine evaluations by degree.
clc
n = 21;
x = linspace(0,1,n);
y = sin(2*pi*x);
disp(' ')
disp('  k    x(k)   sin(x(k))')
disp('-----------------------')
for k=1:21
   degrees = (k-1)*360/(n-1);
   disp(sprintf(' %2.0d  %3.0f    %10.6f    ' ,k, degrees, y(k)));
end
disp( '                        ');
disp('x(k) is given in degrees.')
disp(sprintf ('One Degree = %5.4e Radians',pi/180))
