function [a,b,sv] = train_soft_margin_constrained(data, labels, lambda)

    % Optimizing the margin by QP solving
    cvx_begin
    variable a(size(data,2),1)
    variable b
    variable u(size(labels))
        minimize(norm(a,2)+lambda*(u*ones(size(data,1),1)))  
        subject to 
            u >= 1-labels.*((a'*data')+b)
            u >= 0
             
    cvx_end
    
    disp('U value');
    disp(u);

   %calculating support vectors
    dist = (a'*data')+b(1);
    dist1 = dist(labels==-1);
    dist2 = dist(labels==1);

    svdis1 = dist1+1>=-1e-5;
    svdis2 = dist2-1<=1e-5;
    
    data1 = data(labels==-1,:);
    data2 = data(labels==1,:);
    
    sv = [data1(svdis1,:);data2(svdis2,:)];
end