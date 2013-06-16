function score = evaluateLabeled(cluster, standard)

ys = unique(standard);
k = length(ys);
xs = unique(cluster);
xs = [xs; (min(xs) - 1) * ones(k - length(xs), 1)];

s = zeros(k, k);
for j = 1:k
  for i = 1:k
    s(i, j) = sum((cluster == xs(i)) .* (standard == ys(j)));
  end
end

p = perms(1:k);
n = size(p, 1);
ps = zeros(n, 1);
for j = 1:k
  for i = 1:n
    ps(i) = ps(i) + s(k, p(i, k));
  end
end

score = max(ps) / length(standard);

