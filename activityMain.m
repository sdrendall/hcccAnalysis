function activityMain
% Main Script for hccc behavior analysis 

% Load Images
[paths, filenames] = getImagePath;

% Find Centroids
centroids = findMouse(paths);

% Time Spent in ROI
 % Determine ROI
[roi, name] = defineROI(paths{1});

 % Seperate centroids
[inROI, notInROI] = catagorizeCentroids(centroids, roi);

% Detect Activity
 % Calculate Centroid Displacement
displacement = calculateCentroidDisplacement(centroids);
 % Lowpass filter?
%displacement = filter(displacement, [1/3, 1/3, 1/3];
 
% Display Results

figure, bar([inROI, notInROI])
figure, plot(displacement)