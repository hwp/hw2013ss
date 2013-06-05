load('data/cancer-data.mat');

x_train=cancerInput_train;
y_train=cancerTarget_train;
x_test=cancerInput_test;
y_test=cancerTarget_test;

C = [0.01,0.1,1,10,50];

c=cvpartition(y_train,'kfold',10);
err_tr=zeros(length(C),1);
err_ts=zeros(length(C),1);
for i=1:length(C)
    for j=1:10
        xtr=x_train(c.training(j));
        ytr=y_train(c.training(j));
        xts=x_train(c.test(j));
        yts=y_train(c.test(j));
        [w,b,err]=SVM_classifier(xtr,ytr,C(i));
       err_tr(i)=err_tr(i)+err;
        f = @(X) sign(b + (X*w));
        test_pred=f(xts);
        err_t=loss01(test_pred,yts);
        err_ts(i)=err_ts(i)+err_t;
        
    end
    err_tr(i)=err_tr(i)/10;
    err_ts(i)=err_ts(i)/10;
end

figure(1);clf;
semilogx(C,err_tr,'*-r');hold on
semilogx(C,err_ts,'o-b');
xlabel('C');
ylabel('Error');
legend('training error','test error');

