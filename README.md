# Per-Pixel CNN (PCNN) for high-resolution imagery classification
This project aims to classify high-resolution images by ultilizing deep convolutional neural networks. If you find this to be helpful, please cite our paper ["Spectral–spatial feature extraction for hyperspectral image classification: A dimension reduction and deep learning approach,IEEE Transactions on Geoscience and Remote Sensing 54 (8), 4544-4554"](http://ieeexplore.ieee.org/abstract/document/7450160/). Thanks!

** Prerequisits: Matconvnet 1.0-beta19 or later. Before test the codes, Matcovnet should be included into the system path.

## Step.1: Use "generate_dataset.m" to generate traning samples
In this step, 20% of available samples were selected to train CNN models. 
The structure of generated training samples in this demo (Vai_imdb.mat):
-imdb
--images
---data(image patches)
---labels
---set(training or validation)
---mean_data
--metadata


## Step.2: Train a 5-layer CNN with "vai_train_rs_cnn.m"



## Step.3: Predict the whole map's labels with the well-trained CNN
