% Introduction to Machine Learning (IML) - Exercise 4
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

function D = nans2mean(x, y, considerclasses)
    
    D = x;
    D(isnan(x)) = 0;

    if considerclasses
        
        meanattrsp = nanmean(x(:,y==1),2);    
        meanattrsn = nanmean(x(:,y==-1),2);

        D(:,y==1) = D(:,y==1) + repmat(meanattrsp,1,size(x(:,y==1),2)).*(isnan(x(:,y==1)));
        D(:,y==-1) = D(:,y==-1) + repmat(meanattrsn,1,size(x(:,y==-1),2)).*(isnan(x(:,y==-1)));
        
    else        
        meanattrs = nanmean(x,2);
        D = D + repmat(meanattrs,1,size(x,2)).*(isnan(x));    
    end

end
