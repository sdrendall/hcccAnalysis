function plotActivityVsTime(Conditions)


%% Unpack Conditions
mice = extractMice(Conditions);
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
        %set(currAx, 'color', [.8 .8 .8])
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

%% Plot Averages of Each Block over Time
figure
for iCond = 1:length(Conditions)
    subplot(5, 1, iCond)
    for iMouse = 1:Conditions(iCond).nMice
        avgDisplacementVect{iMouse} = [Conditions(iCond).mouse(iMouse).tlBlock(:).avgDisplacement];
    end
    allData = aggregateVectors(avgDisplacementVect{:})';
    maxBlocks = max([Conditions(iCond).mouse(:).nBlocks]);
    % Remove NaNs from data
    for iBk = 1:maxBlocks
        currBlocksData = allData(:,iBk);
        currBlocksData = currBlocksData(~isnan(currBlocksData));
        avgData(iBk) = mean(currBlocksData);
        stDev(iBk) = std(currBlocksData);
    end        
    errorbar(1:maxBlocks, avgData, stDev, 'k')
    title(['\bf ', Conditions(iCond).name])
    %xlabel('Block Number')
    ylabel('Average Pixels Displaced')
    hold on
    
    % plot markers
    longestMouse = find([Conditions(iCond).mouse(:).nBlocks] == maxBlocks, 1);
    nightBlocks = strcmp({Conditions(iCond).mouse(longestMouse).tlBlock(:).timeOfDay}, 'night');
    dayBlocks = strcmp({Conditions(iCond).mouse(longestMouse).tlBlock(:).timeOfDay}, 'day');
    plot(find(nightBlocks), avgData(nightBlocks), 'o', 'MarkerFaceColor', [0, 0, 1], 'MarkerEdgeColor', [0, 0, 1])
    plot(find(dayBlocks), avgData(dayBlocks), 'o', 'MarkerFaceColor', [1, 111/255, 0], 'MarkerEdgeColor', [1, 111/255, 0])
    clear avgDisplacementVect avgData stDev
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