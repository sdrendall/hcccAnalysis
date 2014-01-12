function mouse = partitionDisplacement(mouse)
% mouse = partitionDisplacement(mouse)
%
% partitions the allDisplacement.raw field in a mouse structure into a
% rawDisplacement field with data points corresponding to each image in the
% tlBlock


for iBk = 1:mouse.nBlocks - 1
    mouse.tlBlock(iBk).rawDisplacement = mouse.allDisplacement.raw(mouse.blockToMasterInd(iBk):mouse.blockToMasterInd(iBk + 1) - 1);
end
mouse.tlBlock(end).rawDisplacement = mouse.allDisplacement.raw(mouse.blockToMasterInd(end):end);