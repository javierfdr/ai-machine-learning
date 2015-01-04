% Introduction to Machine Learning (IML) - project 1
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

function [newData, Dmean, Deivec, Deival ] = pca(Data, newDim)
	
	% Substracting the mean
    Dmean = mean(Data, 1);
	Data = Data - repmat(Dmean, [size(Data, 1) 1]);

	% Obtaining covariance matrix of the Data
    Dcov = cov(Data);
	
	% Obtaining eigenvectors and eigenvalues
    [Deivec, Deival] = eig(Dcov);
    Deival = diag(Deival);
    
    % Sort eigenvectors
    [svalues, sindexes] = sort(Deival, 'descend');
    
    % Croping dimmensions to newDim
	Deivec = Deivec(:,sindexes(1:newDim));
    Deival = svalues(1:newDim);
	
	% Obtaining new Data matrix
    newData = Data * Deivec;
    
end
