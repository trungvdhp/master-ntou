% Script File: ShowEulerRoundOff
% Illustrates Euler method in 3-digit floating point arithmetic

close all
hold on
t = linspace(0,1);
e = exp(-t);
for n = 140:20:180
   tvals = linspace(0,1,n+1);
   yvals = 0*tvals;
   one = represent(1);
   yc = one;
   factor = float(one,float(one,represent(n),'/'),'-');
   yvals(1) = 1;
   for k=1:n
      yc = float(factor,yc,'*');
      yvals(k+1) = convert(yc);
   end
   plot(tvals,abs(exp(-tvals)-yvals))
   axis([0 1 0 .05])	
   title(sprintf('n = %3d ',n))
   gtext(sprintf('n = %3d',n))
end
hold off
ylabel('Error')
title('Euler in 3-Digit Arithmetic')
