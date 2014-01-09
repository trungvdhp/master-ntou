% Script File: CholBench
% Benchmarks five different Cholesky implemntations.

clc
n = input('Enter n: ');
X = rand(2*n,n);
A = X'*X;
disp(' ');
disp(sprintf('n = %2.0f',n))
disp(' ');
disp('Algorithm   Relative Time     Flops')
disp('-----------------------------------')

flops(0); tic; G = CholScalar(A); t1 = toc; f = flops; 
disp(sprintf('CholScalar      %6.3f        %5.0f',t1/t1,f));

flops(0); tic; G = CholDot(A);    t2 = toc; f = flops; 
disp(sprintf('CholDot         %6.3f        %5.0f',t2/t1,f));

flops(0); tic; G = CholSax(A);    t3 = toc; f = flops; 
disp(sprintf('CholSax         %6.3f        %5.0f',t3/t1,f));

flops(0); tic; G = CholGax(A);    t4 = toc; f = flops; 
disp(sprintf('CholGax         %6.3f        %5.0f',t4/t1,f));

flops(0); tic; G = CholRecur(A);  t5 = toc; f = flops; 
disp(sprintf('CholRecur       %6.3f        %5.0f',t5/t1,f));

disp(' ')
disp('Relative time = Time/CholScalar Time')

