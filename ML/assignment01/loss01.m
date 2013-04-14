function err = loss01(y_pred, y)
% Usage:
%   err = loss01(y_pred, y);
%
% where y_pred is the predicted label;
% y is the golden standard.
% Returns the error regarding the 0-1 loss of the prediction.

  err = sum(y != y_pred) / length(y);
end

