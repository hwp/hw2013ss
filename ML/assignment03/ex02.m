printImage = 1;

load('data/dataRidge.mat');

x_train = [x_train ones(size(x_train, 1), 1)];
x_test = [x_test ones(size(x_test, 1), 1)];
w = LLS(x_train, y_train);
y_pred = x_test * w;
err = lossL2(y_test, y_pred);
printf('Average Error for LLS = %f\n', err);
x_limit = [-2; 3];
y_limit = [x_limit ones(2, 1)] * w;

figure;
hold on;
plot(x_train(:, 1), y_train, 'xr;Train Data;');
plot(x_test(:, 1), y_test, '+b;Test Data;');
plot(x_test(:, 1), y_pred, 'ob;Predited Data;');
plot(x_limit, y_limit, '--g;Predicted Line;');
title('Linear Least Square Regression');
if printImage
  print fig/ex02_1.png
end

load('data/dataRidge.mat');

phi_train = repmat(x_train, 1, 15) .^ repmat(1:15, size(x_train, 1), 1);
w = LLS(phi_train, y_train);

phi_test = repmat(x_test, 1, 15) .^ repmat(1:15, size(x_test, 1), 1);
y_pred = phi_test * w;
err = lossL2(y_test, y_pred);
printf('Average Error for LLS with polinomial basis functions = %f\n', err);

xx = [-1.5:0.01:2.5]';
phi_line = repmat(xx, 1, 15) .^ repmat(1:15, size(xx, 1), 1);
yy = phi_line * w;

figure;
hold on;
plot(x_train, y_train, 'xr;Train Data;');
plot(xx, yy, '--g;Predicted Line;');
title('LLS with polynomial basis functions');
if printImage
  print fig/ex02_2.png
end

figure;
title('Ridge Regression using different lambda');
hold on;
plot(x_train, y_train, 'xk;Train Data;');

lambda = 0.0001;
w = RidgeLLS(phi_train, y_train, lambda);
yy = phi_line * w;
plot(xx, yy, '--g;Predicted Line (lambda = 0.0001);');

lambda = 0.1;
w = RidgeLLS(phi_train, y_train, lambda);
yy = phi_line * w;
plot(xx, yy, '--r;Predicted Line (lambda = 0.01);');

lambda = 10;
w = RidgeLLS(phi_train, y_train, lambda);
yy = phi_line * w;
plot(xx, yy, '--b;Predicted Line (lambda = 10);');

if printImage
  print fig/ex02_3.png
end

lambda = 2 .^ [-15:1];
err = zeros(size(lambda));
for i = 1 : length(lambda)
  w = RidgeLLS(phi_train, y_train, lambda(i));
  y_pred = phi_test * w;
  err(i) = lossL2(y_test, y_pred);
end

figure;
semilogx(lambda, err, 'x-');
title('Average error of different lambda');
if printImage
  print fig/ex02_4.png
end

