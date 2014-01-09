% Script File: CircBench
% Benchmarks Circulant1 and Circulant2.

clc
nRepeat = 20;
disp('t1 = time for Circulant1.')
disp('t2 = time for Circulant2.')
disp(' ')
disp('  n  t1/t2 ')
disp('----------------')
for n=[100 200 400]
   a = 1:n;
   tic;  for k=1:nRepeat, C = Circulant1(a); end, t1 = toc;
   tic;  for k=1:nRepeat, C = Circulant2(a); end, t2 = toc;
   disp(sprintf(' %4.0f   %5.3f',n,t1/t2))
end