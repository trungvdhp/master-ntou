  function s = Pretty(f)
% s = Pretty(f)
% f is a is a representation of a 3-digit floating point number. (For details
% type help represent.
% s is a string so that disp(s) "pretty prints" the value of f.

if (f.m == inf) & (f.mSignBit==0)
   s = 'inf';
elseif (f.m==inf) & (f.mSignBit==1)
   s = '-inf';
else
   % Convert the mantissa.
   m = ['.' num2str(f.m(1)) num2str(f.m(2)) num2str(f.m(3))];
   if f.mSignBit == 1
      m = ['-' m];
   end
   % Convert the exponent.
   e = num2str(f.e);
   if f.eSignBit == 0
      e = ['+' num2str(f.e)];
   else
      e = ['-' num2str(f.e)];
   end
   s = [m ' x 10^' e ];
end