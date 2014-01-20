function plotActivityVsTime(Conditions)


%% Unpack Conditions
%mice = extractMice(Conditions);
%blocks = extractBlocks(mice);


%% Plot Conditions seperately
for iCond = 1:length(Conditions)
    % Find day2night, night2day transitions
    Conditions(iCond).mouse = findTimeOfDayTransitions(Conditions(iCond).mouse);
    
    % Calculate subplot dims
    dims = calculateSubplotDims(Conditions(iCond).nMice, 'ver');
    
    % plot each mouse
    figure
    for iMouse = 1:Conditions(iCond).nMice
        subplot(dims(1), dims(2), iMouse)
        currAx = gca;
        % plot activity data
        plot(Conditions(iCond).mouse(iMouse).allDisplacement.lp80, 'k', 'LineWidth', 1, 'color', [191/255, 0 ,0])
        set(currAx, 'color', [.8 .8 .8])
        % add lines for start of day/night
        addVLine(currAx, Conditions(iCond).mouse(iMouse).day2night, [0, 0, 1])
        addVLine(currAx, Conditions(iCond).mouse(iMouse).night2day, [1, 111/255, 0])
        
        ylabel('displaced pixels/hour')
        xlabel('elapsed frames')
    end
    subplotTitle(Conditions(iCond).name);
    
    % save plot
    %export_fig(fullfile('~/Pictures/hcccAnalysis/activityVsTimePlots/', [Conditions(iCond).name, '_activityVsTime_1hrSmoothed']))
end


%% Internal Functions

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