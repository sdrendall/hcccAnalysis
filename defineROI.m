function [roi, name] = defineROI(im, varargin)
% ROI = defineROI(im)
% 
% Prompts user to define a struct ROI within a sample image
% Returns coordinates corresponding to corners of the ROI
% Returns user defined name
%
% By default, prompts user for four inputs (rectangle)
%
% ROI contains the following feilds:
%   topLeft
%   topRight
%   bottomLeft
%   bottomRight

% Prompt user to enter an ROI name
name = inputdlg('Enter ROI name');

% Display image and gather input
figure, imshow(im)
[x, y] = ginput(4);
close gcf

% Organize output
roi.topLeft = [min(x), min(y)];
roi.topRight = [max(x), min(y)];
roi.bottomLeft = [min(x), max(y)];
roi.bottomRight = [max(x), min(y)];