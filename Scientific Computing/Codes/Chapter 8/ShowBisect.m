% Script File: ShowBisect
% Illustrates 6 steps of the method of bisection.

close all
fName   = input('Enter the name of the function (in quotes):');
a0      = input('Enter the left  endpoint of interval of interest:');
b0      = input('Enter the right endpoint of interval of interest:');

% Get initial interval.
x = linspace(a0,b0);
y = feval(fName,x);
figure
plot(x,y,x,0*x);
title('Click in left endpoint a.');
[a,y] = ginput(1);
title('Click in right endpoint b.');
[b,y] = ginput(1);
% Display the initial situation.
x  = linspace(a-.1*(b-a),b+.1*(b-a));
y  = feval(fName,x);
fa = feval(fName,a); 
fb = feval(fName,b);  
plot(x,y,x,0*x,[a b], [fa fb],'*')
xlabel(sprintf('At the start:    a = %10.6f   b = %10.6f',a,b));
for k=1:6
   mid = (a+b)/2;
   fmid = feval(fName,mid);  
   title('Strike any key to continue');  
   pause
   if fa*fmid<=0
      % There is a root in [a,mid].
      b  = mid; 
      fb = fmid;
   else
      % There is a root in [mid,b].
      a  = mid; 
      fa = fmid;
   end   
   x = linspace(a-.1*(b-a),b+.1*(b-a));
   y = feval(fName,x);
   figure
   plot(x,y,x,0*x,[a b], [fa fb],'*')
   xlabel(sprintf('After %1.0f steps:     a = %10.6f      b = %10.6f',k,a,b));
end 