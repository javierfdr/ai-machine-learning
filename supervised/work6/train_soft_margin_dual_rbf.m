function [afunc,sv,v,error] = train_soft_margin_dual_rbf(data, labels, lambda, sigma)
    x = data';
    y = diag(labels);
    onesv = ones(size(labels,2),1);
    
    % Optimizing the margin by QP solving
    cvx_begin quiet
    variable v(size(labels,2),1)
        maximize(v'*onesv-((1/2)*v'*y*gramm_matrix(x,sigma)*y*v))
        subject to
            0 <= v <= lambda
            v'*labels' == 0
    cvx_end
    
    svindex = v > ((1e-9/lambda)^sigma);
    sv = data(svindex,:);
    
    afunc = @(nx) (v'*y*rbf_kernel(L2_distance(x,nx),sigma))';
    error = sum(v);
    
end