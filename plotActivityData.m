function plotActivityData(Conditions)
% plotActivityData(Conditions)
%
% main function for plotting activity data

nConds = length(Conditions);
% Find time of day transitions
for iCond = 1:nConds
    Conditions(iCond).mouse = findTimeOfDayTransitions(Conditions(iCond).mouse);
    
    
    % Average activity day vs night
    % 5 subplots comparing mice in each condition
    
    Conditions(iCond).mouse = getAvgMouseActivity(Conditions(iCond).mouse);
    Conditions(iCond).avgActivity = [Conditions(iCond).mouse(:).avgActivity];
end


% 1 main plot comparing each condition
% Get Data
summaryActivityData = aggregateVectors(Conditions(:).avgActivity);
% export to csv since I cant figure out how to make the plot I want...
%csvwrite('activityByCondition.csv', summaryActivityData)
fig1 = figure;
xlabels = {Conditions(:).name};
axes1 = axes('Parent', fig1, 'XTickLabel', xlabels);
box(axes1, 'on')
hold(axes1, 'all')
notBoxPlot(summaryActivityData, [], 0.2)
ylabel('Average Pixels Moved per Frame')
title('Average total activity of mice in each condition')
hold off




% Activity during day vs night

% Extract mice and blocks, who wants conditions....
mice = extractMice(Conditions);
blocks = extractBlocks(mice);

% Get Data
nightVsDay_all = getAllActivityData_DayVsNight(blocks);
%csvwrite('allActivity_nightVsDay.csv')
fig2 = figure;
xlabels = {'day', 'night'};
axes2 = axes('Parent', fig2, 'XTickLabel', xlabels);
box(axes2, 'on')
hold(axes2, 'all')
notBoxPlot(nightVsDay_all, [], 0.2)
ylabel('Average Pixels Moved per Frame')
title('Average activity, day vs night')
hold off




% Plot for each condition
fig3 = figure;
for iCond = 1:nConds
    % Get a nightVsDay matrix for each condition
    nightVsDay_byCondition{iCond} = getAllActivityData_DayVsNight([blocks(strcmp({blocks(:).conditionName}, Conditions(iCond).name))]);
    currPlot = subplot(1,5,iCond, 'XTickLabel', xlabels);
    %currAxes = axes('Parent', currPlot, 'XTickLabel', xlabels);
    %box(currAxes, 'on')
    %hold(currAxes, 'all')
    hold on
    notBoxPlot(nightVsDay_byCondition{iCond}, [], 0.2)
    ylabel('Average Pixels Moved per Frame')
    title(Conditions(iCond).name)
    hold off
end
subplotTitle('Average activity, day vs night, each condition')

figure
for iCond = 1:nConds
    subplot(1,5,iCond)
    for iMouse = 1:Conditions(iCond).nMice
        [dayActivity, nightActivity] = getMouseActivity_dayVsNight(Conditions(iCond).mouse(iMouse));
        plot([mean(dayActivity(~isnan(dayActivity))), mean(nightActivity(~isnan(nightActivity)))], 'o--', 'markerfacecolor', 'g')
        hold on
    end
    hold off
    title(Conditions(iCond).name)
    xlim([0,3])
    set(gca, 'XTickLabel', {'', 'day', 'night', ''})
end





% Activity v time plots

% Each mouse, show start of day and night


function [dayActivity, nightActivity] = getMouseActivity_dayVsNight(mouse)
nightActivity = [mouse.tlBlock(strcmp({mouse.tlBlock(:).timeOfDay}, 'night')).avgDisplacement];
dayActivity = [mouse.tlBlock(strcmp({mouse.tlBlock(:).timeOfDay}, 'day')).avgDisplacement];



function nvd = getAllActivityData_DayVsNight(blocks)
nightActivity = [blocks(strcmp({blocks(:).timeOfDay}, 'night')).avgDisplacement];
dayActivity = [blocks(strcmp({blocks(:).timeOfDay}, 'day')).avgDisplacement];
nvd = aggregateVectors(dayActivity, nightActivity);



