function [] = objtesting()

%%%%%%FUNCTION DESCRIPTION
%objtesting is a testing function for drawing sizes and rotations of
%objects
%It is capable of standalone use.
%%%%%%%%%%%%%%%%%%%%%%%%%


%What I can manipulate:
%Loops, scale, 

%What I wanna manipulate:
%petal size, push distance


Screen('Preference', 'SkipSyncTests', 0);
close all;
sca
PsychDefaultSetup(2);
screens = Screen('Screens');
screenNumber = max(screens);
rng('shuffle');
KbName('UnifyKeyNames');

white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);
grey = white/2;

[window, windowRect] = PsychImaging('OpenWindow', screenNumber, black);
%opens a window in the most external screen and colors it)
Screen('BlendFunction', window, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
%Anti-aliasing or something? It's from a tutorial
ifi = Screen('GetFlipInterval', window);
%Drawing intervals; used to change the screen to animate the image
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
%The size of the screen window in pixels
[xCenter, yCenter] = RectCenter(windowRect);
%The center of the screen window

loopTime = .75;
loopFrames = round(loopTime / ifi) + 1;

Screen('FillRect', window, grey);
Screen('Flip', window);

loop = 3;
start = pi / loop;
loopTime = .75;
ifi = 0.0167;
loopFrames = round(loopTime / ifi) + 1;
halfLoop = floor(loopFrames / 2);
steps = loopFrames * loop;
minSpace = 40;
rotateLoops = 0;
pushloops = 1;
rng('shuffle');
screenXpixels = 1280;
screenYpixels = 1024;
xCenter = screenXpixels /2;
yCenter = screenYpixels /2;
scale = screenYpixels/10;


points = getPoints(loop, loop * loopFrames);
totalpoints = numel(points)/2;

Breaks = makeBreaks('equal', totalpoints, loop, loopFrames, minSpace);
points = rotateGaps(points, totalpoints, loopFrames, Breaks, rotateLoops, pushloops);
%Breaks = [];

xpoints = ((points(:, 1) .* scale) + yCenter);
ypoints = ((points(:, 2) .* scale) + yCenter);
points = [xpoints ypoints];

Screen('FillRect', window, grey);
Screen('Flip', window);
%for p = 1:totalpoints - 2
for p = 1:totalpoints
    if ~any(p == Breaks) && ~any(p+1 == Breaks)
        Screen('DrawLine', window, black, points(p, 1), points(p, 2), ...
            points(p+1, 1), points(p+1, 2), 5);
    end
end

%The midpoint of the first loop
midx = (points(1, 1)+points(halfLoop, 1))/2;
midy = (points(1, 2)+points(halfLoop, 2))/2;
Screen('DrawDots', window, [midx midy], 5, [1 0 0], [], 2);
Screen('DrawLine', window, black, points(1, 1), points(1, 2), ...
    midx, midy, 5);
Screen('DrawLine', window, black, midx, midy, ...
    points(halfLoop, 1), points(halfLoop, 2), 5);

disp(dist(points(1, 1), points(1, 2), points(halfLoop-1,1), points(halfLoop-1,2)))
disp(dist(points(halfLoop, 1), points(halfLoop, 2), points(halfLoop+halfLoop-1,1), points(halfLoop+halfLoop-1,2)))
disp(dist(points(halfLoop+halfLoop, 1), points(halfLoop+halfLoop, 2), points(halfLoop+halfLoop+halfLoop-1,1), points(halfLoop+halfLoop+halfLoop-1,2)))

baseRect = [0 0 1280 1024];
centeredRect = CenterRectOnPointd(baseRect, xCenter, yCenter);
rectColor = [1 0 0];

Screen('FrameRect', window, rectColor, centeredRect);

Screen('DrawingFinished', window);
%t1 = GetSecs;
vbl = Screen('Flip', window);
%puts the image on the screen
KbStrokeWait;
%blanks the screen
sca
end

function [distance] = dist(x1, y1, x2, y2)
    distance = sqrt((x1 - x2)^2 + (y2 - y1)^2);
end

function [points] = getPoints(loops, steps)
    start = pi/loops;
    theta = linspace(start, start + 2*pi, steps);
    thetalist = reshape(theta, [numel(theta), 1]);
    rholist = zeros([numel(theta), 1]);
    for m = 1:numel(theta)
        rholist(m, 1) = 1 + cos(loops*thetalist(m, 1));
    end
    %Creates two arrays; theta and rho. Theta defines the intervals and
    %distance around the circle, while rho looks at the amplitude.

    points = zeros([numel(theta), 2]);


    for m = 1:numel(theta)
        points(m, 1) = rholist(m, 1)*cos(thetalist(m, 1));
        points(m, 2) = rholist(m, 1)*sin(thetalist(m, 1));
    end

    %The polar coordinates from theta and rho are translated into Cartesian
    %coordinates. For a brief explanation, see
    %https://www.mathsisfun.com/polar-cartesian-coordinates.html
end

function [Breaks] = makeBreaks(breakType, totalpoints, loops, loopFrames, minSpace)
    if strcmp(breakType, 'equal')
        Breaks = int16(linspace(loopFrames, totalpoints, loops));

    elseif strcmp(breakType, 'random')
        Breaks = randi([1 (loops*loopFrames)], 1, loops-1);
        x = 1;
        y = 2;
        while x <= numel(Breaks)
            while y <= numel(Breaks)
                if x ~= y && abs(Breaks(x) - Breaks(y)) < minSpace || Breaks(x) < minSpace ||...
                        (loops*loopFrames) - Breaks(x) < minSpace
                    Breaks(x) =  randi([1, (loops*loopFrames)], 1, 1);
                    x = 1;
                    y = 0;
                end
                y = y + 1;
            end
            x = x + 1;
            y = 1;
        end

    else
        Breaks = [];
    end
end

function [rpoints] = rotateGaps(points, totalpoints, loopFrames, Breaks, rotateLoops, pushloops)
    petalnum = 0;
    rpoints = points;
    halfLoop = floor(loopFrames / 2);

    %move to origin
    for m = 1:totalpoints-1 
        if any(m == Breaks)
            petalnum = petalnum + 1;
        end
        rpoints(m, 1) = points(m, 1) - points(halfLoop + (loopFrames * petalnum), 1) / 2;
        rpoints(m, 2) = points(m, 2) - points(halfLoop + (loopFrames * petalnum), 2) / 2;
    end  

    nrpoints = rpoints;
    f = randi(360);

    if rotateLoops
        %rotate (not transform-dependent)
        for m = 1:totalpoints-1
            if any(m == Breaks)
                f = randi(360);
            end 
            rpoints(m, 1) = nrpoints(m, 1)*cos(f) - nrpoints(m, 2)*sin(f);
            rpoints(m, 2) = nrpoints(m, 2)*cos(f) + nrpoints(m, 1)*sin(f);
        end
    end

    nrpoints = rpoints;
    petalnum = 0;

    %push based on new tip direction.
    if pushloops
        for m = 1:totalpoints-1
            if any(m == Breaks)
                petalnum = petalnum + 1;
            end
            rpoints(m, 1) = nrpoints(m, 1) + (points(halfLoop + (loopFrames * petalnum), 1) *1);
            rpoints(m, 2) = nrpoints(m, 2) + (points(halfLoop + (loopFrames * petalnum), 2) *1);
        end
    end
end

function [rpoints] = rotatePoint(points, totalpoints, loopFrames, Breaks, rotateLoops)
    petalnum = 0;
    rpoints = points;
    halfLoop = floor(loopFrames / 2);
end