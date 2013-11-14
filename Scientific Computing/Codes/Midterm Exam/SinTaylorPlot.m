n=100;
x=linspace(-pi,pi,n);
s = sin(x);
s2 = x - x.^3/6;
s3 = s2 + x.^5/120;
s4 = s3 - x.^7/5040;
plot(x,s,'b',x,s2,'*g',x,s3,'.-r',x,s4,'+c')
title('y = sin(x), x \in [-\pi, \pi]');
xlabel('x');
ylabel('y');
legend('y = sin(x)', 'y = x - x^3 / 3!', 'y = x - x^3 / 3! + x^5 / 5!','y = x - x^3 / 3! + x^5 / 5! - x^7 / 7!')