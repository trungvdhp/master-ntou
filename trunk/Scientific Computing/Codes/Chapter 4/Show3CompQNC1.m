% Program Show3CompQNC.m  for Chapter 4
% Giving the inputs.
ex = input('Example = '); 
if ex == 4
    disp('Integral from 0 to pi/2 of sin(x)/x use Open Rules')
    a = 0;  b = pi/2;  exactI = 1.3707621681544884;
    for n = [1 2 4 8]
        fprintf('n = %d\n',n);
        disp('  m         QNC(m)	          Error')
        disp(' ')
        for m = 2:7
            numI = CompQNCOpen('f1',a,b,m,n);
            err = abs((numI - exactI)/exactI);
            s = sprintf('%20.16f  %10.3e',numI,err) ;
            disp([ sprintf(' %2.0f  ' ,m) s]) 
        end
        disp(' ')
     end
elseif ex == 1
    disp('Integral from 0 to pi of sin(x)/x use Open Rules')
    a = 0;  b = pi;  exactI = 1.8519370519824661;
    for n = [1 2 4 8]
        fprintf('n = %d\n',n);
        disp('  m         QNC(m)	          Error')
        disp(' ')
        for m = 2:7
            numI = CompQNCOpen('f1',a,b,m,n);
            err = abs((numI - exactI)/exactI);
            s = sprintf('%20.16f  %10.3e',numI,err) ;
            disp([ sprintf(' %2.0f  ' ,m) s]) 
        end
        disp(' ')
     end
else
    if ex == 5,
       disp('Integral from 0 to 1 of exp(-x^2)')
       f = 'f2'; a = 0; b = 1;          exactI = 0.7468241328124270;
    elseif ex == 3,
       disp('Integral from 0 to 1 of exp(-2*x)*cos(3*x)')
       f = 'f5'; a = 0; b = 1;       exactI = 0.1788659522032685;
    elseif ex == 2,
       disp('Integral from 0 to 2 of x^3 + 3*x^2 + 6*x + 9')
       f = 'f6';  a = 0;  b = 2;       exactI = 42;
    end
    
    for n = [1 2 4 8]
        fprintf('n = %d\n',n);
        disp('  m         QNC(m)	          Error')
        disp(' ')
        for m = 2:11
            numI = CompQNC(f,a,b,m,n);
            err = abs((numI - exactI)/exactI);
            s = sprintf('%20.16f  %10.3e',numI,err) ;
            disp([ sprintf(' %2.0f  ' ,m) s]) 
        end
        disp(' ')
     end
end
    
