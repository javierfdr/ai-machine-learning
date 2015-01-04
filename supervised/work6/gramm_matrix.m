% Introduction to Machine Learning (IML) - Work 6
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs:
%        X : m*n matrix, m examples, n features
%        sigma : sigma for rbf
% Outputs:
%        K : Gramm Matrix for X with sigma
%        L2 : L2 distance of the points
function [K,L2] = gramm_matrix(X,sigma)
    L2 = squareform(pdist(X,'euclidean'));
    K = exp(-L2.^2 ./ (2*(sigma^2)))
end