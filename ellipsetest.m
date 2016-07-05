%%%%%%FUNCTION DESCRIPTION
%This file is designed to test plotting ellipses
%It is meant for envisioning what an image or path will look like
%%%%%%%%%%%%%%%%%%%%%%%%%

%copied the math from https://www.mathworks.com/matlabcentral/answers/86615-how-to-plot-an-ellipse?requestedDomain=www.mathworks.com

x1 = -50;
y1 = 0;
x2 = 50;
y2 = 0;
e = .9;

a = 1/2*sqrt((x2-x1)^2+(y2-y1)^2);
b = a*sqrt(1-e^2);
t = linspace(0,2*pi);
X = a*cos(t);
Y = b*sin(t);
w = atan2(y2-y1,x2-x1);
x = (x1+x2)/2 + X*cos(w) - Y*sin(w);
y = (y1+y2)/2 + X*sin(w) + Y*cos(w);

% if rotateLoops
%     %rotate (not transform-dependent)
%     for m = 1:totalpoints-1
%         if any(m == Breaks)
%             f = randi(360);
%         end 
%         rpoints(m, 1) = nrpoints(m, 1)*cos(f) - nrpoints(m, 2)*sin(f);
%         rpoints(m, 2) = nrpoints(m, 2)*cos(f) + nrpoints(m, 1)*sin(f);
%     end
% end

plot(x,y)
axis equal