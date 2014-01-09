function Conditions = activityMain
% Main Script for hccc behavior analysis 

startPath = uigetdir; %'/media/sam/external2_1TB/timelapseAnalysis_1-8-14/'; %'/Users/churchman/Desktop/SamR/timelapseAnalysis_1-8-14/';

% Load all images, for all mice, in each condition as well as a plethora of
% info about each condition, mouse ect. (see documentation)
Conditions = loadConditions(startPath);

% First get ROIs, for time management's sake
for iCond = 1:length(Conditions)
    for iMouse = 1:Conditions(iCond).nMice
        % Get ROIs for Conditions requiring them for evaluation
        if ~Conditions(iCond).activityOnly
            % Find indexes for  consecutive 'day' or 'night' blocks
            % Get number of distinct ROI switches
            [Conditions(iCond).mouse(iMouse).roiSwitchInd, Conditions(iCond).mouse(iMouse).nROIs] = findDistinctROIs(Conditions(iCond).mouse(iMouse));
                        
            for iROI = 1:Conditions(iCond).mouse(iMouse).nROIs
                Conditions(iCond).mouse(iMouse).roi = defineROI(Conditions(iCond).mouse(iMouse).tlBlock(Conditions(iCond).mouse(iMouse).roiSwitchInd(iROI)).imagePaths{1});
            end
            
            % Assign each block the highest valued switch index less than
            % or equal to the block's index
            for iBk = 1:Conditions(iCond).mouse(iMouse).nBlocks
                Conditions(iCond).mouse(iMouse).tlBlock(iBk).myROIInd = max(Conditions(iCond).mouse(iMouse).roiSwitchInd([Conditions(iCond).mouse(iMouse).roiSwitchInd] <= iBk));
            end
        end
    end
end


% Get data
for iCond = 1:length(Conditions)
    for iMouse = 1:Conditions(iCond).nMice
        % Calculate displacement between consecutive centroids
        % calculateDisplacement will create activity logs for the whole
        % mouse as well as for each block.  Passing around the whole
        % structure for convenience.
        Conditions(iCond).mouse(iMouse) = calculateDisplacement(Conditions(iCond).mouse(iMouse);
        for iBk = 1:Conditions(iCond).mouse(iMouse).nBlocks
            % findMouse for each block
            Conditions(iCond).mouse(iMouse).tlBlock(iBk).centroids = findMouse(Conditions(iCond).mouse(iMouse).tlBlock(iBk).imagePaths);
            
            % Calculate time spent in and out of the ROI for appropriate
            % animals
            if ~Conditions(iCond).activityOnly
                Conditions(iCond).mouse(iMouse).tlBlock(iBk).inROI = checkCentroidPosition(Conditions(iCond).mouse(iMouse).tlBlock(iBk).centroids, ...
                    Conditions(iCond).mouse(iMouse).roi(Conditions(iCond).mouse(iMouse).tlBlock(iBk).myROIInd));
            end
        end        
        % Calculate 
    end
end
return


for i = 1:length(Conditions)

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







