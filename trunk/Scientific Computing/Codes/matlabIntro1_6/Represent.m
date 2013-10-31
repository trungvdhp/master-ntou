
function f = Represent(x)

% Represent.m yields a 3-digit (base 10) mantissa floating point representation of f:

% f.mSignBit   mantissa sign bit (0 if x>= 0, 1 if x < 0)
% f.m          mantissa (=f.m(1)/10 + f.m(2)/100 + f.m(2)/1000)
% f.eSignBit   the exponent sign bit (0 if e >= 0, 1 if e < 0)
% f.e          the exponent (-9 <= f.e <= 9)
% 
% If x is outside of [-.999*10^9, .999*10^9] f.m is set to Inf.
% If x is in the range [-.100*10^-9, .100*10^-9] f is the representation of zero.
% in which both sign bits are 0, e is zero, and m = [0 0 0].


if x >= 0,  xSign = 0;  % Check x is positive or nagative.
else  xSign = 1;
end
mantissa = zeros(1, 3);
absx = abs(x);
if absx <= 1, 
    expon = 0;
else
expon = ceil(log10(absx));      % compute the exponent.
end
if expon >= 0,  
  eSign = 0;
  if expon > 9, exponent = ('overflow');
      if xSign == 0,  mantissa = ('Inf'); 
      else mantissa = ('-Inf');  
      end
  else
      % compute the mantissa.
      mant = absx*10^(3-expon);
      manti = fix(mant);
      if (mant - manti) >= 0.5,
         manti = manti + 1;
      end
       exponent = abs(expon);
       if manti == 1000, mantissa = [1 0 0];  exponent = 1;
       else
          mantissa(3) = rem(manti, 10);
          mantissa(2) = rem(manti-mantissa(3), 100)/10;
          mantissa(1) = rem(manti-mantissa(2)*10-mantissa(3), 1000)/100;   
       end
  end
else  
    eSign = 1;
    if expon < -9,  
     eSign = 0; xSign =0; mantissa = [0 0 0]; exponent = 0;
    else
       mant = absx*10^(3-expon);
       manti = fix(mant);
       if (mant - manti) >= 0.5,
          manti = manti + 1;
       end
       exponent = abs(expon);
       mantissa(3) = rem(manti, 10);
       mantissa(2) = rem(manti-mantissa(3), 100)/10;
       mantissa(1) = rem(manti-mantissa(2)*10-mantissa(3), 1000)/100;    
    end
end  
   
f = struct('mSignBit',xSign,'m',mantissa,'eSignBit',eSign,'e',exponent);


% f = Represent(-237000) is equvalent to 
% f = struct('mSignBit',1,'m',[2 3 7],'eSignBit',0,'e',6)