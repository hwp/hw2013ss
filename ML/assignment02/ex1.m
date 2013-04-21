d1 = 6;
d2 = 8;

printf('Classify Newsgroup %d and %d\n', d1, d2);
load('data/20Newsgroup.mat');

x_test = x_test(:, 1:size(x_train, 2));

trList = find(y_train == d1 | y_train == d2);
x_train = x_train(trList, :);
y_train = y_train(trList);
printf('Training data : %d\n', size(trList, 1));

teList = find(y_test == d1 | y_test == d2);
x_test = x_test(teList, :);
y_test = y_test(teList);
printf('Test data : %d\n', size(teList, 1));

k_values = [1, 3, 5, 7, 10, 15, 20];
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
  print fig/ex1_err.png
end

