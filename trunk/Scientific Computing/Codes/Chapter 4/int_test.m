% Program int_test.m  for Chapter 5: Numerical integration.

% Date: 4/10/2001,   Name: Fusen F. Lin
% This program tests the quadrature rules: 'trapz.m', 'romberg.m', 'simpson.m', and 
% 'simpsnr.m' and .
% Those are the Bisection method, Newton's method, and Secant method.
% we require the accuracy as given the decimal digits 'dg', tol = .5*10^(-dg).


% Giving the inputs.
ex = input('Example = ?'); 
if ex == 1,
   f = 'exp(-x.^2)'; a = 0; b = 1;            exactI = 0.7468241328124270;
elseif ex == 2,
   f = 'cos(2*x).*exp(-x)'; a = 0; b = 2*pi;  exactI = 0.1996265114536584;
elseif ex == 3,
 %  f ='1./(x.^2 + 1)';  a = 0;  b = 2;         exactI = 1.107148717794090;
 %  f ='4./(x.^2 + 1)';  a = 0;  b = 1;  exactI = pi;
 f ='x.^3+3*x.^2-10*x+3';  a = -1;  b = 1;  exactI = 8.0; 
elseif ex == 4,
 f='sin(x)./x';   a = 0;  b = 1;  exactI = 0.9460830703671824;
  %  f ='sqrt(x.^2 + 1)';  a = 0; b = 2;  % exactI = 2.957885715089195;
  % f = '1./ sqrt(x + 1)';  a = 0; b = 2;  exactI = 1.464101615137755;
  % exactI = quad8('func1', a, b, 10^(-8));
end

level = 0;  lv_max = 50; level1 = 0; level2 = 0;   
  n = input('n =?'); h = 1;
  dg = input('dg =?');  tol = .5*10^(-dg);       % the reqired accuracy.


% Test the 'simpson.m': CORRECT.
% I = simpson(f, a, b, n);   err = abs((I - exactI)/exactI)

% Test the 'trapz.m': CORRECT.
% I = trapz(f, a, b, n)   err = abs((I - exactI)/exactI)

% Test the 'romberg.m': CORRECT.
 % display('Romberg algorithm');
 % I = romberg(f, a, b, n)
 % err = abs((I - exactI)/exactI)
 
% Test the 'simpsonr.m': CORRECT.
% A = [root, err, n] %
% display('Adaptive Simpson rule');
 % I = simpsonr(f, a, b, tol, level, lv_max)

% Test the 'midpt.m': CORRECT.
% I = midpt(f, a, b, n) % err = abs((I - exactI)/exactI)

% Test the 'gs_leg_rl.m': CORRECT. 
display('Gaussian n-point rule');
I = gs_leg_rl(f, a, b, n)  
err = abs((I - exactI)/exactI)


