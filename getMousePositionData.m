function [rawData, asPercentage] = getMousePositionData(mouse)
% [rawData, asPercentage] = getMousePositionData(mouse)
%
% returns a mouse.nROIx2 array containing the number of times the mouse's centroid was and
% was not in the ROI
%
% asPercentage is indexed identically to rawData except each data point corresponds
% to a percentage of the maximum possible value 

for iROI = 1:mouse.nROIs
    inds = getBlocksOfInterest(mouse, iROI);
    asPercentage(iROI, :) = [sum([mouse.tlBlock(inds).inROI])/length([mouse.tlBlock(inds).inROI]), sum(1 - [mouse.tlBlock(inds).inROI])/length([mouse.tlBlock(inds).inROI])];
    rawData(iROI, :) = [sum([mouse.tlBlock(inds).inROI]), sum(1 - [mouse.tlBlock(inds).inROI])];
end
