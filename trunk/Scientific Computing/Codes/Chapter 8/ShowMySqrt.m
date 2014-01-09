% Script File: ShowMySqrt
% Plots the error in the function MySqrt.

close all
L = input('Enter left endpoint of test interval:');
R = input('Enter right endpoint of test interval:');
Avals = linspace(L,R,300);
s = zeros(1,300);
for k=1:300
   s(k) = MySqrt(Avals(k));
end
error = abs(s-sqrt(Avals))./sqrt(Avals);
figure
plot(Avals,error+eps*.01)
Title('Relative Error in the Function MySqrt(A)')
xlabel('A'); 