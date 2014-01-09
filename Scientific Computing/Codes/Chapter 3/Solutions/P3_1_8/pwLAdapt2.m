function [x,y,eTaken] = pwLAdapt2(fname,xL,fL,xR,fR,delta,hmin,eMax)
% fname is a string that names an available function of the form y = f(u).
% xL is real and fL = f(xL)
% xR is real and fR = f(xR)
% delta is a positive real
% hmin is a positive real
% eMax is a positive integer representing the maximum number of fevals allowed.
%
% x is a column n-vector with the property that
% xL = x(1) < ... < x(n) = xR. Each subinterval
% is either <= hmin in length or has the property
% that at its midpoint m, |f(m) - L(m)| <= delta
% where L(x) is the line that connects (xR,fR).
%                 
% y is a column n-vector with the property  that y(i) = f(x(i)).
% eTaken is the number of f-evaluations required.

   if (xR-xL) <= hmin
      % Subinterval is acceptable
      x = [xL;xR]; 
	   y = [fL;fR];
	   eTaken = 0
   else
      mid  = (xL+xR)/2; 
	   fmid = feval(fname,mid);
	   eTaken = 1;
	   eMax = eMax-1;
      if (abs(((fL+fR)/2) - fmid) <= delta )
	      % Subinterval accepted. 
         x = [xL;xR];
         y = [fL;fR];
      else
	      % Produce left and right partitions, then synthesize.
		   if eMax ==0
		      x = xL;
			   y = fL;
		      return
	      end
         [xLeft,yLeft,eTakenL] = pwLAdapt2(fname,xL,fL,mid,fmid,delta,hmin,eMax);
         eTaken = eTaken + eTakenL;
		   eMax = eMax - eTakenL;
		   if eMax == 0
		      x = xLeft;
			   y = yLeft;
	         return
		   end
		    
		   [xRight,yRight,eTakenR] = pwLAdapt2(fname,mid,fmid,xR,fR,delta,hmin,eMax);	
         eTaken = eTaken + eTakenR; 
		   x = [ xLeft;xRight(2:length(xRight))];
         y = [ yLeft;yRight(2:length(yRight))];	 
      end
   end
