function a = N2V(c,x)
% Find y values correspond to x values by evaluating the Newton interpolant on z=x
y = HornerN(c,x,x);
% Computes the Vandermonde polynomial interpolant
a = InterpV(x,y);