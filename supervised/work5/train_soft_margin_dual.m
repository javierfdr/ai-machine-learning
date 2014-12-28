function [a,b,sv,v,error] = train_soft_margin_dual(data, labels, lambda)
    x = data';
    y = diag(labels);
    onesv = ones(size(labels,2),1);
    
    % Optimizing the margin by QP solving
    cvx_begin quiet
    variable v(size(labels,2),1)
        maximize(v'*onesv-((1/2)*v'*y*x'*x*y*v))
        subject to
            0 <= v <= lambda
            v'*labels' == 0
    cvx_end
    
    svindex = ((1e-5*lambda < v)&(v < lambda));
    sv = data(svindex,:);
    svy = labels(svindex);
        
    a = (v'*y*x')';  
    b = svy(1)-a'*sv(1,:)';
    error = sum(max(0,1-labels.*((a'*data')+b)));
    
end