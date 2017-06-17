function [num_matches, matches, dist_vals] = match(image1, image2, distRatio)
[im1, des1, loc1] = sift(image1);
[im2, des2, loc2] = sift(image2);

des2t = des2';                          % Precompute matrix transpose
for i = 1 : size(des1,1)
   dotprods = des1(i,:) * des2t;        % Computes vector of dot products
   [vals,indx] = sort(acos(dotprods));  % Take inverse cosine and sort results

   % Check if nearest neighbor has angle less than distRatio times 2nd.
   if (vals(1) < distRatio * vals(2))
      match(i) = indx(1);
      dist_vals_full(i) = vals(1) / vals(2);
   else
      match(i) = 0;
   end
end
num_matches = sum(match > 0);
matches = zeros(num_matches, 4);
dist_vals = zeros(num_matches, 1);
m = 1;
cols1 = size(im1,2);
for i = 1: size(des1,1)
  if (match(i) > 0)
      %matches(m, :) = [loc1(i,2) loc2(match(i),2)+cols1 loc1(i,1) loc2(match(i),1)];
      matches(m, :) = [loc1(i,2) loc1(i,1) loc2(match(i),2) loc2(match(i),1)];
      dist_vals(m) =  dist_vals_full(i);
      m = m + 1;
  end
end
end

