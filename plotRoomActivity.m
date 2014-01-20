function plotRoomActivity(Conditions)
%% Extract mice and blocks from the 'room' condition
mice = extractMice(Conditions(strcmp({Conditions(:).name}, 'room')));
blocks = extractBlocks(mice);

%% Get transition indicies
% Adds fields day2night, night2day
mice = findTimeOfDayTransitions(mice);
% Adds fields in2out, out2in
mice = findRoiTransitions(mice);

%% Plot
% Calculate subplot dims
dims = calculateSubplotDims(length(mice), 'ver');
% Find max y value (displacement)
%maxDisp = max([mice(:).allDisplacement.raw]);

% Plot entire time course
figure
for iMouse = 1:length(mice)
    % Initialize subplot
    subplot(dims(1), dims(2), iMouse)
    currAx = gca;
    % Plot data
    plot(mice(iMouse).allDisplacement.raw, 'k')
    % Add lines for start of day and night
    addVLine(currAx, mice(iMouse).day2night, [0,0,1])
    addVLine(currAx, mice(iMouse).night2day, [1, 111/255, 0])
    % Add shading when mouse is in room
    addPatches(currAx, mice(iMouse).in2out, mice(iMouse).out2in)
end

figure
% Plot in room and out of room
oddInds = [1, 3, 5, 7];
evenInds = [2, 4, 6, 8];
for iMouse = 1:length(mice)
    % Initialize subplot
    subplot(4, 2, oddInds(iMouse))
    currAx = gca;
    % Plot data
    plot(mice(iMouse).allDisplacement.raw([mice(iMouse).tlBlock(:).inROI]))
    title('in ROI')
    subplot(4, 2, evenInds(iMouse))
    plot(mice(iMouse).allDisplacement.raw(~[mice(iMouse).tlBlock(:).inROI]))
    title('out of ROI')
end
    
function addPatches(ax, out2in, in2out)
% get ylim
ylims = get(ax, 'ylim');
xlims = get(ax, 'xlim');
% plot patches
hold on
for i = 1:length(out2in)
    startPoint = out2in(i);
    stopPoint = min(in2out(in2out >= startPoint));
    if isempty(stopPoint)
        stopPoint = xlims(2);
    end
    patch([startPoint, stopPoint, stopPoint, startPoint], [ylims(1), ylims(1), ylims(2), ylims(2)], 'r', 'FaceAlpha', .2, 'EdgeAlpha', 0)
end
hold off

function addVLine(ax, x, clr)
if ~exist('clr', 'var')
    clr = [0,0,1];
end

hold on
for i = 1:length(x)
    ylims = get(ax, 'YLim');
    plot([x(i),x(i)], ylims, 'color', clr)
end
hold off
