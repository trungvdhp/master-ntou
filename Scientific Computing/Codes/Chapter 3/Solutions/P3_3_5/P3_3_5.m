% Problem P3_3_5
%
% Illustrates CubicSpline1 with various end conditions,
% some not so good.

close all
xvals = linspace(0,4*pi,100);
yvals = sin(xvals);
for n = 4:3:16
   x = linspace(0,4*pi,n)';
   y = sin(x);
   [a,b,c,d] = CubicSpline1(x,y,1);
   svals = pwCEval(a,b,c,d,x,xvals);
   plot(xvals,yvals,xvals,svals)
   title(sprintf('Spline interpolant of sin(x) using qL'' and qR''. (%2.0f subintervals)',n-1))
   pause
end
for n = 4:3:16
   x = linspace(0,4*pi,n)';
   y = sin(x);
   [a,b,c,d] = CubicSpline1(x,y,2);
   svals = pwCEval(a,b,c,d,x,xvals);
   plot(xvals,yvals,xvals,svals)
   title(sprintf('Spline interpolant of sin(x) using qL'''' and qR''''. (%2.0f subintervals)',n-1))
   pause
end

for n = 4:3:16
   x = linspace(0,4*pi,n)';
   y = sin(x);
   [a,b,c,d] = CubicSpline1(x,y,1);
   svals = pwCEval(a,b,c,d,x,xvals);
   plot(xvals,yvals,xvals,svals)
   title(sprintf('Spline interp. of sin(x) using derivatives of end interpolants. (%2.0f subintervals)',n-1))
   pause
end

for n = 4:3:16
   x = linspace(0,4*pi,n)';
   y = sin(x);
   [a,b,c,d] = CubicSpline1(x,y,1,1,1);
   svals = pwCEval(a,b,c,d,x,xvals);
   plot(xvals,yvals,xvals,svals)
   title(sprintf('''Good'' Complete spline interpolant of sin(x). (%2.0f subintervals)',n-1))
   pause
end
for n = 4:3:16
   x = linspace(0,4*pi,n)';
   y = sin(x);
   [a,b,c,d] = CubicSpline1(x,y,1,-1,-1);
   svals = pwCEval(a,b,c,d,x,xvals);
   plot(xvals,yvals,xvals,svals)
   title(sprintf('''Bad'' Complete spline interpolant of sin(x). (%2.0f subintervals)',n-1))
   pause
end
for n = 4:3:16
   x = linspace(0,4*pi,n)';
   y = sin(x);
   [a,b,c,d] = CubicSpline1(x,y,2,0,0);
   svals = pwCEval(a,b,c,d,x,xvals);
   plot(xvals,yvals,xvals,svals)
   title(sprintf('Natural spline interpolant of sin(x). (%2.0f subintervals)',n-1))
   pause
end
for n = 4:3:16
   x = linspace(0,4*pi,n)';
   y = sin(x);
   [a,b,c,d] = CubicSpline1(x,y);
   svals = pwCEval(a,b,c,d,x,xvals);
   plot(xvals,yvals,xvals,svals)
   title(sprintf('Not-a-Knot spline interpolant of sin(x). (%2.0f    subintervals)',n-1))
   pause
end