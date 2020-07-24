%% dataSet path :
data_set_path = 'Q3\Dataset\';
template_path = 'img_dataset\';

%% convert path to dir :
data_set_dir = dir(data_set_path);
template_path_dir = dir(template_path);

%% accuracy :
acc = 0;

for image = 3 : numel(data_set_dir)

    %% sum for calculate digits sum in image :
    sum = 0;
    
    %% read image :
    I = imread([data_set_path data_set_dir(image).name]);
    
    %% apply median filter to remove noise :
    x = medfilt2(rgb2gray(I), [5, 5]);
    
    %% calculate norm with all templates :
    for num = 3 : numel(template_path_dir)
        %% match all templates with picture :
        x = x(:,:,1);
        template = imread([template_path template_path_dir(num).name]);
        template = template(:,:,1);
        current_number = template_path_dir(num).name(7);
        current_number = str2double(current_number);
        for i=1:4
            %% normXcorr :
            c = normxcorr2(template, x);
            %% x, y, w, h
            [ypeak,xpeak] = find(c==max(c(:)));
            yoffSet = ypeak-size(template,1);
            xoffSet = xpeak-size(template,2);
            
            %% threshold for norm :
            if max(c(:)) > 0.8 
                sum = sum + current_number;
                for row = yoffSet : ypeak
                    for col = xoffSet : xpeak
                        if row == 0 | col == 0
                            row = row + 1;
                            col = col + 1;
                        end
                        
                        %% now we turn pixel value to zero
                        %% to reduce error in other iterations :
                        x(row, col) = 0;

                    end
                end
                   
                %% insert calculated sum into image :
                x = insertText(x, [(xoffSet + xpeak)/2 (yoffSet + ypeak)/2], num,'FontSize', 20, 'BoxColor', 'red', 'TextColor', 'white');
                x = x(:,:,1);
            end
        end    
    end
        
        %% save new image :
        I = insertText(I, [200 980], sum, 'FontSize', 30, 'BoxColor', 'black', 'TextColor', 'white');
        imwrite(I, [data_set_path data_set_dir(image).name]); 
        goal_sum = str2double(data_set_dir(image).name(end - 5: end - 4));
        disp('name');
        disp(data_set_dir(image).name);
        disp('sum');
        disp(sum);
        
        %% check if algorithm works :
        if sum == goal_sum
            acc = acc + 1;
        end
end

%% accuracy :
disp('accuracy : ');
disp(acc);