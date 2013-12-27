  
function y = SpecHumps(x)

% y = SpecHumps(x)
%   
% Yields humps(x) where x is an n-vector.
% FunEvals is an initialized global scalar that is increased by length(x).
% VecFunEvals is an initialized global scalar that is increased by 1.

global FunEvals VecFunEvals;
y = 1 ./ ((x-.3).^2 + .01) + 1 ./ ((x-.9).^2 + .04) - 6;
hold on
plot(x, y,'*r')
hold off
FunEvals = FunEvals + length(x);
VecFunEvals = VecFunEvals + 1;