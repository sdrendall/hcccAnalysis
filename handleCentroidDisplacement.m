function [allCentroids, allDisplacement, blockToMasterInd] = handleCentroidDisplacement(mouse)
% mouse = handleCentroidDisplacement(mouseIn)
%
% Updates the mouse and tlBlock structures with values corresponding to 
% a mouse's centroid displacement from one frame to the next

% Unpack centroids, mark index to start of each new block
allCentroids = [];
blockToMasterInd = zeros(1, mouse.nBlocks);
for iBk = 1:mouse.nBlocks
    blockToMasterInd(iBk) = length(allCentroids) + 1;
    allCentroids = [allCentroids; mouse.tlBlock(iBk).centroids];
end

allDisplacement.raw = calculateCentroidDisplacement(allCentroids);
allDisplacement.lp80 = smoothVector(allDisplacement.raw, 80);
allDisplacement.bin27 = binVector(allDisplacement.raw, 27, 'mean');


% Store diplacement values into tlBlocks
%for iBk = 1:(mouse.nBlocks - 1)
%    mouse.tlBlock(iBk).displacement = mouse.allDisplacement(mouse.blockToMasterInd(iBk):mouse.blockToMasterInd(iBk + 1));
%end
%mouse.tlBlock(mouse.nBlocks).displacement = mouse.allDisplacement(mouse.blockToMasterInd(mouse.nBlocks):end);