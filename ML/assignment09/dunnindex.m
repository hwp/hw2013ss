function index = dunnindex(cluster, data)

xs = unique(cluster);
k = length(xs);

sub = cell{k, 1};
for i = 1:k
  sub{i} = find(cluster == xs(i));
end

dis = zeros(k, k);
for j = 1:k
  for i = 1:k
    dis(i, j) = averageDis(data(sub{i}), data(sub{j}));
  end
end

