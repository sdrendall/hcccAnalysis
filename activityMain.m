function activityMain
% Main Script for hccc behavior analysis 

basePath = '~/Pictures/hcccTimelapsesForJin/comfort1/';
dirPaths = {[basePath,'mouse1/day1/'],...
            [basePath,'mouse1/day2/'],...
            [basePath,'mouse2/day1/'],...
            [basePath,'mouse2/day2/'],...
            [basePath,'mouse3/day1/'],...
            [basePath,'mouse3/day2/']};
condName = {'mouse 1 day 1', 'mouse 1 day 2', 'mouse 2 day 1', 'mouse 2 day 2', 'mouse 3 day 1', 'mouse 3 day 2'};

% Initialize some things
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