function [a,b,sv] = train_hard_margin(data, labels)
    r = data(labels==-1,:)';
    s = data(labels==1,:)';
    
    % Optimizing the margin by QP solving
    cvx_begin
    variable a(size(data,2),1)
    variable b
        minimize((1/2)*norm(a,2))
        subject to
            a'*r + b <= -1
            a'*s + b >= 1             
    cvx_end
    
   %calculating support vectors
    dist = (a'*data')+b(1);

    svdis1 = abs(dist+1)<1e-5;
    svdis2 = abs(dist-1)<1e-5;
    sv = data(svdis1|svdis2,:);
    
end