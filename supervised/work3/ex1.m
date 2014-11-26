function [] = ex1()
    
    %
    input('Block 1: Press enter to plot data_set 1 data');
    % data values will be loaded to x and y
    load('reg_data_set_1.mat');
    
    figure('name','Raw data and linear approximation plot');
    plot(x,y,'bo'); hold on;
    
%     %%
%     input('Block 2: Press enter to plot the best fit by analytical linear regression');
%     % Simple linear regression following http://www.le.ac.uk/users/dsgp1/COURSES/THIRDMET/MYLECTURES/2MULTIREG.pdf
%     
%     % simple linear regression
%     %p = polyfit(x,y,1);
%     % adding a one values column for constant coefficient to X
%     o = ones(size(x,1),1);
%     x = [o,x];  
%     
%     % ?? = (X'X)^-1X'y
%     coeff = inv(x'*x)*(x'*y);
%     disp('Coefficients for analytical regression');
%     disp(coeff);
%     
%     y = lfunc(coeff,x);
%     plot(x,y,'r-');
%     
%     % The obtained weights are [-2.0474, 79948]
%     % This weights show a good linear approximation but a bad approximation
%     % of the shape of data in general. The linear approximation is also
%     % a bit biased by the data in the x intervals [0,0.2] and [0.9,1], so
%     % values between [0.2,0.9] are not that well covered.
% 
%     %%
%     load('reg_data_set_1.mat');
%     input('Block 3: Press enter to plot the best fit by gradient descent method')
%     disp('Warning: this function is deliberately slow to show convergence graphically');
%     [gdw, conv_matrix] = gdescent(x,y,0.01,0.00001,5000,true,false);
%     % The obtained weights using a step of 0.01 and a threshold of 0.00001
%     % are [-1.8060, 7.5476] after 4350 iterations
%     
%     disp('Coefficients for gradient descent');
%     disp(gdw);
%    
%     o = ones(size(x,1),1);
%     x = [o,x]; 
%     y = lfunc(gdw,x);
%     plot(x,y,'g-');
% 
%     input('Press enter to see the convergence curve');
%     % Showing the convergence curve. It can be observed how given the low
%     % learning rate the gradient is still being descended so the
%     % convergence curve does not oscilate but is constantly decreasing.
%     figure('name','Convergence Matrix for gradient descent lr=0.01, thr=0.00001');
%     plot(conv_matrix(:,1),conv_matrix(:,2),'b-');
%     
%     load('reg_data_set_1.mat');
%     input('Press enter to see the convergence curve for lr=0.1 thr=0.00001')
%     [gdw, conv_matrix] = gdescent(x,y,0.1,0.00001,5000,false,false);
%     figure('name','Convergence Matrix for gradient descent lr=0.1, thr=0.00001');
%     plot(conv_matrix(:,1),conv_matrix(:,2),'r-');
%     %oscilations are not observed clearly, but it should oscilate with
%     %larger learning rates
%     
%     disp('Coefficients for gradient descent, bigger Learning Rate');
%     disp(gdw);
% 
%     % 
%     %%
%     load('reg_data_set_1.mat');
%     input('Block 4: Press enter to calculate the best fit by modified gradient descent method')
%     disp('Warning: this function is deliberately slow to show convergence graphically');
%     [gdw, conv_matrix] = gdescent(x,y,0.01,0.00001,2000, false,true);
%     % The obtained weights using a step of 0.01 and a threshold of 0.00001
%     % are [-2.0554, 7.9905] after 782 iterations with a  min error of
%     % 1.2938
%     
%     disp('Coefficients for modified gradient descent');
%     disp(gdw);
% 
%     input('Press enter to see the convergence curve');
%     figure('name','Convergence Matrix for modified gradient descent lr=0.01, thr=0.00001');
%     plot(conv_matrix(:,1),conv_matrix(:,2),'b-');
%     % when zooming small oscillations are observed, this is caused because
%     % dividing by the norm returns the unit vector which makes the learning
%     % rate to have greater influence in the magnitude. This causes that the
%     % area is less explored causing jumps that avoid the local minimum.
%     
%     
%     load('reg_data_set_1.mat');
%     input('Press enter to see the convergence curve for lr=0.1 thr=0.00001')
%     [gdw, conv_matrix] = gdescent(x,y,0.1,0.00001,2000, false,true);
%     figure('name','Convergence Matrix for modified gradient descent lr=0.1, thr=0.00001');
%     plot(conv_matrix(:,1),conv_matrix(:,2),'r-');
%     % obtained coefficients are [-2.0934,7.9700] after 79 iterations with
%     % min error of 1.2939
%     % for a bigger learning rate the oscillation is even greater showing
%     % the influence the rate is getting in the next areas to explore. In
%     % general it is observed how the descense is done faster, thus
%     % converging faster byt less accurately.
%     
%     disp('Coefficients for gradient descent, bigger Learning Rate');
%     disp(gdw);

        
    %
    load('reg_data_set_1.mat');
    input('Block 5: Press enter to calculate the best fit by p=3 linear regresion')
    xpanded = expand_dataset(x,3);
    [gdw, conv_matrix] = gdescent(xpanded,y,0.01,0.00001,100000, false,false);
    % The obtained weights using a step of 0.01 and a threshold of 0.00001
    % are [0.6012, -4.5036, 3.6542, 9.8509] after 99999 iterations with a  min error of
    % 0.37081
    
    o = ones(size(x,1),1);
    xpanded = [o,xpanded]; 
    y = lfunc(gdw,xpanded);
    plot(x,y,'g+');
    
    disp('Coefficients for modified gradient descent');
    disp(gdw);

    input('Press enter to see the convergence curve');
    figure('name','Convergence Matrix for modified gradient descent lr=0.01, thr=0.00001');
    plot(conv_matrix(:,1),conv_matrix(:,2),'b-');

    
    
    load('reg_data_set_1.mat');
    input('Press enter to see the convergence curve for lr=0.1 thr=0.00001')
    xpanded = expand_dataset(x,3);
    [gdw, conv_matrix] = gdescent(xpanded,y,0.1,0.00001,100000, false,false);
    figure('name','Convergence Matrix for modified gradient descent lr=0.1, thr=0.00001');
    plot(conv_matrix(:,1),conv_matrix(:,2),'r-');
    % obtained coefficients are [-2.0934,7.9700] after 79 iterations with
    % min error of 1.2939

    
    disp('Coefficients for gradient descent, bigger Learning Rate');
    disp(gdw);
      
end