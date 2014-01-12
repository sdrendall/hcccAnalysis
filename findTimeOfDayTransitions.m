function mouse = findTimeOfDayTransitions(mouse)
% [day2night, night2day] = findTimeOfDayTransitions(mouse)
%
% [day2night, night2day]
%
% Returns indicies corresponding to the images(paths, datapoints w/e) where
% the time of day switches from day to night

mouse = appendFields(mouse, {'day2night', 'night2day'});

if length(mouse) > 1
    for iMouse = 1:length(mouse)
        [mouse(iMouse)] = findTimeOfDayTransitions(mouse(iMouse));
    end
else
    if mouse.nBlocks <= 1
        return
    else
        for iBk = 1:(mouse.nBlocks - 1)
            % Get current and next block's time of days
            currTime = mouse.tlBlock(iBk).timeOfDay;
            nextTime = mouse.tlBlock(iBk + 1).timeOfDay;
            
            if ~strcmp(currTime, nextTime)
                if strcmp(currTime, 'day') && strcmp(nextTime, 'night')
                    mouse.day2night(end + 1) = sum([mouse.tlBlock(1:iBk).nFrames]) + 1;
                elseif strcmp(currTime, 'night') && strcmp(nextTime, 'day')
                    mouse.night2day(end + 1) = sum([mouse.tlBlock(1:iBk).nFrames]) + 1;
                end
            end
        end
    end
end