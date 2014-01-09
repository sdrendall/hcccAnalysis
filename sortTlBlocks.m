function sortedBlocks = sortTlBlocks(blocks)
% sortedBlocks = sortTlBlocks(blocks)
%
% sorts tlBlocks so they are indexed in order of ascending blockNo

% Add some tests for correct block numbering here
sortedBlocks = [];
for i = 1:length(blocks)
sortedBlocks = [sortedBlocks; blocks([blocks(:).blockNo] == i)];
end