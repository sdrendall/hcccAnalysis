function blocks = extractBlocks(mice)
% blocks = extractBlocks(mice)
% 
% Extracts the tlBlock structures from the Conditions structures
% Returns a single structural array of mouse structure.
% each mouse structure gains a conditionName field which is the name of it's
% parent Conditions structure
%
% The parentMouseNo field denotes the mouse number the blocks were taken from
% (hacked, don't trust this for sorting or ID)

for iMouse = 1:length(mice)
    % Set conditionName
    for iBk = 1:mice(iMouse).nBlocks
        mice(iMouse).tlBlock(iBk).conditionName = mice(iMouse).parentName;
        mice(iMouse).tlBlock(iBk).parentMouseNo = mice(iMouse).mouseNo;
    end
    % Add mice
    if iMouse == 1
        blocks = mice(iMouse).tlBlock(:);
    else
        % CLUNKY!! Replace w/ function
        [blocks, mice(iMouse).mouse] = reconcileStructureFields(blocks, mice(iMouse).tlBlock);
        blocks = [blocks; mice(iMouse).mouse(:)];
    end
end