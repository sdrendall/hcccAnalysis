function bins = binVector(vect, binSize, mode)
% bins = binVector(vector, binSize)
%
% Divides a vector into bins of a designated size
% Modes include 'sum' and 'mean'

if ~exist('mode', 'var')
    mode = 'sum';
end

if ~exist('binSize', 'var')
    binSize = ceil(sqrt(length(vect)));
end

% Allocate memory
store = zeros(1, binSize);

% Bin values
for i = 1:length(vect)
    store(mod(i, binSize) + 1) = vect(i);
    
    % Store values each time bin resets
    if mod(i, binSize) == 0
        switch lower(mode)
            case 'sum'
                bins(i/binSize) = sum(store);
            case 'mean'
                bins(i/binSize) = sum(store)./binSize;
            otherwise
                errordlg('Unrecognized bin mode, exiting');
                return
        end
    end
end