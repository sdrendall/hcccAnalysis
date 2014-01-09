for i = 1:length(centroids)
figure, imshow(imread(paths{i}))
hold on
rectangle('Position', [centroids(i,1) - 50, centroids(i,2) - 50, 100, 100], 'FaceColor', 'r')
hold off
pause
close gcf
end