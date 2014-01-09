% Problem P4_1_1
%
% Error in the Corrected trapezoidal rule.
% Apply to the function f(x) = x^4.

clc
numI = CorrTrap('MyF411','DMyF411',0,1);
exact = 1/5;
err = abs(numI - exact);

% Use the equation 
%
%           error = c * (b-a)^5 * 24  
%
% to solve for c:
c = err/24;

disp(sprintf('Computed constant = %18.15f',c))
disp('  Actual constant = 1/720')