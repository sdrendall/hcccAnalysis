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
end

% 1 main plot comparing each condition
figure
for iCond = 1:nConds
    notBoxPlot([Conditions(iCond).mouse(:).avgActivity]', [], .2)
    hold on
end



% Extract mice, who wants conditions....
mice = extractMice(Conditions);


% Activity v time plots

% Each mouse, show start of day and night

% 



