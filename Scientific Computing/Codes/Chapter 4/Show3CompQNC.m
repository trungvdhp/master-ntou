% Program Show3CompQNC.m  for Chapter 4
% Giving the inputs.
ex = input('Example = '); 
if ex == 1
    a = 0;  b = 1;  exactI = 0.9460830703671824;
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
    if ex == 2,
       f = 'f2'; a = 0; b = 1;          exactI = 0.7468241328124270;
    elseif ex == 3,
       f = 'f3'; a = 0; b = 2*pi;       exactI = 0.1996265114536584;
    elseif ex == 4,
       f = 'f4';  a = -1;  b = 1;       exactI = 8.0;
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
    
