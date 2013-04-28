printImage = 0;

sigma = 0.1;
[X_train, Y_train] = genLinData(50, sigma);
[X_test, Y_test] = genLinData(30, sigma);

figure;
hold on;
plot(X_train, Y_train, 'xr;Train Data;');
if printImage
  print fig/ex01_1.png
end

X_train = [X_train ones(50, 1)];

w = LLS(X_train, Y_train);

x_limit = [-2.5; 1.5];
y_limit = [x_limit ones(2, 1)] * w;
plot(x_limit, y_limit, '-g');
if printImage
  print fig/ex01_2.png
end

plot(X_test, Y_test, '+b;Test Data;');
if printImage
  print fig/ex01_3.png
end

function err = doexp11(sigma, outlier)
  [X_train, Y_train] = genLinData(50, sigma);
  [X_test, Y_test] = genLinData(30, sigma);
  if outlier
    X_train = [X_train; 10];
    Y_train = [Y_train; 10];
  end
  X_train = [X_train ones(size(X_train, 1), 1)];
  X_test = [X_test ones(size(X_test, 1), 1)];
  w = LLS(X_train, Y_train);
  Y_pred = X_test * w;
  err = lossL2(Y_test, Y_pred);
end

sigma = [0.01 0.1 0.4 0.9 1];
err = zeros(size(sigma));
for i = 1 : length(sigma)
  errl = zeros(1, 10);
  for j = 1 : 10
    errl(j) = doexp11(sigma(i), 0);
  end
  err(i) = mean(errl);
end

figure;
plot(sigma, err, 'x-');
title('Average error of different sigma');
if printImage
  print fig/ex01_4.png
end

err = zeros(size(sigma));
for i = 1 : length(sigma)
  errl = zeros(1, 10);
  for j = 1 : 10
    errl(j) = doexp11(sigma(i), 1);
  end
  err(i) = mean(errl);
end

hold on;
legend('normal');
plot(sigma, err, 'o--;with extreme outlier;');
if printImage
  print fig/ex01_5.png
end

