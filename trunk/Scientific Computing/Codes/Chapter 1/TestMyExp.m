% Script File: TestMyExp
% Checks MyExpF, MyExp1, MyExp2, MyExp3, and MyExp4.

close all
m = 50;
x = linspace(-1,1,m);
exact = exp(x);
figure
k=0;
y = zeros(1,m);
for n = [4 8 16 20]
   for i=1:m
      y(i) = MyExpF(x(i),n);
   end
   RelErr = abs(exact - y)./exact;
   k=k+1;
   subplot(2,2,k)
   plot(x,RelErr)
   title(sprintf('n = %2.0f',n))
end
  
clc
nRepeat = 1; 

% Note: The following fragment may take a long time to execute
% with this value of nRepeat.

disp('T1 = MyExp1 benchmark.')
disp('T2 = MyExp2 benchmark.')
disp(' ')
disp(' Length(x)     T2/T1')
disp('-----------------------')
for L = 1000:100:2000
   xL = linspace(-1,1,L);
   tic
   for k=1:nRepeat
      y = MyExp1(xL);
   end
   T1 = toc;
   tic
   for k=1:nRepeat
      y = MyExp2(xL);
   end
   T2 = toc;	 	 
   disp(sprintf('%6.0f  %13.6f  ',L,T2/T1))
end
  
disp(' ')
disp(' ')
disp(' Length(x)     MyExp3(x)      MyExp4(x) ')
disp('                 Flops          Flops')
disp('---------------------------------------')
for L = 50:50:300
   xL = linspace(-1,1,L);
   flops(0);
   y = MyExp3(xL);
   f3 = flops;
   flops(0);
   y = MyExp4(xL);
   f4 = flops;	 	 
   disp(sprintf('%6.0f  %13.0f  %13.0f  ',L,f3,f4))
end 