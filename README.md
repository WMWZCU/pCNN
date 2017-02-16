# Per-Pixel CNN (PCNN) for high-resolution imagery classification
This project aims to classify high-resolution images by ultilizing deep convolutional neural networks. If you find this is help to your work, please cite our papers "Spectral–spatial feature extraction for hyperspectral image classification: A dimension reduction and deep learning approach,IEEE Transactions on Geoscience and Remote Sensing 54 (8), 4544-4554". Thanks!

Step.1: Generate image patch-based traning dataset using "generate_dataset.m"
In this step, 20% of total available samples were selected to train CNN models.



Step.2: Train a 5-layer CNN with "vai_train_rs_cnn.m"



Step.3: Predict the whole map's labels with the well-trained CNN
