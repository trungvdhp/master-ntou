% structure.m
% Example of structure arrays--more advanced data structures 

A = struct('d',16, 'm',23, 's',47);     % the angle (with degree) of A.
r = pi*(A.d + A.m/60 + A.s/3600)/180;   % the radians of A.

NYC_lat = struct('d',40, 'm',45, 's',27);
NYC_long = struct('d',75, 'm',12, 's',32);
c1 = struct('name','New York','lat',NYC_lat,'long',NYC_long);
% To establish C1 as a structure array with three fields. 
% The first field is a string and the last two are structure arrays.  

NYC_lat = struct('d',16, 'm',23, 's',47);
NYC_long = struct('d',74, 'm',2, 's',32);
city1 = struct('name','New York','lat',NYC_lat,'long',NYC_long);
Ith_lat = struct('d',42, 'm',25, 's',26);
Ith_long = struct('d',76, 'm',29, 's',41);
city2 = struct('name','Ithaca','lat',Ith_lat,'long',Ith_long);

city1
city1.lat 
city1.long

City1 = city1.name
latitude = [city1.lat.d city1.lat.m city1.lat.s]
longitude = [city1.long.d city1.long.m city1.long.s]

City1 = city1.name
disp(sprintf('latitude: %3.0d degree %3.0d minute %3.0d second', city1.lat.d, city1.lat.m, city1.lat.s))
disp(sprintf('longitude: %3.0d degree %3.0d minute %3.0d second', city1.long.d, city1.long.m, city1.long.s))

City2 = city2.name
latitude = city2.lat 
longitude = city2.long