% Problem P4_2_2
%
% A more vectorized CompQNC

A = zeros(10,3);
for i=1:10
      m = i+1;
   for n=1:3
      numI  =  CompQNC('sin',0,pi/2,m,n);
      numI1 = CompQNC1('sin',0,pi/2,m,n);
      A(i,n) = abs(numI-numI1);
   end
end

clc 
disp('Difference between CompQNC and CompQNC1.')
disp('Tested on integral from 0 to pi/2 of sin(x).')
disp(' ');
disp(' m         n=1          n=2           n=3')
disp('-------------------------------------------')
for i=1:10
   disp(sprintf('%2.0f     %8.3e     %8.3e     %8.3e',i+1,A(i,:)))
end