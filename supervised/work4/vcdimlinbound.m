% Introduction to Machine Learning (IML) - Exercise 4
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

function upbound = vcdimlinbound(Dtrain,errtrain,confidence)
        
    function dVC = linvcdim(dim)
        dVC = dim + 1;
    end
    
    delta = 1 - confidence;
    
    [nfeatures, nsamples] = size(Dtrain);
        
    upbound = errtrain + sqrt( (linvcdim(nfeatures)*(log(2*nsamples/linvcdim(nfeatures))+1) + log(2/delta)) / (2 * nsamples ));
    
end
