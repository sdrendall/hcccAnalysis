function activityMain
% Main Script for hccc behavior analysis 

startPath = '/Users/churchman/Desktop/SamR/timelapseAnalysis_1-8-14/';

% Load all images, for all mice, in each condition
Conditions = loadConditions(startPath);
                 
for iPath = 1:length(dirPaths)
    % Store Condition name and dirPath
    Conditions(iPath).name = condName{iPath};
    Conditions(iPath).dirPath = dirPaths{iPath};
    
    % Get Image Paths
    [Conditions(iPath).imagepaths, Conditions(iPath).imageFilenames] = getImagePath();
    
    % Designate ROIs
    Conditions(iPath).roi = defineROI(Conditions(iPath).imagepaths{1});
end

for i = 1:length(Conditions)
% Find Centroids
Conditions(i).centroids = findMouse(Conditions(i).imagepaths);

% Time Spent in ROI
[Conditions(i).location.inROI, Conditions(i).location.notInROI] = catagorizeCentroids(Conditions(i).centroids, Conditions(i).roi);


% Detect Activity
 % Calculate Centroid Displacement
Conditions(i).displacement.raw = calculateCentroidDisplacement(Conditions(i).centroids);
 % Lowpass filter?
Conditions(i).displacement.lp80 = smoothVector(Conditions(i).displacement.raw, 80);
 % Bin
Conditions(i).displacement.bin27 = binVector(Conditions(i).displacement.raw, 27, 'mean'); 
end

% Save Results
[savefile, savepath] = uiputfile;
save([savepath, savefile], 'Conditions');

%figure, bar([length(inROI), length(notInROI)])
%figure, plot(displacement)







