% Script P5_4_1
%
% Compares the ordinary DFT with the FFT.

clc
global w
x = randn(1024,1)+sqrt(-1)*randn(1024,1);
disp('   n       DFT Flops    FFTRecur Flops    FFT Flops');
disp('------------------------------------------------------')
for n = [2 4 8 16 32 64 128 256 ]
   flops(0);
   y = DFT(x(1:n));
   dftFlops = flops;
   
   flops(0);
   % Precompute the weight vector.
   w = exp(-2*pi*sqrt(-1)/n).^(0:((n/2)-1))'; 
   % Note: there are better ways to do this.
   y2 = MyFFTRecur(x(1:n));   
   recurFlops = flops;
   flops(0);
   y = fft(x(1:n));
   fftFlops = flops;  
   disp(sprintf(' %4.0f   %10.0f    %10.0f      %10.0f', n,dftFlops,recurFlops,fftFlops))
end