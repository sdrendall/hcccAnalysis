function mice = extractMice(Conditions)
% mice = extractMice(Conditions)
% 
% Extracts the mouse structures from the Conditions structures
% Returns a single structural array of mouse structure.
% each mouse structure gains a parentName field which is the name of its
% parent structure
%
% mice.mouseNo corresponds to each mouse's number within its condition

for iCond = 1:length(Conditions)
    % Set parentName
    for iMouse = 1:Conditions(iCond).nMice
        Conditions(iCond).mouse(iMouse).parentName = Conditions(iCond).name;
        Conditions(iCond).mouse(iMouse).mouseNo = iMouse;
    end
    % Add mice
    if iCond == 1
        mice = Conditions(iCond).mouse(:);
    else
        % CLUNKY!! Replace w/ function
        [mice, Conditions(iCond).mouse] = reconcileStructureFields(mice, Conditions(iCond).mouse);
        mice = [mice; Conditions(iCond).mouse(:)];
    end
end