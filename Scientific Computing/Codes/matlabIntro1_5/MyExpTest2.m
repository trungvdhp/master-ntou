% MyExpTest2

disp('T3 = MyExp3  benchmark. ')
disp('T4 = MyExp4  benchmark. ')
disp('Length(x)   T3     T4   T3/T4')
disp('------------------------')
for L = 6000:500:12000,
    xL = linspace(-1,1,L);
    tic;  y = MyExp3(xL);  T3 = toc;
    tic;  y = MyExp4(xL);  T4 = toc;
    disp(sprintf('%6.0f   %13.6f   %13.6f   %10.4f ',L,T3,T4,T3/T4))
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
