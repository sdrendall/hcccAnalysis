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
if nMice == 1
    dims = [1, 1];
elseif nMice == 2
    dims = [1, 2];
elseif nMice <= 6
    dims = [2, 3];
elseif nMice <= 8
    dims = [2, 4];
else
    dims = [3, 4];
    dimProd = 12;
    while dimProd < nMice
        dims = dims + [1 , 2];
        dimProd = dims(1)*dims(2);
    end
end

% Plot each mouse
figure
for iMouse = 1:nMice
    subplot(dims(1), dims(2), iMouse)
    notBoxPlot(normalizeArray(getMousePositionData(mice(iMouse))) * 100, [], 0)
    title(['Mouse No: ', num2str(iMouse), ' Condition: ', mice(iMouse).parentName])
    ylabel('% frames')
    setXlabel(mice(iMouse).parentName)
end

subplotTitle('All mice, each point indicates a new platform position/room assignment')

% Plot all mice in one figure
%figure
%for iMouse = 1:nMice
    









function setXlabel(parName)
switch lower(parName)
    case 'halffloor'
        xlabel('1 = Time spent on platform, 2 = Time spent off of platform')
    case 'room'
        xlabel('1 = Time spent in room, 2 = Time spent out of room')
end