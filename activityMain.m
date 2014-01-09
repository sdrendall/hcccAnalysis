function activityMain
% Main Script for hccc behavior analysis 

startPath = '/Users/churchman/Desktop/SamR/timelapseAnalysis_1-8-14/';

% Load all images, for all mice, in each condition
Conditions = loadConditions(startPath);

% Better way to do the next part:
% Find number of ROI switches (based on day, day or night night blocks)
% Find ROI for first image of first block of each ROI... need to
% sleep.....
                 
for iCond = 1:length(Conditions)
    for iMouse = 1:Conditions(iCond).nMice
        for iBlock = 1:Conditions(iCond).mouse(iMouse).nBlocks
            % Designate ROI for each block, clunky, but that's how I'm
            % gonna do it for now...
            Conditions(iCond).mouse(iMouse).tlBlock(iBlock).roi = defineROI(Conditions(iCond).mouse(iMouse).tlBlock(iBlock).imagePaths{1});
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







