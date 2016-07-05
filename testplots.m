%%%%%%FUNCTION DESCRIPTION
%This file is designed to plot point lists
%It is meant for envisioning what an image or path will look like
%%%%%%%%%%%%%%%%%%%%%%%%%

%setup
loops = 3;
start = pi / loops;
loopTime = .75;
ifi = 0.0167;
loopFrames = round(loopTime / ifi) + 1;
halfLoop = floor(loopFrames / 2);
steps = loopFrames * loops;
minSpace = 40;
rng('shuffle');
screenXpixels = 1280;
screenYpixels = 1024;
xCenter = screenXpixels /2;
yCenter = screenYpixels /2;



theta = linspace(start, start + 2*pi, steps);

rho = 1 + cos(loops*theta);

thetalist = reshape(theta, [numel(theta), 1]);

rholist = zeros([numel(theta), 1]);

for m = 1:numel(theta)
    rholist(m, 1) = 1 + cos(loops*thetalist(m, 1));
end

points = zeros([numel(theta), 2]);

for m = 1:numel(theta)
    points(m, 1) = rholist(m, 1)*cos(thetalist(m, 1));
    points(m, 2) = rholist(m, 1)*sin(thetalist(m, 1));
end

totalpoints = numel(points) / 2;


%Points is the basic loops

xpoints = (points(:, 1) .* 2) + xCenter;
ypoints = (points(:, 2) .* 2) + yCenter;

% xpoints = points(:, 1) + xCenter;
% ypoints = points(:, 2) + yCenter;

points = [xpoints ypoints];

% 
% farpoints = points;
% 
% rpoints = points;
% 
% Breaks = randi([1 (loops*loopFrames)], 1, loops -1);
% x = 1;
% y = 2;
% while x <= numel(Breaks)
%     while y <= numel(Breaks)
%         if x ~= y && abs(Breaks(x) - Breaks(y)) < minSpace || Breaks(x) < minSpace || (loops*loopFrames) - Breaks(x) < minSpace
%             Breaks(x) =  randi([1, (loops*loopFrames)], 1, 1);
%             x = 1;
%             y = 0;
%         end
%         y = y + 1;
%     end
%     x = x + 1;
%     y = 1;
% end
% Breaks =  [Breaks [loops*loopFrames]];
% disp(Breaks)
% 
% petalnum = 0;
% 
% %move to origin
% for m = 1:totalpoints-1 
%     if any(m == Breaks)
%         petalnum = petalnum + 1;
%     end
%     r = halfLoop + (loopFrames * petalnum);
%     rpoints(m, 1) = points(m, 1) - points(halfLoop + (loopFrames * petalnum), 1) / 2;
%     rpoints(m, 2) = points(m, 2) - points(halfLoop + (loopFrames * petalnum), 2) / 2;
% end  
% 
% nrpoints = rpoints;
% f = randi(360);
% 
% %rotate (not transform-dependent)
% for m = 1:totalpoints-1
%     if any(m == Breaks)
%         f = randi(360);
%     end 
%     rpoints(m, 1) = nrpoints(m, 1)*cos(f) - nrpoints(m, 2)*sin(f);
%     rpoints(m, 2) = nrpoints(m, 2)*cos(f) + nrpoints(m, 1)*sin(f);
% end
% 
% nrpoints = rpoints;
% petalnum = 0;
% 
% %push based on new tip direction.
% for m = 1:totalpoints-1
%     if any(m == Breaks)
%         petalnum = petalnum + 1;
%     end
%     rpoints(m, 1) = nrpoints(m, 1) + (points(halfLoop + (loopFrames * petalnum), 1) *2);
%     rpoints(m, 2) = nrpoints(m, 2) + (points(halfLoop + (loopFrames * petalnum), 2) *2);
% end

figure
%plot(rpoints(:, 1), rpoints(:, 2), 'b', points(:, 1), points(:, 2), 'r')
plot(points(1:floor(totalpoints/3), 1), points(1:floor(totalpoints/3), 2))
%axis([0 1280 0 1024])
