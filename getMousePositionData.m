function dataToPlot = getMousePositionData(mouse)
% dataToPlot = getMousePositionData(mouse)
%
% returns a mouse.nROIx2 array containing the number of times the mouse's centroid was and
% was not in the ROI

for iROI = 1:mouse.nROIs
    inds = getBlocksOfInterest(mouse, iROI);
    dataToPlot(iROI, :) = [sum([mouse.tlBlock(inds).inROI]), sum(1 - [mouse.tlBlock(inds).inROI])];
end
