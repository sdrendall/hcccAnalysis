function Conditions = loadConditions(startPath)
% Conditions = loadConditions(path)
%
% For timelapse data analysis
%   Each Condition contains:
%       name: directory name
%       basePath: path to self
%       activityOnly: should stats other than the mouse's activity be
%         measured?
%       nMice: the number of mice in the condition
%       mouse: structure containing data on a single mouse
%       as well date, bytes, datenum, isdir which are created by dir() by default
%
%
%   Each Condition.mouse contains:
%       basePath - path to self
%       tlBlock - Structure: each 'block', representing a set of consecutive images
%           partitioned based on time of day or animal transfer/cage
%           modification
%       nBlocks
%
%   Each Condition.mouse.tlBlock contains:
%       basePath: path to self
%       blockNo: block number, corresponds to the block's position in the
%           chronological order of the blocks
%       timeOfDay: whether  the images were taken during the day or night
%       imagePaths: paths to each image in the block
%
% Should I parallelize?


if ~exist('startPath', 'var')
    startPath = uigetdir('~', 'Specify Base Directory (contains Conditions)');
end

startPath = checkPathSlash(startPath);

% initializes Conditions from dir(startPath) with filtered output
Conditions = dirNoDot(startPath);

for iCond = 1:length(Conditions)
    % Specify each conditions as activityOnly 
    Conditions(iCond).basePath = [startPath, Conditions(iCond).name];
    if strcmp(Conditions(iCond).name, 'room') || strcmp(Conditions(iCond).name, 'halfFloor')
        Conditions(iCond).activityOnly = 0;
    else
        Conditions(iCond).activityOnly = 1;
    end
    
    % Find the mice for each condition
    Conditions(iCond).mouseDirs = getDirectories(Conditions(iCond).basePath);
    Conditions(iCond).nMice = length(Conditions(iCond).mouseDirs);
    
    % Create mice within each Condition, load timelapse blocks, add
    % basePath to each mouse structure
    for iMouse = 1:Conditions(iCond).nMice
        Conditions(iCond).mouse(iMouse).basePath = Conditions(iCond).mouseDirs{iMouse};
        % disp(Conditions(iCond).mouse(iMouse).basePath), pause
        Conditions(iCond).mouse(iMouse).tlBlock = loadTimelapseBlocks(Conditions(iCond).mouse(iMouse).basePath);
        Conditions(iCond).mouse(iMouse).nBlocks = length(Conditions(iCond).mouse(iMouse).tlBlock);
    end
end
