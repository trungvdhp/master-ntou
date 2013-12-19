
% Script File: Show3CompQNC
% Illustrates composite Newton-Cotes rules on three different integrands.

ex = 1;
fname = '';
a = 0;
b = 0;
while 1
    ex = input('Select example (type 0 to exit) = ');

    if ex == 0
        break;
    end
    
    close all
    figure
    mrk={'o','s','*','v','+','^'};
    
    if ex == 1
        % Show QNC(m,n) errors for integral of sin from 0 to pi/2.
        fname = 'f1';
        a = 0;
        b = pi;
        for m = 2:7
           % m-point rule used.
           err = [];
           % n = number of subintervals.
           for n = [1 2 4 8]
               err = [err  abs(CompQNCOpen(fname,a,b,m,n) -1)+eps];
           end
           semilogy([1 2 4 8], err) % plot the errors for each n 
           %axis([0 10 10^(-17) 10^0])
           hold on
        end
        title('Example 1. QNC(m,n) error for integral of sin(x)/x from 0 to pi')
    elseif ex == 2
        fname = 'f2';
        a = 0;
        b = 2;
        
        for m = 2:11
           % m-point rule used.
           err = [];
           for n = [1 2 4 8]
               err = [err  abs(CompQNC(fname,a,b,m,n) -1)+eps];
           end
           plot([1 2 4 8], err)
           hold on
        end
        title('Example 2. QNC(m,n) error for integral of x^3+3x^2+6x+9 from 0 to 2')
    elseif ex == 3
        fname = 'f3';
        a = 0;
        b = 1;
        
        for m = 2:11
           % m-point rule used.
           err = [];
           for n = [1 2 4 8]
               err = [err  abs(CompQNC(fname,a,b,m,n) -1)+eps];
           end
           plot([1 2 4 8], err)

           hold on
        end
        title('Example 3. QNC(m,n) error for integral of exp(-2x)*cos(3x) from 0 to 1')
    end
    set(gca,'XTick',[1 2 4 8])
    xlabel('n = number of subintervals')
    ylabel('Error in QNC(m,n)')
end
