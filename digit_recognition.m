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
    x = medfilt2(I, [5, 5]);

    for num = 3 : numel(template_path_dir)
        x = x(:,:,1);
        template = imread([template_path template_path_dir(num).name]);
        template = template(:,:,1);
        current_number = template_path_dir(num).name(7);
        current_number = str2double(current_number);
        for i=1:4
            c = normxcorr2(template, x);
            [ypeak,xpeak] = find(c==max(c(:)));
            yoffSet = ypeak-size(template,1);
            xoffSet = xpeak-size(template,2);
            
            if max(c(:)) > 0.8 
                sum = sum + current_number;
                for row = yoffSet : ypeak
                    for col = xoffSet : xpeak
                        if row == 0 | col == 0
                            row = row + 1;
                            col = col + 1;
                        end
                        x(row, col) = 0;

                    end
                end

                x = insertText(x, [(xoffSet + xpeak)/2 (yoffSet + ypeak)/2], num,'FontSize', 20, 'BoxColor', 'red', 'TextColor', 'white');
                x = x(:,:,1);
            end
        end    
    end
    
end

