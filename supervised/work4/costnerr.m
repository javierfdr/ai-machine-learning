% Introduction to Machine Learning (IML) - Exercise 4
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

function [cost, err] = costnerr(x,ws,y)
    
    xtilde = [ones(1,size(x,2)); x];
    nsamples = size(xtilde,2);
    
    tmpcost = ((xtilde'*ws) - y);
    cost = (1/nsamples) * tmpcost' * tmpcost;

    tmperr = (sign(xtilde'*ws) + y) == 0;    
    err = ((1/nsamples) * sum(tmperr))*100;

end
