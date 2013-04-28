function w = RidgeLLS(X, Y, lambda)
% Usage:
%   w = RidgeLLS(X, Y, lambda)
%
% Ridge regression.
% @return weight vector
%

[n d] = size(X);
w = (X' * X + n * lambda * eye(d)) \ (X' * Y);

