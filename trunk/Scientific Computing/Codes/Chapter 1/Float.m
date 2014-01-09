  function z = Float(x,y,op)
% z = Float(x,y,op)
% x and y are representations of a 3-digit floating point number. (For details
% type help represent.
% op is one of the strings '+', '-', '*', or '/'.
% z is the 3-digit floating point representation of x op y.

sx = num2str(convert(x)); 
sy = num2str(convert(y)); 
z = represent(eval(['(' sx ')' op '(' sy ')' ]));