% Introduction to Machine Learning (IML) - Work 6
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs:
%        L2 : L2 distance of the points
%        sigma : sigma for rbf
% Outputs:
%        K : Gramm Matrix for X with sigma
function K = rbf_kernel(L2,sigma)
    K = exp((-(L2.^2)) ./ (2*(sigma^2)));
end