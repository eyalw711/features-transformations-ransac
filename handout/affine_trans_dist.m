function [inliers, H] = affine_trans_dist(H, matches, thresh)
    % matches is a matrix with columns of type [x; y ;xtag ;ytag]
    inliers = [];
    for i = 1:size(matches, 2)
        op = [matches(1:2, i) ; 1];
        tp = [matches(3:4, i) ; 1];
        htp = H*op;
        delta = htp - tp;
        dist = sqrt(sum(delta(1:2).^2));
        if dist <= thresh
            inliers = [inliers; matches(:,i)];
        end
    end
end



