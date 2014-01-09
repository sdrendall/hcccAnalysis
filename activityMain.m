function activityMain
% Main Script for hccc behavior analysis 

startPath = '/Users/churchman/Desktop/SamR/timelapseAnalysis_1-8-14/';

% Load all images, for all mice, in each condition as well as a plethora of
% info about each condition, mouse ect. (see documentation)
Conditions = loadConditions(startPath);


for iCond = 1:length(Conditions)
    for iMouse = 1:Conditions(iCond).nMice
        % Find indexes for blocks where day, day or night, night is repeated
        % Get number of distinct ROI switches
        [Conditions(iCond).mouse(iMouse).roiSwitchInd, Conditions(iCond).mouse(iMouse).nROIs] = findDistinctROIs(Conditions(iCond).mouse(iMouse));
        for iROI = 1:Conditions(iCond).mouse(iMouse).nROIs
            % Get ROIs
            Conditions(iCond).mouse(iMouse).roi = defineROI(Conditions(iCond).mouse(iMouse).tlBlock(Conditions(iCond).mouse(iMouse).roiSwitchInd(iROI)).imagePaths(1));
        end
    end
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







