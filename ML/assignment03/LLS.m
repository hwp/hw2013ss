function w = LLS(X, Y)
% Usage:
%   w = LLS(X, Y)
%
% Least square regression.
% @return weight vector
%

w = X \ Y;

