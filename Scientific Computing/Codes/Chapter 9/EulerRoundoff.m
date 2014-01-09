% Script File: EulerRoundOff
% Global error for the fixed step Euler method in 3-digit floating point arithmetic
% applied to y' = -y across [0,1].

close all
t = linspace(0,1);
e = exp(-t);
for n = 140:20:180
   tvals = linspace(0,1,n+1);
   yvals = 0*tvals;
   one = Represent(1);
   yc = one;
   factor = Float(one,float(one,represent(n),'/'),'-');
   yvals(1) = 1;
   for k=1:n
      yc = Float(factor,yc,'*');
      yvals(k+1) = Convert(yc);
   end
   plot(tvals,abs(exp(-tvals)-yvals))
   hold on
   axis([0 1 0 .05])	
end
hold off
title('Euler in 3-Digit Arithmetic')
text(.76,.005,'h = 1/140')
text(.62,.012,'h = 1/160')
text(.42,.02,'h = 1/180')




