% Script File: FFTflops
% Compares the ordinary DFT with the FFT.

clc
x = randn(1024,1)+sqrt(-1)*randn(1024,1);
disp('   n        DFT       FFTRecur      FFT ')
disp('           Flops       Flops       Flops')
disp('------------------------------------------')
for n = [2 4 8 16 32 64 128 256 512 1024]
   flops(0); y = dft(x(1:n));       F1 = flops;
   flops(0); y = FFTRecur(x(1:n));  F2 = flops;
   flops(0); y = fft(x(1:n));       F3 = flops;  
   disp(sprintf(' %4d %10d %10d  %10d', n,F1,F2,F3))
end