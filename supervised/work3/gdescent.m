
% Performs a gradient descent linear approximation of the data [x,y] 
% with step size equal to 'learning_rate' and stoping when the given
% 'treshold' value is met between the difference of errors in each
% successive iteration. 
% 'doplot' is a boolean value indicating if a continuous approximation plot
% should be performed to visually observe the process
function [w, conv_matrix] = gdescent(x,y,learning_rate,cutting_threshold,num_iterations, doplot, modified)
    min_error = realmax;
    original_x = x;
    o = ones(size(x,1),1);
    x = [o,x];
    x = x';   
    
    %w = ones(size(x,1),1);
    w = rand(size(x,1),1)/10;
    n = 1/size(x,2);
    n2 = n/2;
    count = 0;
    previous_error = 0;
    error = realmax;
    min_error = realmax;
    min_iterations =0;
   
    conv_matrix = [];
    h = plot([0],[0]);       
    
    % count==0 to simulate do-while
    while num_iterations >0 & abs(previous_error-error)>cutting_threshold
        num_iterations = num_iterations-1;
      
        % calculate gradient
        divided_x = n.*x;
        gradient_delta = divided_x*((x'*w)-y);
        
        % update weights
        if modified
            grad = gradient_delta./norm(gradient_delta);
            w = w - learning_rate.*grad;
        else
            w = w - learning_rate.*gradient_delta;
        end
        
        % calculate new minimum
        previous_error = error;
        error = (n2.*((x'*w)-y)')*((x'*w)-y);
        if error<min_error
            min_error = error;
            min_iterations=count; 
        end
        
        count = count+1;
        
        % adds value to convergence matrix
        conv_matrix = [conv_matrix; count error];
        
        % plot just when random happens to make it possible
        % to be visualized
        if doplot & rand(1,1)<0.05
            pause(0.01)
            delete(h);
            new_y = lfunc(w,[o,original_x]);
            h = plot(original_x,new_y,'g-'); 
        end
    end
    
    if doplot
        delete(h);
    end
    disp(strcat('Num Iterations: ',num2str(min_iterations)));
    disp(strcat('Min Error: ',num2str(min_error)));
end