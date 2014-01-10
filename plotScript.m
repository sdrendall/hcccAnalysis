%function getMousePositionData
for iROI = 1:mouse.nROIs
    inds = getBlocksOfInterest(mouse, iROI);
    dataToPlot(iROI, :) = [sum([mouse.tlBlock(inds).inROI]), sum(1 - [mouse.tlBlock(inds).inROI])];
end

dataToPlot

figure, h = notBoxPlot(dataToPlot, [], 0);