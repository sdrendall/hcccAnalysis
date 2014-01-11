function handles = plotMousePositionData(Conditions) %#ok<STOUT>
% handles = plotMousePositionData(Conditions)
%
% Plots the positional data for the mice in the specified conditions. 
% Returns a structure handles containing the handles for each plot

% Ensure that input Conditions only contains structures including ROI data
Conditions = Conditions(~[Conditions(:).activityOnly]);
% Extract mice, for convenience
mice = extractMice(Conditions);
nMice = length(mice);

% Plot each mouse seperately
% Calculate subplot dimensions
dims = calculateSubplotDims(nMice);

% Plot each mouse
figure
for iMouse = 1:nMice
    subplot(dims(1), dims(2), iMouse)
    notBoxPlot(normalizeArray(getMousePositionData(mice(iMouse))) * 100, [], .2)
    title(['Mouse No: ', num2str(iMouse), ' Condition: ', mice(iMouse).parentName])
    ylabel('% frames')
    setXLabel(mice(iMouse).parentName)
end

subplotTitle('All mice, each point indicates a new platform position/room assignment')

% Plot all mice in one figure
%figure
%for iMouse = 1:nMice
    









function setXLabel(parName)
switch lower(parName)
    case 'halffloor'
        xlabel('1 = Frames on platform, 2 = Frames off platform')
    case 'room'
        xlabel('1 = Frames in room, 2 = Frames out of room')
end