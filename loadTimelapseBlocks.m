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
tlBlocks = dirNoDot(path, 'd');

for i = 1:length(tlBlocks)
    % Determine block number and time of day
    delim = strfind(tlBlocks(i).name, '-');
    % Remove incompatible directories
    if length(delim) > 1 || isempty(delim)
        warning(['Invalid directory name "', tlBlocks(i).name, '" encountered. Removing from structure.  Path to directory:', path, tlBlocks(i).name]);
    end
    % Store block number and time of day
    tlBlocks(i).blockNo = str2num(tlBlocks(i).name(1:delim - 1));
    tlBlocks(i).timeOfDay = tlBlocks(i).name(delim + 1:end);
    % Concatenate base path
    tlBlocks(i).basePath = [path, tlBlocks(i).name];
    % Get image paths
    tlBlocks(i).imagePaths = getImagePath(tlBlocks(i).basePath);
end
    