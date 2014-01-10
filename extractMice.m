function mice = extractMice(Conditions)
% mice = extractMice(Conditions)
% 
% Extracts the mouse structures from the Conditions structures
% Returns a single structural array of mouse structure.
% each mouse structure gains a parentName field which is the name of it's
% parent structure
%
% Currently only works for activityOnly or ~activityOnly seperately

for iCond = 1:length(Conditions)
    % Set parentName
    for iMouse = 1:Conditions(iCond).nMice
        Conditions(iCond).mouse(iMouse).parentName = Conditions(iCond).name;
    end
    % Add mice
    if iCond == 1
        mice = Conditions(iCond).mouse(:);
    else
        mice = [mice; Conditions(iCond).mouse(:)];
    end
end