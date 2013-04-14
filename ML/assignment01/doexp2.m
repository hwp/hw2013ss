function doexp2(d1, d2)
% Usage:
%   doexp2(d1, d2)

printf('Classify digit %d and %d\n', d1, d2);
load('data/usps_train.mat');
trList = find(train_label == d1 | train_label == d2);
x_train = double(train_data(trList, :));
y_train = double(train_label(trList));
load('data/usps_test.mat');
teList = find(test_label == d1 | test_label == d2);
x_test = double(test_data(teList, :));
y_test = double(test_label(teList));

k_values = [1, 3, 5, 7, 10, 15];
for i = 1:length(k_values)
  k = k_values(i);
  % Test on Train data
  pred = knnClassify(x_train, y_train, x_train, k);
  rerr(i) = loss01(pred, y_train);
  % Test on Test data
  pred = knnClassify(x_train, y_train, x_test, k);
  terr(i) = loss01(pred, y_test);
  printf('k = %d, Training Error = %f, Test Error = %f\n', k, rerr(i), terr(i));
end
figure; hold all;
plot(k_values, rerr, 'r*:;Training Error;');
plot(k_values, terr, 'b.-;Test Error;');
title('Training and Test Error of different k');
legend('location', 'southeast');
if saveimage
  print fig/ex2_err.png
end

end

