function [] = animateEventLoops(compareLoops, loopFrames, ...
    minSpace, xscale, yscale, xCenter, yCenter, window, ...
    pauseTime, brk, breakTime, screenNumber, imageTexture, ...
    ifi, vbl)
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);
grey = white/2;
for loop = compareLoops
    %for each number of loops
    points = getPoints(loop, loop * loopFrames);
    totalpoints = numel(points)/2;
    Breaks = makeBreaks(brk, totalpoints, loop, loopFrames, minSpace);
    xpoints = (points(:, 1) .* xscale) + xCenter;
    ypoints = (points(:, 2) .* yscale) + yCenter;
    points = [xpoints ypoints];
    
    pt = 1;
    waitframes = 1;
    Screen('FillRect', window, grey);
    Screen('Flip', window);
    while pt <= totalpoints
        if any(pt == Breaks)
            WaitSecs(breakTime);
        end
        
        destRect = [points(pt, 1) - 128/2, ... %left
            points(pt, 2) - 128/2, ... %top
            points(pt, 1) + 128/2, ... %right
            points(pt, 2) + 128/2]; %bottom
        
        % Draw the shape to the screen
        Screen('DrawTexture', window, imageTexture, [], destRect, 0);
        Screen('DrawingFinished', window);
        % Flip to the screen
        vbl  = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);
        pt = pt + 1;
        
    end
    Screen('FillRect', window, black);
    vbl = Screen('Flip', window);
    WaitSecs(pauseTime);
end
end