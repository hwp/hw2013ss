function pred = knnClassify2(distance, train_label, k)
% Usage:
%   pred = knnClassify(train_data, train_label, test_data, k);
%
% Classify test_data using k Nearest Neighbor.
% Train data is given by train_data and train_label.
% Return the predicted labels of the test_data.

  rsize = size(distance, 1);
  tsize = size(distance, 2);
  pred = zeros(tsize, 1);

  for i = 1:tsize
    dd = distance(:, i);
    [s id] = sort(dd);
    pred(i) = mode(train_label(id(1:k)));
  end
end

