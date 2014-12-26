% Introduction to Machine Learning (IML) - Work 2
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INPUTS
% X           --- the matrix of the data, one row per sample
% Y           --- the point of interest
% K           --- the number of neighbors to retrieve

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% OUTPUTS
% IDX  --- the indexes of the knn in the original matrix that were used
%          to build the tree
% d    --- the distance from the knn to the given point

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [IDX,d] = matKnnSearch(X,Y,K)
    
    function D = distEuc( X, Y )

        %if( ~isa(X,'double') || ~isa(Y,'double'))
         % error( 'Inputs must be of type double'); end;
        m = size(X,1); n = size(Y,1);
        %Yt = Y';
        XX = sum(X.*X,2);
        YY = sum(Y'.*Y',1);
        D = XX(:,ones(1,n)) + YY(ones(1,m),:) - 2*X*Y';
        D = sqrt(D);% comment for performance 
    end
    
    dimX = size(X,2);
    numYs = size(Y,1);
    
    %distMatrix = pdist2(X,Y);%uncomment in matlab
    distMatrix = distEuc(X,Y);%comment in matlab
    
    IDX = [];
    d = [];
    for i=1:numYs;
        distVector = distMatrix(:,i);
        [distVector, index] = sortrows(distVector);
        IDX = [IDX; index(1:K)' ];
        d = [d; distVector(1:K)'];
    end
   
end
