for iMouse = 1:length(mice)
    %% Plot Activity Vs time, showing heat
    % Get hot and cold data
    hotDisplacement = [mice(iMouse).tlBlock(mice(iMouse).hotBlocks).rawDisplacement];
    coldDisplacement = [mice(iMouse).tlBlock(mice(iMouse).coldBlocks).rawDisplacement];
    
    % Plot
    figure
    subplot(2,1,1)
    plot(hotDisplacement, 'color', 'r')
    title('Heated Room')
    ylabel('Average pixels displaced')
    subplot(2,1,2)
    plot(coldDisplacement, 'color', 'b')
    title('Cold Room')
    subplotTitle(['Avg Activity vs Time -- Mouse No: ', num2str(mice(iMouse).mouseNo)])
    ylabel('Average pixels displaced')
    
    %% Plot some avgs and day vs night stats
    allAvgs(iMouse, :) = [mean(hotDisplacement), mean(coldDisplacement)];
    
    hotDayDisp = [mice 
end

figure, notBoxPlot(allAvgs);