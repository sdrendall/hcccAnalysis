function tlBlocks = loadTimelapseBlocks(path)
% tlBlocks = loadTimelapseBlocks(path)
%
% loads timelapse blocks -- for timelapse analysis
% timelapse blocks are structures containing:
%   blockNo - number of the block, to ensure correct order
%   timeOfDay - string specifying day or night
%   imagePaths - paths to image files


if ~exist('path', 'var')
    path = uigetdir('~', 'Specify directory containing timelapse blocks');
end

path = checkPathSlash(path);

% Gather info about blocks, from dir()
tlBlocksIn = dirNoDot(path, 'd');

for i = 1:length(tlBlocksIn)
    % Determine block number and time of day
    delim = strfind(tlBlocksIn(i).name, '-');
    % Remove incompatible directories
    if length(delim) > 1 || isempty(delim)
        warning(['Invalid directory name "', tlBlocksIn(i).name, '" encountered. Removing from structure.  Path to directory:', path, tlBlocksIn(i).name]);
    end
    % Store block number and time of day
    tlBlocksIn(i).blockNo = str2num(tlBlocksIn(i).name(1:delim - 1));
    tlBlocksIn(i).timeOfDay = tlBlocksIn(i).name(delim + 1:end);
    % Concatenate base path
    tlBlocksIn(i).basePath = [path, tlBlocksIn(i).name];
    % Get image paths
    tlBlocksIn(i).imagePaths = getImagePath(tlBlocksIn(i).basePath);
    % Get number of frames
    tlBlocksIn(i).nFrames = length(tlBlocksIn(i).imagePaths);
end
    
tlBlocks = sortTlBlocks(tlBlocksIn);