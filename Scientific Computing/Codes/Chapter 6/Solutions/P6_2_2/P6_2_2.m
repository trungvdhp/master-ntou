% Problem P6_2_2
%
% Compare CubicSpline and CubicSpline1 where the latter exploits the
% tridiagonal nature of the linear system.

clc 
disp('Complete Spline')
disp(' ')
disp('           CubicSpline          CubicSpline1')
disp('  n      flops      time      flops       time')
disp('-----------------------------------------------')
for n = [20 40 80 160 320]
   x = linspace(0,pi/2,n)';
   y = sin(x);
   
   flops(0)
   tic;
   [a,b,c,d] = CubicSpline(x,y,1,1,0);
   t1 = toc;
   f1 = flops;
   
   flops(0)
   tic;
   [a1,b1,c1,d1] = CubicSpline1(x,y,1,1,0);
   t2 = toc;
   f2 = flops;
   disp(sprintf('%4.0f    %6.0f  %8.3f     %6.0f   %8.3f',n,f1,t1,f2,t2))
end
disp(' ')
disp(' ')	
disp('Second Derivative Spline')
disp(' ')
disp('           CubicSpline          CubicSpline1')
disp('  n      flops      time      flops       time')
disp('-----------------------------------------------')
for n = [20 40 80 160 320]
   x = linspace(0,pi/2,n)';
   y = sin(x);	
   flops(0)
   tic;    
   [a,b,c,d] = CubicSpline(x,y,2,0,1);
   t1 = toc;
   f1 = flops;
   flops(0)
   tic;    
   [a1,b1,c1,d1] = CubicSpline1(x,y,2,0,1);
   t2 = toc;
   f2 = flops;
   
   disp(sprintf('%4.0f    %6.0f  %8.3f     %6.0f   %8.3f',n,f1,t1,f2,t2))
end

disp(' ')
disp(' ')	
disp('Not-a-Knot Spline')
disp(' ')
disp('           CubicSpline          CubicSpline1')
disp('  n      flops      time      flops       time')
disp('-----------------------------------------------')
for n = [20 40 80 160 320]
   x = linspace(0,pi/2,n)';
   y = sin(x);		
   flops(0)
   tic;   
   [a,b,c,d] = CubicSpline(x,y); 
   t1 = toc;
   f1 = flops;  
   flops(0)
   tic;   
   [a1,b1,c1,d1] = CubicSpline1(x,y); 
   t2 = toc;
   f2 = flops; 
   disp(sprintf('%4.0f    %6.0f  %8.3f     %6.0f   %8.3f',n,f1,t1,f2,t2))
end