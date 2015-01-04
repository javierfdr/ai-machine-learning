function [] = predibetPlotFDA(categories,fdaData)
    dw = strcmp(categories,'winhome');
    dw = fdaData(dw,:);
    da = strcmp(categories,'winaway'); 
    da = fdaData(da,:);
    dd = strcmp(categories,'draw');
    dd = fdaData(dd,:);
    
    figure();
    scatter3(dw(1:10:size(dw,1),1),dw(1:10:size(dw,1),2),dw(1:10:size(dw,1),3),'b*');hold on;
    scatter3(da(1:10:size(da,1),1),da(1:10:size(da,1),2),da(1:10:size(da,1),3),'r*');hold on;
    scatter3(dd(1:10:size(dd,1),1),dd(1:10:size(dd,1),2),dd(1:10:size(dd,1),3),'g*');hold on;




end