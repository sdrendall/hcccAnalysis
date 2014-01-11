function data = condensePositionByCondition(mice)
% data = condensePositionByCondition(mice)
%
% Returns structure 'data' containing:
%  allAvgPosData -- Vertical concatenation of all avg position data for
%   each mouse in a given condition name
%  condName -- String corresponding to the name of the condition relating
%   the mice the data in allAvgPosData was taken from

% Get unique condition names
condNames = unique({mice(:).parentName});

% Store data in data array for each condition name
for iCond = 1:length(condNames)
    % Take all mice of each condName
    currMice = mice(strcmp(condNames{iCond}, {mice(:).parentName}));
    % Initialize data structure
    data(iCond).allAvgPosData = currMice(1).avgPositionData;
    % If more than one mouse is in the condition, vertically concatenate
    % all position data
    if length(currMice) > 1
        for iMouse = 2:length(currMice)
            data(iCond).allAvgPosData = [data(iCond).allAvgPosData; currMice(iMouse).avgPositionData];
        end
    end
    % Set name
    data(iCond).condName = condNames{iCond};
end