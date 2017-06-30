function [displayedCorr] = DisplayCorr(image1, image2, matches, dist_vals, x)
table = [matches dist_vals];
E = sortrows(table,5);
for i = 1:x
    fprintf('%.2f,%.2f -> %.2f,%.2f\n', E(i,1), E(i,2), E(i,3), E(i,4));
    image1 = insertText(image1, [E(i,1) E(i,2)], num2str(i), 'BoxOpacity', 0, 'TextColor', 'red', 'FontSize' ,22);
    image2 = insertText(image2, [E(i,3) E(i,4)], num2str(i), 'BoxOpacity', 0, 'TextColor', 'red', 'FontSize' ,22);
end
displayedCorr = E(1:x, 1:4);

% res = appendimages(image1, image2);
% imshow(res);
imshowpair(image1, image2, 'montage');
axis on;
end

