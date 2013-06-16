load('data/usps_train.mat');
ll = [1:200 2001:2200 3001:3200 5001:5200];
feature = double(train_data(ll, :));
label = double(train_label(ll));

k = 4;
sigma = 1000;

w = buildKnnGraph(data, 20);
w(w~=0) = exp(-w(w~=0) .^ 2 / (2 * sigma ^ 2));
d = diag(sum(w));

l = d - w;
[v, d] = eig(l, k, 'sm');

figure;
scatter3(v(:,2), v(:,3), v(:,4));
print('fig/spec.png');

opts = statset('Display','final');
[cidx, ctrs] = kmeans(v, 4, 'Distance', 'sqEuclidean', ...
    'Replicates', 5, 'Options', opts);

e1 = evaluateLabeled(cidx, label);
e2 = dunnindex(cidx, feature);

printf('Unnormalized spectral clustering\n');
printf('Evaluation with labels : %f\n', e1);
printf('Evaluation without labels : %f\n', e2);

ln = sqrt(d) * l * sqrt(d);
[v, d] = eig(ln, k, 'sm');

figure;
scatter3(v(:,2), v(:,3), v(:,4));
print('fig/normspec.png');

opts = statset('Display','final');
[cidx, ctrs] = kmeans(v, 4, 'Distance', 'sqEuclidean', ...
    'Replicates', 5, 'Options', opts);

e1 = evaluateLabeled(cidx, label);
e2 = dunnindex(cidx, feature);

printf('Normalized spectral clustering\n');
printf('Evaluation with labels : %f\n', e1);
printf('Evaluation without labels : %f\n', e2);

