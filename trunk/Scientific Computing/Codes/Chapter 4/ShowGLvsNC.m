% Script File: ShowGLvsNC
% Compares the m-point Newton-Cotes and Gauss-Legendre rules
ex = input('Example = ');
if ex == 4
    disp('Approximating the integral from 0 to pi/2 of sin(x)/x')
    disp(' ')
    disp(' m           NC(m)                 GL(m)                 NCErr(m)                 GLErr(m) ')
    disp('-------------------------------------------------------------------------------------------------')
    a = 0;  b = pi/2;  exactI = 1.3707621681544884;
    for m=2:6
       NC = QNCOpen('f1',a,b,m);
       err1 = abs(NC-exactI);
       GL = QGL('f1',a,b,m);
       err2 = abs(GL-exactI);
       fprintf(' %1.0f  %20.16f   %20.16f   %20.16e   %20.16e\n',m,NC,GL,err1,err2)
    end
elseif ex == 1
    disp('Approximating the integral from 0 to pi of sin(x)/x')
    disp(' ')
    disp(' m           NC(m)                 GL(m)                 NCErr(m)                 GLErr(m) ')
    disp('-------------------------------------------------------------------------------------------------')
    a = 0;  b = pi;  exactI = 1.8519370519824661;
    for m=2:6
       NC = QNCOpen('f1',a,b,m);
       err1 = abs(NC-exactI);
       GL = QGL('f1',a,b,m);
       err2 = abs(GL-exactI);
       fprintf(' %1.0f  %20.16f   %20.16f   %20.16e   %20.16e\n',m,NC,GL,err1,err2)
    end
else
    if ex == 5,
       disp('Approximating the integral from 0 to 1 of exp(-x^2)')
       f = 'f2'; a = 0; b = 1;          exactI = 0.7468241328124270;
    elseif ex == 3,
       disp('Approximating the integral from 0 to 1 of exp(-2*x)*cos(3*x)')
       f = 'f5'; a = 0; b = 1;       exactI = 0.1788659522032685;
    elseif ex == 2,
       disp('Approximating the integral from 0 to 2 of x^3 + 3*x^2 + 6*x + 9')
       f = 'f6';  a = 0;  b = 2;       exactI = 42;
    end
    
    disp(' ')
    disp(' m           NC(m)                 GL(m)                 NCErr(m)                 GLErr(m) ')
    disp('-------------------------------------------------------------------------------------------------')
    for m=2:6
       NC = QNC(f,a,b,m);
       err1 = abs(NC-exactI);
       GL = QGL(f,a,b,m);
       err2 = abs(GL-exactI);
       fprintf(' %1.0f  %20.16f   %20.16f   %20.16e   %20.16e\n',m,NC,GL,err1,err2)
    end
end
    
