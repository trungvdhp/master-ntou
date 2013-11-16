x = [-2 -1 0 1 2 3]';
y = [35 5 1 1 11 30]';
disp('Computes the coefficients of polynomial interpolant by the method: Newton representation');
c = InterpN(x,y)
disp('Computes the coefficients of polynomial interpolant by the method: Vandermonde approach');
a1 = InterpV(x,y)
disp('Converts the Newton representation to the Vandermode representation by using function N2V(c,x)');
a2 = N2V(c,x)