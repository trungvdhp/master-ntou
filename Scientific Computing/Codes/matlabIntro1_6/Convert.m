
function x = Convert(f)

% Convert.m converts a 3-digit floating point number (represented by 'f')
% into 'x' the value of v.

% Overflow situations
if (f.m == Inf) & (f.mSignBit==0), x =  Inf; return, end
if (f.m == Inf) & (f.mSignBit==1), x = -Inf; return, end

% Mantissa value 
mValue = (100*f.m(1) + 10*f.m(2) + f.m(3))/1000;
if f.mSignBit==1, mValue = -mValue;  end

% Exponent value
eValue = f.e; 
if f.eSignBit==1, eValue = -eValue; end

x = mValue * 10^eValue;