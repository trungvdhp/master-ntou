  function [L,R] = GraphSearch(fname,a,b,Save,nfevals)
% [L,R] = GraphSearch(fname,a,b,Save,nfevals)
%
% Graphical search. Produces sequence of plots of the function f(x). The user
% specifies the x-ranges by mouseclicks. 
%
% name is a string that names a function f(x) that is defined 
% on the interval [a,b]. 
% nfevals>=2 
%
% Save is used to determine how the plots are saved. If Save is
% nonzero, then each plot is saved in a separate figure window.
% If Save is zero or if GraphSearch is called with just three
% arguments, then only the final plot is saved. 
%
% [L,R] is the x-range of the final plot. The plots are based on nfevals
% function evaluations. If GraphSearch is called with less
% than five arguments, then nfevals is set to 100.


close all
if nargin==3
   Save=0;
end
if nargin<5
   nfevals=100;
end
AnotherPlot = 1;
L = a;
R = b;
while AnotherPlot
   x = linspace(L,R,nfevals);
   y = feval(fname,x);
   if Save
      figure
   end
   ymin = min(y);
   plot(x,y,[L R],[ymin ymin])
   title(['The Function ' fname])
   v = axis;
   v(1) = L;
   v(2) = R;
   v(3) = v(3)-(v(4)-v(3))/10;
   axis(v)
   xlabel('Enter New Left Endpoint. (Click off x-range to terminate.)')
   text(R,ymin,['  ' num2str(ymin)])
   [x1,y1] = ginput(1);
   if (x1<L) | (R<x1) 	  
      AnotherPlot=0;
   else
      xlabel('Enter New Right Endpoint. (Click off x-range to terminate.)')
      [x2,y2] = ginput(1);
      if (x2<L) | (R<x2) 
         AnotherPlot=0; 
      else
         L = x1;
         R = x2;
      end
   end
   xlabel(' ')
end