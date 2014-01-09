  function x = Convert(f)
% x = Convert(f)
% f is a is a representation of a 3-digit floating point number. (For details
% type help represent. x is the value of v.

% Overflow situations
if (f.m == inf) & (f.mSignBit==0)
   x = inf;
   return
end
if (f.m == inf) & (f.mSignBit==1)
   x = -inf;
   return
end

% Mantissa value
mValue = (100*f.m(1) + 10*f.m(2) + f.m(3))/1000;
if f.mSignBit==1
   mValue = -mValue;
end

% Exponent value
eValue = f.e;
if f.eSignBit==1
   eValue = -eValue;
end

x = mValue * 10^eValue;
