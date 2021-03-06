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
    L2 = L2_distance(X,X);
    K = rbf_kernel(L2,sigma);
end