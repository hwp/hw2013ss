function avgdis = averageDis(x, y)

n = size(x, 1);
m = size(y, 1);

dis = repmat(sum(x .^ 2, 2), 1, m) + repmat(sum(y' .^ 2, 1), n, 1) - 2 * x * y';
avgdis = mean(dis(dis ~= -1));

