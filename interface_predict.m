% load original image and mean_image 
load image_half_half.mat;
load gt_half_half.mat;
load van_imdb.mat; %load the mean_data from imdb
mean_image = imdb.images.data_mean;
im = image_half_half;
gt= gt_half_half;
clear imdb;
clear image_half_half;

% load well-trained net
load('vai_layer5.mat'); % Leared from CNN, change the last layer to "softmax"

pre_label = [];
for i=10:size(im,1)-9
    for j=10:size(im,2)-9
        temp_store = single(im(i-9:i+8,j-9:j+8,:));
        %temp_blob(count,:)=temp_store(:);h = find(cdata==9)h = h
        data = bsxfun(@minus, temp_store, mean_image) ;
        res = vl_simplenn(net, single(data)) ;%compile Matcovnet again, if error occurred
        temp_pre = res(7).x;
        pre_label(i-9,j-9) = find(temp_pre==max(max(temp_pre)));
        gt_label(i-9,j-9) = gt(i,j);
    end
end

%[kappa acc acc_O acc_A] = evaluate_results(pre_label(:), gt_label(:));
