%%%%%%FUNCTION DESCRIPTION
%This file is designed to test plotting ellipses
%It is meant for envisioning what an image or path will look like
%%%%%%%%%%%%%%%%%%%%%%%%%

%Math from http://stackoverflow.com/questions/29367548/how-to-apply-rotation-to-an-ellipse-defined-by-center-and-axis-lengths

majorAxis = 2;
minorAxis = 1;
centerX = 10;
centerY = 15;
orientation = -120;

theta = 0 : 0.05 : 2*pi;
orientation=orientation*pi/180;
xx = (majorAxis/2) * sin(theta) + centerX;
yy = (minorAxis/2) * cos(theta) + centerY;

xx2 = (xx-centerX)*cos(orientation) - (yy-centerY)*sin(orientation) + centerX;
yy2 = (xx-centerX)*sin(orientation) + (yy-centerY)*cos(orientation) + centerY;
plot(xx2,yy2)
axis equal
grid