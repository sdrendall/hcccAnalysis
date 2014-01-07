function filtV = smoothVector(vector, window)
% smoothedVector = smoothVector(vector, smoothingWindow)
%
% Smooths a vector by adveraging across a window of the specified size

filtV = conv(vector, ones(1, window)/window);
