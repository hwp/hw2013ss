function err = lossL2(Y, Y_pred)
% Usage:
%   err = lossL2(Y, Y_pred)
%
% Calculate the average error according to L2 loss.
%

err = mean((Y - Y_pred) .^ 2);

