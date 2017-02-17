# Per-Pixel CNN (PCNN) for high-resolution imagery classification
This project aims to classify high-resolution images by ultilizing deep convolutional neural networks. If you find this to be helpful, please cite our paper ["Spectral–spatial feature extraction for hyperspectral image classification: A dimension reduction and deep learning approach,IEEE Transactions on Geoscience and Remote Sensing 54 (8), 4544-4554"](http://ieeexplore.ieee.org/abstract/document/7450160/). Thanks! <br />
This project is a prototype of our work (slightly different from the method used in our paper), if you have some specific concerns, please feel free to contact: w.zhao@pku.edu.cn

* Prerequisits: Matconvnet 1.0-beta19 or later. Before test the codes, Matcovnet should be included into the system path.

## Step.1: Use "generate_dataset.m" to generate training samples
In this step, 20% of available samples were selected to train CNN models. Each labeled pixel corresponding to a square image patch (e.g., 18\*18\*3 in this demo).
The structure of generated training samples in this demo (Vai_imdb.mat):<br />
-imdb.mat<br />
-- images<br />
--- data(image patches)<br />
--- labels<br />
--- set(training or validation)<br />
--- mean_data<br />
-- metadata<br />
P.S. The process of generating dataset could be slow in this version, be patient :) 

## Step.2: Train a 5-layer CNN with "vai_train_rs_cnn.m"
Due to the sizes of training samples, we deployed a 5-layer CNN (18(Con_3)-16(Pool/2)-8(Con_3)-6(Pool/2)-3(Con_3)-1). The feature number of each convultional layer was set to 20. The training and validation errors should be drop down to around 0.2 after 100 iterations (i.e. around 80% accuracy). Of course, you can change the CNN configuration parameters accordingly. The training process should be something like this:<br />

<img src="https://github.com/WMWZCU/pCNN/blob/master/data/vai_cnn.png" alt="Training" width="600" height="410">



## Step.3: Predict the whole map's labels with "interface_predict.m"
The well-trained CNN model generated from step 2 is used in this step. Be aware, change the last layer of well-trained CNN into "softmax". Then input the original map to perform prediction. The classified image should be something like this:<br />

<img src="https://github.com/WMWZCU/pCNN/blob/master/data/CNN_classify.png" alt="Results" width="600" height="430">
