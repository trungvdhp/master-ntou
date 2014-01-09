% Problem P3_1_9
%
% Examine pwLAdapt with saved f-evals  on [0,1] using the function
%
%   humps(x) = 1/((x-.3)^2 + .01)  +  1/((x-.9)^2+.04)
%

close all
[x,y,xunused,yunused] = pwlAdapt3('humps',0,humps(0),1,humps(1),1,.001,[],[]);
plot(x,y,'.',xunused,yunused,'o');
title('o = the saved f-evaluations')