function [totalStats] = testAllACBRCombinations(dataset,isWeighted)

    if isequal(dataset(1:3),'ZOO')
        [STDData, pf] = prepare_zoo_kmeans('datasets_iml_course/zoo/zoo.arff');
        Categories = pf.type.values()';
        
    elseif isequal(dataset(1:7),'SEGMENT')
        [STDData, pf] = prepare_segment_kmeans('datasets_iml_course/segment/segment.arff');
        Categories = pf.class.values()';
    elseif isequal(dataset(1:8),'PENBASED')
        [STDData, pf] = prepare_penbased_kmeans('datasets_iml_course/pen-based/pen-based.arff');
        Categories = pf.a17.values()';
    end    
       
    p=randperm(size(STDData,1));
    %p=[69,90,54,46,89,32,53,48,81,45,9,4,5,7,21,19,76,22,87,42,35,15,68,61,51,77,43,97,75,82,63,92,65,37,83,38,96,67,47,31,39,1,80,11,71,100,23,94,41,56,59,30,10,24,49,13,17,16,78,18,84,28,29,34,95,33,52,99,85,36,40,6,93,72,91,14,2,8,73,74,66,27,44,88,58,50,60,25,20,86,98,12,3,64,62,55,26,79,57,101,70];
    
    STDData = STDData(p,:);
    Categories = Categories(p,:);

    NFolds =10;
    NTest = floor(size(STDData,1)/NFolds);
        
    totalStats = [];
    
    % try for non-weighted and weighted
    % preparing initial data
    %K=7;
    FeatureSelection = 'RELIEF';
    
    
    % version reducing dimensionality
    %[newSTDData, Weights, Features] = preprocessData(STDData, Categories, 7, FeatureSelection);

    %version not reducing dimensionality
    if isWeighted
        [newSTDData, Weights, Features] = preprocessData(STDData, Categories, 7, FeatureSelection);
        newSTDData = STDData;
        Features = [1:size(newSTDData,2)];
    else
        newSTDData = STDData;
        Weights = ones(1,size(newSTDData,2));
        Features = [1:size(newSTDData,2)];
    end
    
    for c=1:2
        %% Testing for NFolds on combination c

        numValidVK = [];
        totalVK = [];
        efficiencyVK = [];
        sizeChangeVK = [];

        for K=[3,5,7]
            disp(strcat('Trying combination: ',getCombination(c),' with K=',num2str(K)));
            numValidV = [];
            totalV =[];
            efficiencyV = [];
            sizeChangeV = [];
            for i = 1:NFolds
                % preparing folds
                fold = [(i-1)*NTest+1:i*NTest];
                TestData = newSTDData(fold,:); 

                rangeData = [1:size(newSTDData,1)];
                rangeTest = p(fold);

                inverse = find(~ismember(rangeData,rangeTest));
                TrainData = newSTDData(inverse,:);
                CategoriesTrainData = Categories(inverse,:);

                % Stats array containing [accuracy,number_of_instances,data_size_variation]
                Stats = zeros(1,3);

                goodness = ones(size(TrainData,1),1)*0.5;
                initGoodness = 0.5;

                % instance of database (its called weighted as a
                % generalization so a non-weighted ACBR is a weight 1 ACBR).
                weightedSTDData = TrainData;
                weightedCategories = CategoriesTrainData;
                weightedGoodness = goodness;

                % Preparing stat gathering variables
                total = 0;
                valid = 0;

                tic;
                for j=1:size(TestData,1)
                    total = total+1;
                    instance = TestData(j,:);
                    instanceClass = Categories(fold(j));

                    %% call an specific ACBR algorithm according to the current combination
                   
                    [newStats, weightedSTDData, weightedCategories, weightedGoodness, weightedClass] = callACBRAlgorithm(isWeighted,getCombination(c),Stats,weightedSTDData,weightedCategories,weightedGoodness,initGoodness, instance,instanceClass,K,Weights, Features);
                    %[newStats, weightedSTDData, weightedCategories, weightedGoodness, weightedClass] = weightedACBRAlgorithm(Stats,weightedSTDData,weightedCategories,weightedGoodness,initGoodness, instance,instanceClass,K,'WeightedVoting',Weights, Features);   
                    if categorieToNum(Categories,instanceClass) == categorieToNum(Categories,weightedClass)
                        valid = valid+1;
                    end
                end
                timerVal = toc;

                %% gathering stats
                numValidV = [numValidV, valid];
                totalV = [totalV,total];
                efficiencyV = [efficiencyV,timerVal];
                sizeChangeV = [sizeChangeV, size(inverse,2)-size(weightedSTDData,1)];

            end
            numValidVK = [numValidVK; numValidV];
            totalVK = [totalVK; totalV];
            efficiencyVK = [efficiencyVK; efficiencyV];
            sizeChangeVK = [sizeChangeVK; sizeChangeV ];

        end
        combStats = struct('numValid',numValidVK,'total',totalVK,'dataSetSizeChange',sizeChangeVK,'efficiency',efficiencyVK);      
        totalStats = [totalStats,combStats];
    end        
    
end