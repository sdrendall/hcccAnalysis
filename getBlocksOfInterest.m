function blocksOfInterest = getNextROIBlocks(mouse, iROI)
% blocksOfInterest = getNextROIBlocks(mouse, iROI)
%
% given a mouse structure, returns a cell array of indicies corresponding
% to each set of blocks sharing a ROI
%
% given a mouse structure and a counter (iROI) corresponding to the set of
% blocks currently required, returns an array of indicies corresponding to
% those blocks (not in a cell)


if exist('iROI', 'var')
    if iROI < mouse.nROIs
        blocksOfInterest = mouse.roiSwitchInd(iROI):(mouse.roiSwitchInd(iROI + 1) - 1);
    elseif iROI == mouse.nROIs
        blocksOfInterest = mouse.roiSwitchInd(iROI):mouse.nBlocks;
    end
    
else
    for iROI = 1:mouse.nROIs
        if iROI < mouse.nROIs
            blocksOfInterest{iROI} = mouse.roiSwitchInd(iROI):(mouse.roiSwitchInd(iROI + 1) - 1);
        elseif iROI == mouse.nROIs
            blocksOfInterest{iROI} = mouse.roiSwitchInd(iROI):mouse.nBlocks;
        end
    end
end