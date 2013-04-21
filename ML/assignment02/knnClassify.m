function pred = knnClassify(train_data, train_label, test_data, k)
% Usage:
%   pred = knnClassify(train_data, train_label, test_data, k);
%
% Classify test_data using k Nearest Neighbor.
% Train data is given by train_data and train_label.
% Return the predicted labels of the test_data.

  rsize = size(train_data, 1);
  tsize = size(test_data, 1);
  pred = zeros(tsize, 1);

  for i = 1:tsize
    tt = ones(rsize, 1) * test_data(i, :) - train_data;
    dd = sum(tt .^ 2, 2);
    [s id] = sort(dd);
    pred(i) = mode(train_label(id(1:k)));
  end
end

