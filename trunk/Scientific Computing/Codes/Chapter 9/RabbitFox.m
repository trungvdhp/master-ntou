function yp = RabbitFox(t,y)

r = y(1);  % Rabbit density at time t
f = y(2);  % Fox density at time t

alfa = .01;

rp = 2*r - alfa*r*f;  % Rate of change of rabbit density;
fp = -f + alfa*r*f;   % Rate of change of fox density;

yp = [rp;fp];