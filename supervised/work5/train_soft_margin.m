function [a,b,sv,error] = train_soft_margin(data, labels, lambda)

    % Optimizing the margin by QP solving
    cvx_begin quiet
    variable a(size(data,2),1)
    variable b
        minimize(norm(a,2)+lambda*(sum(max(0,1-labels.*((a'*data')+b)))))       
    cvx_end
    
   %calculating support vectors
    dist = (a'*data')+b(1);
    dist1 = dist(labels==-1);
    dist2 = dist(labels==1);

    svdis1 = dist1+1>=-1e-5;
    svdis2 = dist2-1<=1e-5;
    
    data1 = data(labels==-1,:);
    data2 = data(labels==1,:);
    
    sv = [data1(svdis1,:);data2(svdis2,:)];
    error = sum(max(0,1-labels.*((a'*data')+b)));
    
end