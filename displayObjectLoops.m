function [] = displayObjectLoops(compareLoops, loopFrames, breakType, ...
    minSpace, rotateLoops, xscale, yscale, xCenter, yCenter, window, ...
    displayTime, pauseTime, screenNumber)
%%%%%%FUNCTION DESCRIPTION
%displayObjectLoops is a function for displaying the loop images
%It requires a window and the argument parameters above
%It is not made for standalone use.
%%%%%%%%%%%%%%%%%%%%%%%%%
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);
grey = white/2;
for loop = compareLoops
    points = getPoints(loop, loop * loopFrames);
    totalpoints = numel(points)/2;
    
    Breaks = makeBreaks(breakType, totalpoints, loop, loopFrames, minSpace);
    points = rotateGaps(points, totalpoints, loopFrames, Breaks, rotateLoops);
    
    xpoints = (points(:, 1) .* xscale) + xCenter;
    ypoints = (points(:, 2) .* yscale) + yCenter;
    points = [xpoints ypoints];
    
    Screen('FillRect', window, grey);
    Screen('Flip', window);
    for p = 1:totalpoints - 2
        if ~any(p == Breaks) && ~any(p+1 == Breaks)
            Screen('DrawLine', window, black, points(p, 1), points(p, 2), ...
                points(p+1, 1), points(p+1, 2), 5);
        end
    end
    Screen('DrawingFinished', window);
    %t1 = GetSecs;
    vbl = Screen('Flip', window);
    %puts the image on the screen
    Screen('FillRect', window, black);
    WaitSecs(displayTime);
    vbl = Screen('Flip', window);
    %blanks the screen
    WaitSecs(pauseTime);
end
end