function activityMain
% Main Script for hccc behavior analysis 

dirPaths = {'~/Documents/grayLab/practice/p1',...
            '~/Documents/grayLab/practice/p2'};
condName = {'pract1', 'pract2'};

% Initialize some things
for iPath = 1:length(dirPaths)
    % Store Condition name and dirPath
    Condition(iPath).name = condName{iPath};
    Condition(iPath).dirPath = dirPaths{iPath};
    
    % Get Image Paths
    [Condition(iPath).imagepaths, Condition(iPath).imageFilenames] = getImagePath(dirPaths{iPath});
    
    % Designate ROIs
    Condition(iPath).roi = defineROI(Condition(iPath).imagepaths{1});
end

for i = 1:length(Condition)
% Find Centroids
Condition(i).centroids = findMouse(Condition(i).imagepaths);

% Time Spent in ROI
[Condition(i).location.inROI, Condition(i).location.notInROI] = catagorizeCentroids(Condition(i).centroids, Condition(i).roi);


% Detect Activity
 % Calculate Centroid Displacement
Condition(i).displacement.raw = calculateCentroidDisplacement(Condition(i).centroids);
 % Lowpass filter?
Condition(i).displacement.lp80 = smoothVector(Condition(i).displacement.raw, 80);
 % Bin
Condition(i).displacement.bin27 = binVector(Condition(i).displacement.raw, 3, 'mean'); 
end

% Save Results
[savefile, savepath] = uiputfile;
save([savepath, savefile], 'Condition');

%figure, bar([length(inROI), length(notInROI)])
%figure, plot(displacement)