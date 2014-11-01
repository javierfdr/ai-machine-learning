% Introduction to Machine Learning (IML) - project 1
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

function sample = datasample(data, nSample, dummy_var, replacement)
    nRows = size(data,1);

    if ~exist('dummy_var') || (dummy_var == 'Replace' && replacement == false)
        % Sampling without replacement:
        rndIDX = randperm(nRows); 
        sample = data(rndIDX(1:nSample), :);
    else
        % Sampling with replacement:
        rndIDX = randi(nRows, nSample, 1); 
        sample = data(rndIDX, :); 
    end
end


