%%%%%%FUNCTION DESCRIPTION
%This file is designed to test plotting ellipses
%It is meant for envisioning what an image or path will look like
%%%%%%%%%%%%%%%%%%%%%%%%%

%Math from http://stackoverflow.com/questions/29367548/how-to-apply-rotation-to-an-ellipse-defined-by-center-and-axis-lengths

%parameters
majorAxis = 2;
minorAxis = 1;
centerX = 0;
centerY = 0;
circleAxis = .1;

orientation = -120;

%setup
theta = linspace(0,2*pi,1000);
orientation=orientation*pi/180;

%Plot a central circle)
circlex = (circleAxis/2) * sin(theta) + centerX;
circley = (circleAxis/2) * cos(theta) + centerY;

%Plot an ellipse
x = (majorAxis/2) * sin(theta) + centerX;
y = (minorAxis/2) * cos(theta) + centerY;

x2 = (x-centerX)*cos(orientation) - (y-centerY)*sin(orientation) + centerX;
y2 = (x-centerX)*sin(orientation) + (y-centerY)*cos(orientation) + centerY;

%Push out a bit (the edge should hit the origin; you'll see what I mean)
for m = 1:numel(x2)
    xx2(m) = x2(m) + (x2(round(numel(x2)*.75)) *1);
    yy2(m) = y2(m) + (y2(round(numel(y2)*.75)) *1);
end

%Second ellipse
orientation3 = 15;
orientation3=orientation3*pi/180;

x3 = (x-centerX)*cos(orientation3) - (y-centerY)*sin(orientation3) + centerX;
y3 = (x-centerX)*sin(orientation3) + (y-centerY)*cos(orientation3) + centerY;

%Push out a bit (the edge should hit the origin; you'll see what I mean)
for m = 1:numel(x3)
    xx3(m) = x3(m) + (x3(round(numel(x3)*.75)) *1);
    yy3(m) = y3(m) + (y3(round(numel(y3)*.75)) *1);
end

plot(x2,y2,circlex,circley,'--', x3,y3,'g', xx3,yy3,'m', xx2,yy2,'c')
axis equal
grid