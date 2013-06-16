function index = dunnindex(cluster, data)

xs = unique(cluster);
k = length(xs);

sub = cell(k, 1);
for i = 1:k
  sub{i} = find(cluster == xs(i));
end

inter = -1;
for j = 1:k
  for i = 1:(j-1)
    dis = averageDis(data(sub{i},:), data(sub{j},:));
    if (inter < 0 || inter > dis)
      inter = dis;
    end
  end
end

intra = 0;
for i = 1:k
  dis = averageDis(data(sub{i},:), data(sub{i},:));
  if intra < dis
    intra = dis;
  end
end

index = inter / intra;

