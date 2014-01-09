% Script File: ProdBound
% Examines the error in 3-digit matrix multiplication.

  clc
  eps3 = .005;       % 3-digit machine precision
  nRepeat = 10;      % Number of trials per n-value
  disp('   n   1-norm factor ')
  disp('------------------------')
  for n = 2:10
     s = 0;
     for r=1:nRepeat
        A = randn(n,n); 
        B = randn(n,n);
        C = Prod3Digit(A,B);
        E = C - A*B;
        s = s+ norm(E,1)/(eps3*norm(A,1)*norm(B,1));
     end
     disp(sprintf('%4.0f     %8.3f   ',n,s/nRepeat))
  end