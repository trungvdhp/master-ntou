% Script File: ShowContour
% Illustrates various contour plots.

close all
% Set up array of function values.
x = linspace(-2,2,50)';
y = linspace(-1.5,1.5,50)';
F = SampleF(x,y);

% Number of contours set to default value:
figure
Contour(x,y,F)
axis equal

% Five contours:
figure
contour(x,y,F,5);
axis equal

% Five contours with specified values:
figure
contour(x,y,F,[1 .8  .6  .4  .2])
axis equal

% Four contours with manual labeling:
figure
c= contour(x,y,F,4);
clabel(c,'manual');
axis equal