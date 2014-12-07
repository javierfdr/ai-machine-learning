% Introduction to Machine Learning (IML) - Exercise 4
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

function nsamples = nsamplesvcdim(nfeatures,errtrain,confidence,deviation)
        
    function dVC = linvcdim(dim)
        dVC = dim + 1;
    end
    
    delta = 1 - confidence;
    nsamples = 1;
       
    upbound = errtrain + sqrt( (linvcdim( log(2*nsamples/linvcdim(nfeatures)))
                           + log(2/delta)) / (2 * nsamples ));

    iter = 1000;
    while iter > 0 && upbound - deviation > 0
        
        nsamples = nsamples + (nsamples * (upbound - deviation)) + 1;
        upbound = errtrain + sqrt( (linvcdim(
                             log(2*nsamples/linvcdim(nfeatures))) 
                             + log(2/delta)) / (2 * nsamples ));
        iter = iter - 1;
    end
    
    if iter == 0
        nsamples = Inf;
    else
        nsamples = round(nsamples);
    end    
    
end
