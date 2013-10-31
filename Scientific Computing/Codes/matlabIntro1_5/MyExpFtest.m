% MyExpFtest
% Plot the relative errors with n = 4, 8, 16, 20

m = 50;
x = linspace(-1,1,m);
y = zeros(1, m);
exact = exp(x);
k = 0;
for n = [4 8 16 20]
   for i=1:m
      y(i) = MyExpF(x(i),n);
   end
   RelErr = abs(exact - y)./exact;
   k = k+1;
   subplot(2, 2, k)
   plot(x, RelErr)
   title(sprintf('n = %2.0f', n))
end