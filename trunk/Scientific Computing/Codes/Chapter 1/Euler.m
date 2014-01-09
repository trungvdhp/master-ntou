% Script File: Euler
% Sums the series 1 + 1/2 + 1/3 + .. in 3-digit floating point arithmetic.
% Terminates when the addition of the next term does not change
% the value of the running sum.

oldsum = represent(0);
one = represent(1);
sum = one;
k = 1;
while convert(sum) ~= convert(oldsum)
   k = k+1;
   kay  = represent(k);
   term = float(one,kay,'/');
   oldsum = sum;
   sum  = float(sum,term,'+');
end   
clc
disp(['The sum for ' num2str(k) ' or more terms is ' pretty(sum)])