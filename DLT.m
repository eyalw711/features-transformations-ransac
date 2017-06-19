function [ H ] = DLT( matches )
    x = [matches(:,1:2) ones(size(matches,1),1)];
    xtag = [matches(:,3:4) ones(size(matches,1),1)];
    
    [xnorm, Tx] = normPoints(x);
    [xtagnorm, Txtag] = normPoints(xtag);
    
    A = [];
    for i = 1:size(x, 1)
        xi = xtagnorm(1, i);
        yi = xtagnorm(2, i);
        wi = xtagnorm(3, i);
        A_row = [ zeros(1,3) -wi*xnorm(:, i)' yi*xnorm(:, i)';...
                 wi* xnorm(:, i)' zeros(1,3) -xi*xnorm(:, i)'];
        A = [A; A_row];
    end
    
    [U,S,V] = svd(A);
    h = V(:,end);
    H = ((Txtag^-1)* reshape(h,3,3)' * Tx)';
end

% pts is a matrix with rows like: [xs ys 1]
% normPts is a matrix with 3 rows [xs; ys; 1s]
function [normPts, Trans] = normPoints(pts)
    displacement = sum(pts,1) / size(pts,1);
    displaced_pts(:, 1) = pts(:,1) - displacement(1);
    displaced_pts(:, 2) = pts(:,2) - displacement(2);

    avgdist = mean(sqrt(displaced_pts(:,1).^2 + displaced_pts(:,2).^2), 1);
    scale_factor = sqrt(2) / avgdist;
    
    T_scale = [scale_factor 0 0; 0 scale_factor 0; 0 0 1];
    T_trans = [1 0 -displacement(1); 0 1 -displacement(2); 0 0 1];
    Trans = T_scale * T_trans;
    
    % transpose so that points are column vector
    normPts = Trans * pts';
end


