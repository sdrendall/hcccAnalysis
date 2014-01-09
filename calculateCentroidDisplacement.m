function disp = calculateCentroidDisplacement(centroids)
% Displacement = calculateCentroidDisplacement(centroids)
%
% Calculates the displacement between consecutive centroids
% Returns a vector containing displacements

for i = 1:(length(centroids) - 1)
disp(i) = sqrt((centroids(i,1) - centroids(i+1,1))^2 + (centroids(i,2) - centroids(i+1,2))^2);
end

disp(end + 1) = 0;