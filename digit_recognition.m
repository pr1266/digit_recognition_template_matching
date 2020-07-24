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


end

