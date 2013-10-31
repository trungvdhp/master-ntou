% MyExpTest1

nRepeat = 100;
disp('T1 = MyExp1  benchmark. ')
disp('T2 = MyExp2  benchmark. ')
disp('Length(x)     T1     T2     T1/T2 ')
disp('----------------------------------')
for L = 1000:100:2000,
    xL = linspace(-1,1,L);
    tic; 
    for k =1:nRepeat,  y = MyExp1(xL);  end, 
    T1 = toc;
    tic; 
    for k =1:nRepeat,  y = MyExp2(xL);  end, 
    T2 = toc;
    disp(sprintf('%5.0f  %8.4f  %8.4f  %8.4f',L,T1,T2,T1/T2))
end


% disp('Length(x)    MyExp(3)    MyExp(4) ')
% disp('               Flops       Flops  ')
% disp('----------------------------------')
% for L = 50:50:300
%    xL = linspace(-1,1,L)
%    flops(0); y = MyExp3(xL); f3 = flops;      % No longer available in Matlab 6 
%    flops(0); y = MyExp4(xL); f4 = flops;
%    disp(sprintf('%6.0f   %13.0f   %13.0f  ',L,f3,f4))
% end
