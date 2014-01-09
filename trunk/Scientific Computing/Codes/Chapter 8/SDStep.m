  function [tnew,fnew,gnew] = SDStep(tc,fc,gc,planet1,planet2,Lmax,auto)
% [tnew,fnew,gnew] = SDStep(tc,fc,gc,planet1,planet2,Lmax,auto)
% Generates a steepest descent step.
%
%  fName     the name of a function f(x,plist) that accepts column
%            n-vectors and returns a scalar.
%  gName     the name of a function g(x,plist) that returns the
%            gradient of f at x.
%     xc     a column-vector, an approximate minimizer
%     fc     f(xc,plist)
%     gc     g(xc,plist)
%  plist     orbit parameters for f and g
%   Lmax     max step length
%   auto     if auto is nonzero, then automated line search
%
%   xnew     a column n-vector, an improved minimizer
%   fnew     f(xnew,plist)
%   gnew     g(new,plist)
%

nplotvals = 20;

% Get the Steepest Descent Search Direction
sc = -gc;
% Line Search
% Try to get L<=Lmax so xc+L*sc is at least as good as xc.
L = Lmax;
Halvings = 0;
fL = Sep(tc+L*sc,planet1,planet2);
while (fL>=fc) & Halvings<=10
   L = L/2;
   Halvings = Halvings+1;
   fL = Sep(tc+L*sc,planet1,planet2);
end  
% Sample across [0.L]
lambdavals = linspace(0,L,nplotvals);
fvals = zeros(1,nplotvals);
for k=1:nplotvals
   fvals(k) = Sep(tc+lambdavals(k)*sc,planet1,planet2);
end
if auto==0
   % Manual line search.
   plot(lambdavals,fvals);
   xlabel('lambda');
   ylabel('Sep(tc+lambda*sc)');
   title('Click the Best lambda value.');
   [lambda,y] = ginput(1);
   tnew = tc+lambda*sc;
   fnew = Sep(tnew,planet1,planet2);
   gnew = gSep(tnew,planet1,planet2);
else
   % Automated line search.
   [fnew,i] = min(fvals(1:nplotvals));
   tnew = tc + lambdavals(i(1))*sc;
   gnew = gSep(tnew,planet1,planet2);
end 