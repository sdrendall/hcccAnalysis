function [roiSwitchInd, nROIs] = findDistinctROIs(mouse)
% nROIs = countDistinctROIs(mouse)
%
% Returns the number of distinct rois present in a set of timelapse blocks
% Input is a mouse structure
% Output is a double


% First ROI is always distinct
roiSwitchInd = 1;

daytimes = {mouse.tlBlock(:).timeOfDay};
for i = 2:mouse.nBlocks
    if strcmpi(daytimes{i}, daytimes{i-1});
        roiSwitchInd = [roiSwitchInd, i];
    end
end

nROIs = length(roiSwitchInd);