function z = float(x, y, op)

% float.m 
% x and y represent a 3-digit floating point number.
% op is one of the strings '+', '-', '*', or '/'.
% z is the 3-digit floating point representation of x op y.

sx = num2str(Convert(x));
sy = num2str(Convert(y));
eval(['(' sx ')'  op  '(' sy ')']);
z = Represent(eval(['(' sx ')'  op  '(' sy ')']));
