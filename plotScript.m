%function getMousePositionData
figure
for iROI = 1:mouse.nROIs
    inds = getBlocksOfInterest(mouse, iROI);
    dataToPlot = [sum([mouse.tlBlock(inds).inROI]), sum(1 - [mouse.tlBlock(inds).inROI])];
    dataToPlot
    h = errorbar([1,2], dataToPlot, [0, 0], 'k.');
    errorbar_tick(h, 0)
    hold on
end

axis([0, 3, 0, 2000])