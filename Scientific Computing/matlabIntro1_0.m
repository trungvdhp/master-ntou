% matlabIntro1_0.m
% Lecture : Introduction to Matlab software
% 1. Matlab environment and basic commands.
% 2. Basic math and basic features.
% 3. Plot the graph of a function with "ezplot"
% 4. Compute the function values with 3 ways.

% 1. Simple calculation (Arithmetic)
>> (53*2 - 36.5 + 12)/5        % display the result with variable "ans" 
>> y = (53*2 - 36.5 + 12)/5    % assign a variable then it stores the result 
                               % in this variable "y" without display 
>> z = y^2                     % store  the result in "y" and display it     
  % If you put semicolon¡];¡^at the end then the answer does not display 

% MATMAB prints the answer and assigns the value to a variable called "ans"
>> 3^2 - (5 + 4)/2 +6*3
>> ans^2 + sqrt(ans)
  % Note that, after another computation, MATMAB assigns a new value to "ans" 
  % with each calculation.

% 2. basic features.
% One can put many commands in one line separated by common (,¡^or semicolon¡];¡^.
>> x = sin(pi/3); y = x^2; z = y*10,

% If a math expression is too long in a line, it can use "three periods
% ¡]¡K¡^" to extend it next line
>> z = 10*sin(pi/3)*...
>> cos(pi/3)

% 3. Plot the graph of a function with "easy way"
>> ezplot('x^4-12x^3+25x+116')
>> ezplot('x^4-12x^3+25x+116', [-5, 5])    % Adjust the x-axis
>> ezplot('x^2-2*exp(x)')
>> ezplot('x^2-2*exp(x)',[-2, 2])

% 4. Three ways to compute the function values 
% (a) create a function by a "string" form with giving its name 
>> fun  = 'math expression';          
>> x = a; eval(fun)                     % find f(a) 

% (b) Use "inline" to create a function and use "feval" to evaluate its value 
>> fun = inline('math expression')     % use 'inline' function to create 'fun' 
>> feval(fun, a)                       % find f(a) 

% (c) For the build-in functions or which have been created in the same
% directory 
>> fun = @FunctionName; feval(f, a) 

% Ex.1 Find f(3) for f(x) = x^3+5*x+3
>> f = 'x^3+5*x+3'; x=3; eval(f)
>> f = inline('x^3+5*x+3'); feval(f, 3)
>> f = @sin; feval(f, 3*pi/2) 

% Ex.2 Find x=10
>> f='sin(2*x+5)*cos(3*x)*(2*x^2-7)'; x=10; eval(f)
>> f=inline('sin(2*x+5)*cos(3*x)*(2*x^2-7)'); feval(f,10)


