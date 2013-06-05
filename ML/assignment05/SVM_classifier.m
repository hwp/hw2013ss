function [w,b,err_tr]=SVM_classifier(X,Y,C)

p=size(X,2);
q=length(Y);

cvx_begin quiet
variables w(p) b xi(q)
minimize 1/2*sum(w.*w)+C*sum(xi)
Y.*(X*w + b) >= 1 - xi;
xi>=0;
cvx_end

f = @(X) sign(b + (X*w));

Ypred = f(X);

err_tr = loss01(Ypred,Y);