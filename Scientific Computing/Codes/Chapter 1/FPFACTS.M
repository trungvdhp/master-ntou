% Script File: FpFacts
% Prints some facts about the underlying floating point system.

close all
clc

% p = smallest positive integer so 1+1/2^p = 1.
x=1; p=0; y=1; z=x+y;
while x~=z  
   y=y/2; 
   p=p+1; 
   z=x+y;
end
disp(sprintf('p = %2.0f  is the smallest positive integer so 1+1/2^p = 1.',p))

% q = smallest positive integer so 1/2^q = 0.
x=1; q=0;
while x>0
   x=x/2; 
   q=q+1;
end;
disp(sprintf('q = %2.0f is the smallest positive integer so 1/2^q = 0.',q))


% r = smallest positive integer so 2^r = inf.
x=1; r=0;
while x~=inf  
   x=2*x; 
   r=r+1; 
end
disp(sprintf('r = %2.0f is the smallest positive integer so 2^r = inf.',r))
   
% The Kahan example. In exact arithmetic f/e = 0/0:

disp(' ')
echo on
h = 1./2.;
x = 2./3. - h;
y = 3./5. - h;
e = (x+x+x) - h;
f = (y+y+y+y+y)-h;
z = f/e;
echo off
disp(sprintf('\nz = %10.5f',z))
