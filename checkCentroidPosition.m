function inROI = checkCentroidPosition(centroids, roi)
% inROI = checkCentroidPosition(centroids, roi)
%
% Tests if each centroid in a list of centroids is within an roi
% Returns a boolean list inROI of length centroids

for i = 1:length(centroids)
    if [centroids(i,:) >= roi.topLeft, centroids(i,:) <= roi.bottomRight]
        inROI(i) = true;
    else
        inROI(i) = false;
    end
end