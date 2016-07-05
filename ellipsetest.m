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

theta = linspace(0,2*pi,1000);
orientation=orientation*pi/180;
x = (majorAxis/2) * sin(theta) + centerX;
y = (minorAxis/2) * cos(theta) + centerY;

x2 = (x-centerX)*cos(orientation) - (y-centerY)*sin(orientation) + centerX;
y2 = (x-centerX)*sin(orientation) + (y-centerY)*cos(orientation) + centerY;
plot(x2,y2)
axis equal
grid