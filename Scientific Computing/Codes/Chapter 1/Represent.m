  function f = Represent(x)
% f = Represent(x)
% Yields a 3-digit mantissa floating point representation of f:
%
%    f.mSignBit   mantissa sign bit (0 if x>=0, 1 otherwise)
%    f.m          mantissa (= f.m(1)/10 + f.m(2)/100 + f.m(3)/1000)
%    f.eSignBit   the exponent sign bit (0 if exponent nonnegative, 1 otherwise)
%    f.e          the exponent (-9<=f.e<=9)
%
% If x is out side of [-.999*10^9,.999*10^9], f.m is set to inf.
% If x is in the range [-.100*10^-9,.100*10^-9] f is the representation of zero
% in which both sign bits are 0, e is zero, and m = [0 0 0].

f = struct('mSignBit',0,'m',[0 0 0],'eSignBit',0,'e',0);

if abs(x)<.100*10^-9 
   % Underflow. Return 0
   return
end

if x>.999*10^9
   % Overflow. Return inf
   f.m = inf;
   return
end
if x<-.999*10^9
   % Overflow. Return -inf
   f.mSignBit = 1;
   f.m = inf;
   return
end
  
% Set the mantissa sign bit
if x>0
   f.mSignBit = 0;
else
   f.mSignBit = 1;
end

% Determine m and e so .1 <= m < 1 and abs(x) = m*10^e 
m = abs(x); e = 0;
while m >= 1,  m = m/10; e = e+1; end
while m < 1/10,m = 10*m; e = e-1; end

% Determine nearest integer to 1000m 
z = round(1000*m);
% Set the mantissa  
f.m(1) = floor(z/100);
f.m(2) = floor((z - f.m(1)*100)/10);
f.m(3) = z - f.m(1)*100 - f.m(2)*10;
% Set the exponent and its sign bit.
if e>=0
   f.eSignBit = 0;
   f.e = e;
else
   f.eSignBit = 1;
   f.e = -e;
end
 