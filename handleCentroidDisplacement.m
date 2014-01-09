function mouse = handleCentroidDisplacement(mouse)
% mouse = handleCentroidDisplacement(mouseIn)
%
% Updates the mouse and tlBlock structures with values corresponding to 
% a mouse's centroid displacement from one frame to the next

% Unpack centroids, mark index to start of each new block
mouse.allCentroids = [];
mouse.blockToMasterInd = zeros(1, mouse.nBlocks);
for iBk = 1:mouse.nBlocks
    mouse.blockToMasterInd(iBk) = length(mouse.allCentroids) + 1;
    mouse.allCentroids = [mouse.allCentroids(:); mouse.tlBlock(iBk).centroids(:)];
end

mouse.allDisplacement = calculateCentroidDisplacement(mouse.allCentroids);

% Store diplacement values into tlBlocks
for iBk = 1:(mouse.nBlocks - 1)
    mouse.tlBlock(iBk).displacement = mouse.allDisplacement(mouse.blockToMasterInd(iBk):mouse.blockToMasterInd(iBK + 1));
end
mouse.tlBlock(mouse.nBlocks).displacement = mouse.allDisplacement(mouse.blockToMasterInd(mouse.nBlocks):end);