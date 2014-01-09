
y = [300;150];
Yvals = y;
tvals = 0;
h = .01;
t = 0;
for k = 0:1000
   yp = RabbitFox(t,y);
   ynew = y + h*yp;
   tnew = t + h;
   Yvals = [Yvals ynew];
   tvals = [tvals tnew];
   y = ynew;
   t = tnew;
end
subplot(2,1,1)
plot(tvals,Yvals(1,:))
title('Rabbits')
subplot(2,1,2)
plot(tvals,Yvals(2,:))
title('Foxes')