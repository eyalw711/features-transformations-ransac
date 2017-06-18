function [error] = ComputeError(pnts_gt, pnts_computed)
    error = sum(sqrt((pnts_gt(:,1) - pnts_computed(:,1)).^2 + (pnts_gt(:,2) - pnts_computed(:,2)).^2));
end