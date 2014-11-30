% Introduction to Machine Learning (IML) - Exercise 3
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

function [] = ex2()
    input('Plotting training set');
    % data values will be loaded to x and y
    load('reg_data_set_2.mat');
    
    
    % splitting into training and test set and sorting x values
    trainx = x(1:int8(size(x,1)/2),1);
    trainy = y(1:int8(size(y,1)/2),1);
    train = [trainx trainy];
    strain = sort_one_col(train);
    
    trainx = strain(:,1);
    trainy = strain(:,2);
    
    testx = x(int8(size(x,1)/2):size(x,1),1);
    testy = y(int8(size(y,1)/2):size(y,1),1);
    test = [testx testy];
    stest = sort_one_col(test);
    
    testx = stest(:,1);
    testy = stest(:,2);
    
    figure('name','Raw data split into training and test samples');
    plot(trainx,trainy,'r+'); hold on;
    plot(testx,testy,'bo'); hold on;
    
    % creating legend
    labels = {};
    labels{1,1} = 'Training (x,y) points';
    labels{1,2} = 'Testing (x,y) points';
    
    legend(labels,'FontSize',14,'FontWeight','bold');    
    
    %%
    % Training and plotting against trainining
    input('Press enter to view p=1:6 linear models for training set');
    figure('name','Raw data and linear approximation plot (Training set)');
    plot(trainx,trainy,'bo'); hold on;

    markers =['y','r','b','g','m','c']; 
    trainrms = [];
    for p=1:6
        xpanded = expand_dataset(trainx,p);
        w = analytic_polyfit(xpanded,trainy);
       	polygraph(p,min(trainx),max(trainx),w,markers(p));
        
        o = ones(size(xpanded,1),1);
        outy = lfunc(w,[o,xpanded]);
        rms = sqrt(sum((outy-trainy).^2));
        trainrms = [trainrms;rms];
    end
    
    % creating legend
    labels = {};
    labels{1,1} = 'Training (x,y) points';
    for p=1:6
        labels{1,p+1} = strcat('Poly. degree: ', num2str(p));
    end
    
    legend(labels,'FontSize',14,'FontWeight','bold');
    
    %% 
    % Training and plotting against test set
    input('Press enter to view p=1:6 linear models for test set');
    figure('name','Raw data and linear approximation plot (Test set)');
    plot(testx,testy,'bo'); hold on;

    markers =['y','r','b','g','m','c']; 
    testrms = [];
    for p=1:6
        xpanded = expand_dataset(trainx,p);
        w = analytic_polyfit(xpanded,trainy);
        polygraph(p,min(testx),max(testx),w,markers(p));
        
        xpandedtest = expand_dataset(testx,p);
        o = ones(size(xpandedtest,1),1);
        
        outy = lfunc(w,[o,xpandedtest]);
        rms = sqrt(sum((outy-testy).^2));
        testrms = [testrms;rms];
    end
    
    % creating legend
    labels = {};
    labels{1,1} = 'Test (x,y) points';
    for p=1:6
        labels{1,p+1} = strcat('Poly. degree: ', num2str(p));
    end
    
    legend(labels,'FontSize',14,'FontWeight','bold');


    %% 
    % Plotting root means square for both training and test set
    input('Press enter to view both RMS curves');
    figure('name','RMS curves for polynomials of degree p=1:6 in training and test set');
    plot(1:6,trainrms,'b-'); hold on;
    plot(1:6,testrms,'r-'); hold on;
    
    % creating legend
    labels{1,1} = 'Training set RMS';
    labels{1,2} = 'Test set RMS';
    legend(labels,'FontSize',14,'FontWeight','bold');
    
    input('Press enter to view the difference of RMS between the two curves');
    figure('name','Differences of RMS between training and data set fit');
    plot(1:6,abs(trainrms-testrms),'b-'); hold on;
    
    % creating legend
    labels{1,1} = 'Training set - Test set RMS';
    legend(labels,'FontSize',14,'FontWeight','bold');

    
end

