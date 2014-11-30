function [wp] = analytic_polyfit(x,y)
    o = ones(size(x,1),1);
    xpanded = [o,x];  
    
    % ?? = (X'X)^-1X'y
    wp = inv(xpanded'*xpanded)*(xpanded'*y);
end