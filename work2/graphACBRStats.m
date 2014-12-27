function [] = graphACBRStats(totalStats,datasetName)
    combinations = ['DD-O','DD','DE-O','DE','NR-O','NR','AR-O','AR'];
    l = cell(1,8);
    l{1}='DD-O'; l{2}='DD'; l{3}='DE-O'; l{4}='DE'; l{5}='NR-O'; l{6}='NR';l{7}='AR-O';l{8}='AR';    
    
    lr = cell(1,3);
    lr{1}='K-3'; lr{2}='K-5'; lr{3}='K-7';     
    
    %% Accuracy graph
    % calculating mean accuracy
    accuracy = [];
    meanAccuracy = [];
    for i=1:8
        for k=[1,2,3]
            statsI = totalStats(i);
            meanAccuracy = [meanAccuracy,mean(statsI.numValid(k,:)./statsI.total(k,:))];
        end
        if size(accuracy) == size([])
            accuracy = meanAccuracy;
        else
            accuracy = [accuracy;meanAccuracy];
        end
        meanAccuracy = [];
        
    end
    
    input('Press enter to see accuracy comparative graph');
    figure('name',strcat('Comparison of accuracy for dataset: ',datasetName));
    
    b = bar(accuracy);   
    title(strcat('Comparison of accuracy for dataset: ',datasetName));
    set(gca,'xticklabel', l);
    colormap(summer(3));
    legend(b,lr);  
    grid on
    
    %% Dataset size change graph
    sizeChange = [];
    meanSizeChange = [];
    for i=1:8
        for k=[1,2,3]
            statsI = totalStats(i);
            meanSizeChange = [meanSizeChange,-1*mean(statsI.dataSetSizeChange(k,:))];
        end
        if size(sizeChange) == size([])
            sizeChange = meanSizeChange;
        else
            sizeChange = [sizeChange;meanSizeChange];
        end
        meanSizeChange = [];
        
    end
    
    input('Press enter to see size change comparative graph');
    figure('name',strcat('Comparison of size change for dataset: ',datasetName));
    
    b = bar(sizeChange); 
    title(strcat('Comparison of size change for dataset: ',datasetName));
    set(gca,'xticklabel', l);
    colormap(summer(3));
    legend(b,lr);  
    grid on   
    
    
    %% Efficiency graph
    efficiency = [];
    meanEfficiency = [];
    for i=1:8
        for k=[1,2,3]
            statsI = totalStats(i);
            meanEfficiency = [meanEfficiency,mean(statsI.efficiency(k,:))];
        end
        if size(efficiency) == size([])
            efficiency = meanEfficiency;
        else
            efficiency = [efficiency;meanEfficiency];
        end
        meanEfficiency = [];        
    end
    
    input('Press enter to see efficiency comparative graph');
    figure('name',strcat('Comparison of efficiency for dataset: ',datasetName));
    
    b = bar(efficiency); 
    title(strcat('Comparison of efficiency for dataset: ',datasetName));
    set(gca,'xticklabel', l);
    colormap(summer(3));
    legend(b,lr);  
    grid on 
end