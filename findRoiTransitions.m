function mouse = findRoiTransitions(mouse)
% mouse = findRoiTransitions(mouse)
%
% Finds the indicies correspoding to points in time where a mouse leaves
% and enters a specified roi
%
% Returns the given mouse structure with the new fields in2out and out2in
%
% Each index corresponds to the last frame a mouse was in a certain
% location before switching

%% Add output fields if they don't exist
if ~(isfield(mouse, 'in2out') && isfield(mouse,'out2in'))
    mouse = appendFields(mouse, {'in2out', 'out2in'});
end

if length(mouse) > 1
    %% Unpack mice and recurse if passed several mice
    for iMouse = 1:length(mouse)
        mouse(iMouse) = findRoiTransitions(mouse(iMouse));
    end
    
else
    %% Extract blocks from each mouse, concatenate all inROI booleans, initialize output variables
    blocks = extractBlocks(mouse);
    inROI_allFrames= [blocks(:).inROI];
    % set first index
    if inROI_allFrames(1)
        mouse.out2in = 1;
    else
        mouse.in2out = 1;
    end
    %% Test each pair of consecutive frames for a switch in inROI
    for iFrame = 1:(length(inROI_allFrames)-1)
        if inROI_allFrames(iFrame) == 1 && inROI_allFrames(iFrame + 1) == 0
            mouse.in2out(end + 1) = iFrame;
        elseif inROI_allFrames(iFrame) == 0 && inROI_allFrames(iFrame + 1) == 1
            mouse.out2in(end + 1) = iFrame;
        end
    end
end


