%% upDown.m  Sec.1.3  p.31

% function x = upDown()
%% Create the up/down sequence
%% Using the while-loop, if-then-else structures

% x = zeros(500, 1);
x(1) = input('Enter initial positive integer: ');
k = 1;
while ((x(k) ~= 1) & (k < 500))
   if rem(x(k), 2) == 0
      x(k+1) = x(k)/2;
   else
      x(k+1) = 3*x(k)+1;
   end
   k = k+1;
end
x = x(1:k);
disp(sprintf('%-5.0f', x));