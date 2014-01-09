% Problem P3_1_1
%
% Compare Locate with MyLocate

n = input('Enter n (the length of the partition): ');
m = input('Enter m (the number of evaluation points): ');
a = rand(n-1,1);
b = rand(n-1,1);
x = linspace(0,1,n)';
zvals = linspace(0,1,m)';
flops(0)
Lvals = pwLEval(a,b,x,zvals);
f1 = flops;
flops(0)
Lvals = MypwLEval(a,b,x,zvals);
f2 = flops;

clc 
disp(sprintf('x = linspace(0,1,%2.0f), zvals = linspace(0,1,%2.0f)',n,m))
disp(' ')
disp(sprintf('Flops using Locate:   %5.0f ',f1))
disp(sprintf('Flops using MyLocate: %5.0f ',f2))
disp(' ')
disp(' ')
x = sort(rand(n,1));
zvals = sort(rand(m,1));
flops(0)
Lvals = pwLEval(a,b,x,zvals);
f1 = flops;
flops(0)
Lvals = MypwLEval(a,b,x,zvals);
f2 = flops;
disp(sprintf('x = sort(rand(%2.0f,1)), zvals = sort(rand(%2.0f,1))',n,m))
disp(' ')
disp(sprintf('Flops using Locate:   %5.0f ',f1))
disp(sprintf('Flops using MyLocate: %5.0f ',f2))