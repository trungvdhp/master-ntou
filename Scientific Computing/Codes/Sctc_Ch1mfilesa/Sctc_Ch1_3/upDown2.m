%% upDown2.m  Sec.1.3  p.32
%% Create the up/down sequence
%% Using the while-loop, if-then-else structures

close all 
upDown            % run (call) the 'upDown' program (script file).
n = length(x);
figure            % create a new figure
plot(x);
title(sprintf('x(1) = %1.0f, n = %1.0f', x(1), n))
figure
plot(-sort(-x));  % 'big-to-little' sort: to list the result from large to small.
title('Sequence values sorted')
I = find(rem(x(1:n-1), 2));
if length(I) > 1,
    figure 
    plot((1:n), zeros(1,n), I+1, x(I+1), I+1, x(I+1),'*'); 
   % plot((1:n), zeros(1,n), I+1, x(I+1),'*'); 
    title('Local Maxima')
end

% Test 'find' function 
% v = [1 0 0 1 0 0 0 1 0 0 0 0 2 0 0 3];
% find(v)
