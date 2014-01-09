% Problem P3_1_2
%
% Location in uniform partitions

x = linspace(-2,2,5);
clc 
disp('i   x(i)    z    x(i+1)')
disp('-------------------------')
for z = linspace(-2,2,9)
   i = LocateUniform(x(1),x(5),5,z);
   disp(sprintf('%1.0f   %3.0f   %4.1f   %3.0f',i,x(i),z,x(i+1)))
end