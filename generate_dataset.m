% load Original image and the corresponding ground-truth data
load data/gt_half_half.mat; % load the original image
load data/image_half_half.mat; % load the reference map
im = image_half_half;
gt = gt_half_half;
tr_num = 0.2;
val_num=0.2;
% Begain to generate samples
temp_blob=[];
temp_label = [];
set = [];
count = 1;

for i = 1:size(unique(gt),1) 
    [temp_x, temp_y] = find(gt==i);
    total_num = tr_num+val_num;
    num_total = fix(total_num*size(temp_x,1));
    idx_tr =  randint(1,num_total,[1,size(temp_x,1)]);
    temp_x = temp_x(idx_tr);
    temp_y = temp_y(idx_tr);
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
    temp_set = ones(1,size(temp_x,1))*3;
    % number of validation samples or training samples
    num_tr = fix(tr_num/(total_num)*size(temp_x,1));
    idx_tr =  randint(1,num_tr,[1,size(temp_x,1)]);
    temp_set(idx_tr) = 1;
    set = cat(2,set,temp_set);
    fprintf('Already %f of total samples were generated',i/size(unique(gt),1));
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
save('Van_imdb.mat', '-struct', 'imdb') ;

% Then run train_rs_cnn.m 
% Then predict whole image labels by using label_predict.m

