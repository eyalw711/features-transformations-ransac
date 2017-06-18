function [pnts_gt, pnts_computed] = ComputeTestPoints(H_gt, H_computed)
    % generate all points from 100X100
    n = 100;
    m = 1;
    for i = 1:n
        for j = 1:n
            pt = [i; j; 1];
            pnts_gt(:, m ) = (H_gt * pt)';
            pnts_computed(:, m ) = (H_computed * pt)';
            m = m + 1;
        end
    end
    % compute H_gt transform for each point (pnts_gt)
    % compute H_computed for each point (pnts_computed)
end