function plotConditions(Conditions)
% plotConditions(Conditions)
%
% plotting function for the data in the Conditions structure


% ACTIVITY DATA

% Plot all activity data
figure
for iCond = 1:length(Conditions)
    for iMouse = 1:Conditions.nMice
        plot([Conditions(iCond).mouse(iMouse).displacement.raw])
        hold on
    end
end


% Plot mean activity during day vs night

% Plot 