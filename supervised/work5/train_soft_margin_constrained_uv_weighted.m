function [a,b,sv,u,v,error,weightedError] = train_soft_margin_constrained_uv_weighted(data, labels, lambda)
    
    cardr = sum(labels==-1);
    cards = sum(labels==1);
    
    balanceFactor = min(cardr,cards)/max(cardr,cards);
    
    r = data(labels==-1,:)';
    s = data(labels==1,:)';
    onesu = ones(size(s,2),1);
    onesv = ones(size(r,2),1);
    
    % Optimizing the margin by QP solving
    cvx_begin quiet
    variable a(size(data,2),1)
    variable b
    variable u(size(s,2),1)
    variable v(size(r,2),1)
        if cardr < cards
            minimize(norm(a,2)+lambda*(balanceFactor*(u'*onesu)+(v'*onesv)))
        else
            minimize(norm(a,2)+lambda*((u'*onesu)+balanceFactor*(v'*onesv)))
        end
        subject to
            a'*r + b <= -1 + v'
            a'*s + b >= 1 - u'
            u >= 0
            v >= 0
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
    
    error = (u'*onesu)+(v'*onesv);
    
    if cardr < cards
        weightedError = balanceFactor*(u'*onesu)+(v'*onesv);
    else
        weightedError = (u'*onesu)+balanceFactor*(v'*onesv);
    end
end