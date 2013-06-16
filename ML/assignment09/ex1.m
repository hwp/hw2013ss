load('data/usps_train.mat');
ll = [1:200 2001:2200 3001:3200 5001:5200];
feature = double(train_data(ll, :));
label = double(train_label(ll));

opts = statset('Display','final');
[cidx, ctrs] = kmeans(feature, 4, 'Distance', 'sqEuclidean', ...
    'Replicates', 5, 'Options', opts);

e1 = evaluateLabeled(cidx, label);
e2 = dunnindex(cidx, feature);

printf('k-means with Euclidean distance\n');
printf('Evaluation with labels : %f\n', e1);
printf('Evaluation without labels : %f\n', e2);

[cidx, ctrs] = kmeans(feature, 4, 'Distance', 'cityblock', ...
    'Replicates', 5, 'Options', opts);

e1 = evaluateLabeled(cidx, label);
e2 = dunnindex(cidx, feature);

printf('k-means with cityblock distance\n');
printf('Evaluation with labels : %f\n', e1);
printf('Evaluation without labels : %f\n', e2);

