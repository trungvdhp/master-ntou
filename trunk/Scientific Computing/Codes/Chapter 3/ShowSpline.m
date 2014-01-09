% Script File: ShowSpline
% Illustrates CubicSpline with various end conditions, some not so good.

close all
xvals = linspace(0,4*pi,100);
yvals = sin(xvals);
for n = 4:3:16
   x = linspace(0,4*pi,n)';
   y = sin(x);
   [a,b,c,d] = CubicSpline(x,y,1,1,1);
   svals = pwCEval(a,b,c,d,x,xvals);
   figure
   plot(xvals,yvals,xvals,svals,'--')
   title(sprintf('''Good'' Complete spline interpolant of sin(x) with %2.0f subintervals',n-1))
end
for n = 4:3:16
   x = linspace(0,4*pi,n)';
   y = sin(x);
   [a,b,c,d] = CubicSpline(x,y,1,-1,-1);
   svals = pwCEval(a,b,c,d,x,xvals);
   figure
   plot(xvals,yvals,xvals,svals,'--')
   title(sprintf('''Bad'' Complete spline interpolant of sin(x) with %2.0f subintervals',n-1))
end
for n = 4:3:16
   x = linspace(0,4*pi,n)';
   y = sin(x);
   [a,b,c,d] = CubicSpline(x,y,2,0,0);
   svals = pwCEval(a,b,c,d,x,xvals);
   figure
   plot(xvals,yvals,xvals,svals,'--')
   title(sprintf('Natural spline interpolant of sin(x) with %2.0f subintervals',n-1))
end
for n = 4:3:16
   x = linspace(0,4*pi,n)';
   y = sin(x);
   [a,b,c,d] = CubicSpline(x,y);
   svals = pwCEval(a,b,c,d,x,xvals);
   figure
   plot(xvals,yvals,xvals,svals,'--')
   title(sprintf('Not-a-Knot spline interpolant of sin(x) with %2.0f subintervals',n-1))
end