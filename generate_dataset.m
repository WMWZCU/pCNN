% load Original image and the corresponding ground-truth data

load data\gt_half_half.mat;
load data\image_half_half.mat;
im = image_half_half;
gt = gt_half_half;
% Select all samples
temp_blob=[];
temp_label = [];
set = [];
count = 1;

for i = 1:size(unique(gt),1) 
    [temp_x, temp_y] = find(gt==i);
    for j=1:size(temp_x,1)
            if temp_x(j)-9<1 
                temp_x(j) =10;
            end
            if temp_x(j)+9>size(im,1)
                temp_x(j) = size(im,1)-10;
            end
            if temp_y(j)-9<1
                temp_y(j) = 10;
            end
            if temp_y(j)+9>size(im,2)
                temp_y(j) = size(im,2)-10;
            end
            temp_store = im(temp_x(j)-9:temp_x(j)+8,temp_y(j)-9:temp_y(j)+8,:);
            
            temp_blob(count,:)=temp_store(:);
            temp_label(count)=i;
            count = count+1;
    end   
    temp_set = ones(1,size(temp_x,1));
    % number of validation samples
    num_val = fix(0.8*size(temp_x,1));
    idx =  randint(1,num_val,[1,size(temp_x,1)]);
    temp_set(idx) = 3;
    set = cat(2,set,temp_set);
end
data = single(reshape(temp_blob',18,18,3,[]));
dataMean = single(mean(data(:,:,:,:), 4));
data = bsxfun(@minus, data, dataMean) ;

% Construct image dataset
imdb.images.data = single(data) ;
imdb.images.labels = temp_label(1,:) ;
imdb.images.set = set ;
imdb.images.data_mean = dataMean;
imdb.meta.sets = {'train', 'val', 'test'} ;
imdb.meta.classes = arrayfun(@(x)sprintf('%d',x),1:size(unique(gt),1),'uniformoutput',false) ;
save('Vaihingen\Van_imdb.mat', '-struct', 'imdb') ;

% Then run train_rs_cnn.m 
% Then predict whole image labels by using label_predict.m

