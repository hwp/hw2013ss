load('data/usps_train.mat');
ll = [1:200 2001:2200 3001:3200 5001:5200];
feature = double(train_data(ll, :));
label = double(train_label(ll));

k = 4;
sigma = 1000;

w = buildKnnGraph(feature, 20);
w(w~=0) = exp(-w(w~=0) .^ 2 / (2 * sigma ^ 2));
d = diag(sum(w));

l = d - w;
[v, lambda] = eigs(l, k, 'sm');

figure;
scatter3(v(:,2), v(:,3), v(:,4));
print -dpng 'fig/spec.png'

opts = statset('Display','final');
[cidx, ctrs] = kmeans(v, 4, 'Distance', 'sqEuclidean', ...
    'Replicates', 10, 'Options', opts);

e1 = evaluateLabeled(cidx, label);
e2 = dunnindex(cidx, feature);

fprintf(1, 'Unnormalized spectral clustering\n');
fprintf(1, 'Evaluation with labels : %f\n', e1);
fprintf(1, 'Evaluation without labels : %f\n', e2);

ln = sqrt(d) * l * sqrt(d);
[v, lambda] = eigs(ln, k, 'sm');

figure;
scatter3(v(:,2), v(:,3), v(:,4));
print -dpng 'fig/normspec.png'

opts = statset('Display','final');
[cidx, ctrs] = kmeans(v, 4, 'Distance', 'sqEuclidean', ...
    'Replicates', 10, 'Options', opts);

e1 = evaluateLabeled(cidx, label);
e2 = dunnindex(cidx, feature);

fprintf(1, 'Normalized spectral clustering\n');
fprintf(1, 'Evaluation with labels : %f\n', e1);
fprintf(1, 'Evaluation without labels : %f\n', e2);

