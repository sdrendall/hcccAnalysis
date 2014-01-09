function Conditions = loadConditions(startPath)
% Conditions = loadConditions(path)
%
% For timelapse data analysis

if ~exist('startPath', 'var')
    startPath = uigetdir('~', 'Specify Base Directory (contains Conditions)');
end

Conditions = dirNoDot(startPath);

for iCond = 1:length(Conditions)
    % Specify each conditions as activityOnly 
    Conditions(iCond).basePath = [startPath, Conditions(iCond).name];
    if strcmp(baseDirs(iCond).name, 'room') || strcmp(baseDirs(iCond).name, 'halfFloor')
        Conditions(iCond).activityOnly = 0;
    else
        Conditions(iCond).activityOnly = 1;
    end
    
    % Find the mice for each condition
    Conditions(iCond).mouseDirs = getDirectories(Conditions(iCond).basePath);
    Conditions(iCond).nMice = length(Conditions(iCond).mouseDirectories);
    
    % Create mice within each Condition, load timelapse blocks, add
    % basePath to each mouse structure
    for iMouse = 1:Conditions(iCond).nMice
        Conditions(iCond).mouse(iMouse).tlBlocks = loadTimelapseBlocks(Conditions(iCond).mouseDirs(iMouse));
        Conditions(iCond).mouse(iMouse).basePath = Conditions(iCond).mouseDirs(iMouse);      
    end
end