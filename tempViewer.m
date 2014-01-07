for i = 1:length(output)
figure, imshow(imread(paths{i}))
hold on
rectangle('Position', [centroids(i,1)*10 - 50, centroids(i,2)*10 - 50, 100, 100])
hold off
pause
close gcf
end