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

trDis = calDistance(x_train, x_train);
teDis = calDistance(x_train, x_test);

save trDis
save teDis

