function dis = calDistance(train_data, test_data)
  rsize = size(train_data, 1);
  tsize = size(test_data, 1);
  dis = zeros(rsize, tsize);

  for i = 1:tsize
    tic
    tt = ones(rsize, 1) * test_data(i, :) - train_data;
    dd = sum(tt .^ 2, 2);
    dis(:, i) = dd;
    toc
  end
end

