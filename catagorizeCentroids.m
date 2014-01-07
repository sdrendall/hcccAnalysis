function [inROI, notInROI] = catagorizeCentroids(centroids, roi)
% [inROI, notInROI] = catagorizeCentroids(centroids, roi)
%
% Determines whether a list of centroids are in a specified (rectangular) roi
% Returns a list of indicies indicating which centroids are in each
% catagory

inROI = [];
notInROI = [];

for i = 1:length(centroids)
    if [centroids(i,:) >= roi.topLeft, centroids(i,:) <= roi.bottomRight]
        inROI = [inROI, i];
    else
        notInROI = [notInROI, i];
    end
end