function mouse = getAvgMouseActivity(mouse)
% mouse = getAvgMouseActivity(mouse)
%
%


mouse = appendFields(mouse, {'avgActivity', 'avgActivityAtNight', 'avgActivityDuringDay'});

if length(mouse) > 1
    for iMouse = 1:length(mouse)
        mouse(iMouse) = getAvgMouseActivity(mouse(iMouse));
    end
else
    for iBk = 1:mouse.nBlocks
        avgActivity(iBk) = mean(mouse.tlBlock(iBk).rawDisplacement);
    end
    mouse.avgActivityAtNight = mean(avgActivity(strcmp({mouse.tlBlock(:).timeOfDay}, 'night')));
    mouse.avgActivityDuringDay = mean(avgActivity(strcmp({mouse.tlBlock(:).timeOfDay}, 'day')));
    mouse.avgActivity = mean([mouse.avgActivityAtNight, mouse.avgActivityDuringDay]);
end