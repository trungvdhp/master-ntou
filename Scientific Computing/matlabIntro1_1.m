% matlabIntro1_1.m 
% Lecture : Introduction to Matlab software
% 1. How to create vectors 
% 2. How to create a script file (main programs)
% 3. Using "disp" to display the results in a table 
% 4. Using "plot" to plot the graph of functions

% 1. Create a vector
   
 >> x = [10.1 20.2 30.3 40.4]       % Create a row vector
 >> y = [10.1; 20.2; 30.3; 40.4]    % Create a column vector

 %  Create an integer vector with stride = 1
 >> x = 20:25                 % Create a row vector using "colon" notation (:)
 >> x = [20 21 22 23 24 25]         % an equvalent vector
 >> y = x'                          % use "prime" to transpose a vector 
 >> z = [20; 21; 22; 23; 24; 25]    % an equvalent vector
 
 %  Create an integer vector with stride > 1 using the "stride"
 >> x = [20:29]                     % a vector with stride = 1
 >> y = [20:2:29]                   % a vector with stride = 2
 >> z = [20:3:29]                   % a vector with stride = 3
 
 % To get elements or (sub-vectors) from a vector
 >> x(2)
 >> x(5)
 >> x(2:4)
 >> e = x([1,3,5])

 % 2. Using Editor to to create a script file (main program--give a filename):  
 % Plot the function f(x) = sin(2*pi*x) across the interval [0, 1].
%%% Scalar level %%%
n = 21; %
h = 1/(n-1); %
for k=1:n
   x(k) = (k-1)*h;  % Scalar computation
end

%%% Scalar level %%%  

n = 21; %
h = 1/(n-1); %
x = zeros(1, n);   % vector 
for k=1:n
   x(k) = (k-1)*h; % Scalar computation
end

%%% Scalar level %%%
n = 21; %
x = linspace(0,l,n);  %% vector 
y = zeros(l,n);       %% vector 
for k=1:n
   y(k) = sin(x(k));  %% Scalar computation
end

%%%%%%%%% Vector level %%%%%%

% Compute sin(x) for 21 points on [0, 1]
n = 21; %
x = linspace(0,l,n);  %% Vector 
y = sin(2*pi*x);     %% Vector computation

%%%% Vector level with Symmetry %%%%%%

m = 5;  n = 4*m+1; %
x = linspace(0,1,n); %
a = x(1:m+1); %
y =zeros(1,n); %
y(1:m+1) = sin(2*pi*a); %
y(2*m+1:-1:m+2) = y(1:m);
y(2*m+2:n) = -y(2:2*m+1);

%%%%%%%%%%%%%%%%%%%%

%3. Displaying a table: Script File: SineTable
% Prints a short table of sine evaluations.
clc %
n = 21; %
x = linspace(0,1,n); %
y = sin(2*pi*x); %
disp('                     ') %
disp('k    x(k)   sin(x(k))') %
disp('---------------------') %
for k=1:21
   degrees = (k-1)*360/(n-1); %
   disp(sprintf('%2.0f %3.0f %6.3f', k, degrees, y(k)));
end %
disp( '                     '); %
disp('x(k) is given in degrees.')
disp(sprintf ('One Degree = %5.3e Radians',pi/180))

%%%%%%%%%%%%%%%%%%%%

% 4. Using "plot" to plot the graph of functions
n = 21; %
x = linspace(0, 1, n); %
y = sin(2*pi*x); %
plot(x, y) %
title('The Function    y = sin(2*pi*x)') %
xlabel('x   (in radians)')
ylabel('y')

%%%%%%%%%%%%%%%%%%%%

n = 200; %
x = linspace(0, l, n); %
y = sin(2*pi*x); %
plot(x, y)  %
title('The function y = sin(2*pi*x)') %
xlabel('x   (in radians)')  %
ylabel('y')

%%%%%%%%%%%%%%%%%%%%

% Script File: SinePlot
% Displays increasingly smooth plots of sin(2*pi*x).
close all %
for n = [4 8 12 16 20 50 100 200 400]
   x = linspace(0, 1, n);
   y = sin(2*pi*x);
   plot(x,y)
   title(sprintf('Plot of sin(2*pi*x) based upon n = \%3.0f points.', n))
   pause(1)
end

%%%%%%%%%%%%%%%%%%%%
