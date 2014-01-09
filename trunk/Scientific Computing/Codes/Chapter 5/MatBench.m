% Script File: MatBench
% Compare different matrix multiplication methods.

  clc
  nRepeat = 10;
  disp(' n     Dot     Saxpy    MatVec   Outer    Direct')
  disp('------------------------------------------------')
  for n = [100 200 400]
     A = rand(n,n);
     B = rand(n,n);
     tic; for k=1:nRepeat,C = MatMatDot(A,B);   end, t1 = toc/nRepeat;
     tic; for k=1:nRepeat,C = MatMatSax(A,B);   end, t2 = toc/nRepeat;
     tic; for k=1:nRepeat,C = MatMatVec(A,B);   end, t3 = toc/nRepeat;
     tic; for k=1:nRepeat,C = MatMatOuter(A,B); end, t4 = toc/nRepeat;
     tic; for k=1:nRepeat,C = A*B;              end, t5 = toc/nRepeat;
     disp(sprintf('%2.0f  %7.4f  %7.4f  %7.4f  %7.4f  %7.4f ',n,t1,t2,t3,t4,t5))
  end