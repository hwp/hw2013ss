function doexp1(n1 = 30, n2 = 30, t1 = 100, t2 = 100, saveimage = 0)
% Usage:
%   doexp1
%   doexp1(n1, n2, t1, t2)
%   doexp1(n1, n2, t1, t2, saveimage)
% Do the experiment of kNN algorithm,
% selecting different number of train/test data.

% Generate Train Data
train_data_class1 = rand(n1,2);
train_data_class2 = rand(n2,2) + ones(n2,2)*[1 0; 0 0];
train_data = zeros(n1+n2, 2);
train_label = zeros(n1+n2, 1);
train_data = [train_data_class1 ; train_data_class2];
train_label(1:n1) = 1;
train_label(n1+1:n1+n2) = 2;

figure; clf; hold all; axis equal;
plot(train_data(1:n1,1), train_data(1:n1,2), 'r*;class 1;');
plot(train_data(n1+1:n1+n2,1), train_data(n1+1:n1+n2,2), 'bo;class 2;');
title('Train Data');
legend('location', 'southoutside');
if saveimage
  print fig/ex1_train.png
end

% Generate Test Data
test_data_class1 = rand(t1,2);
test_data_class2 = rand(t2,2) + ones(t2,2)*[1 0; 0 0];
test_data = zeros(t1+t2, 2);
test_label = zeros(t1+t2, 1);
test_data = [test_data_class1 ; test_data_class2];
test_label(1:t1) = 1;
test_label(t1+1:t1+t2) = 2;

figure; clf; hold all; axis equal;
plot(test_data(1:t1,1), test_data(1:t1,2), 'r*;class 1;');
plot(test_data(t1+1:t1+t2,1), test_data(t1+1:t1+t2,2), 'bo;class 2;');
title('Test Data');
legend('location', 'southoutside');
if saveimage
  print fig/ex1_test.png
end

% Try using different k
k_values = [1, 3, 5, 7, 10, 15, 20];
for i = 1:length(k_values)
  k = k_values(i);
  % Test on Train data
  pred = knnClassify(train_data, train_label, train_data, k);
  rerr(i) = loss01(pred, train_label);
  % Test on Test data
  pred = knnClassify(train_data, train_label, test_data, k);
  terr(i) = loss01(pred, test_label);
  printf('k = %d, Training Error = %f, Test Error = %f\n', k, rerr(i), terr(i));
end
figure; hold all;
plot(k_values, rerr, 'r*:;Training Error;');
plot(k_values, terr, 'b.-;Test Error;');
title('Training and Test Error of different k');
legend('location', 'southeast');
if saveimage
  print fig/ex1_err.png
end

[m i] = min(terr);
printf('Best prediction at k = %d\n', k_values(i));
pred = knnClassify(train_data, train_label, test_data, k_values(i));
figure; clf; hold all; axis equal;
pred_class1 = find(pred == 1);
pred_class2 = find(pred == 2);
plot(test_data(pred_class1, 1), test_data(pred_class1, 2), 'r*');
plot(test_data(pred_class2, 1), test_data(pred_class2, 2), 'bo');
plot([1 1], [0 1],'k');
if saveimage
  print fig/ex1_result.png
end

end

