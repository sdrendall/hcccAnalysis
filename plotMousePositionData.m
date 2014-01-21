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


% Get the data
for iMouse = 1:nMice
    [mice(iMouse).rawPositionData, mice(iMouse).asPercentagePositionData] = getMousePositionData(mice(iMouse));
    mice(iMouse).avgPositionData = mean(mice(iMouse).asPercentagePositionData, 1);
end


% Plot each mouse seperately
% Calculate subplot dimensions
dims = calculateSubplotDims(nMice);

% Plot each mouse
figure
for iMouse = 1:nMice
    subplot(dims(1), dims(2), iMouse)
    notBoxPlot(mice(iMouse).asPercentagePositionData * 100, [], .2)
    title(['Mouse No: ', num2str(iMouse), ' Condition: ', mice(iMouse).parentName])
    ylabel('% frames')
    setXLabel(mice(iMouse).parentName)
    ylim([0 100])
end
subplotTitle('All mice, each point indicates a new platform position/room assignment')

% Plot all mice in each condition in one summarizing figure
summaryData = condensePositionByCondition(mice);
dims = calculateSubplotDims(length(summaryData));
figure
for iCond = 1:length(summaryData)
    subplot(dims(1), dims(2), iCond)
    notBoxPlot(summaryData(iCond).allAvgPosData * 100, [], .1)
    title(['Condition: ', summaryData(iCond).condName])
    ylabel('% frames')
    setXLabel(summaryData(iCond).condName)
    ylim([0, 100])
end
subplotTitle('Percentage of frames mice in each condition spent in vs out of ROI.  Points represent individual mice')




%---------------INTERNAL FUNCTIONS----------------------------------------

function setXLabel(parName)
switch lower(parName)
    case 'halffloor'
        %xlabel('1 = Frames on platform, 2 = Frames off platform')
        set(gca, 'XTickLabel', {'On Platform', 'Off Platform'})
    case 'room'
        %xlabel('1 = Frames in room, 2 = Frames out of room')
        set(gca, 'XTickLabel', {'In Room', 'Out of Room'})
end