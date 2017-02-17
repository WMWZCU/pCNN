function [net, info] = vai_train_rs_cnn(varargin)

opts.batchNormalization = false ;
opts.networkType = 'simplenn' ;
[opts, varargin] = vl_argparse(opts, varargin) ;

sfx = opts.networkType ;
if opts.batchNormalization, sfx = [sfx '-bnorm'] ; end
opts.expDir = 'E:\Programing\Matlab_program\Twelve\vai' ;
[opts, varargin] = vl_argparse(opts, varargin) ;
opts.train = struct() ;
opts = vl_argparse(opts, varargin) ;
if ~isfield(opts.train, 'gpus'), opts.train.gpus = []; end;

%Prepare data and net
net = vai_cnn_rs_init('batchNormalization', opts.batchNormalization, ...
                     'networkType', opts.networkType) ;
load('van_imdb.mat') ;

[net, info] = cnn_train(net, imdb, getBatch(opts), ...
  'expDir', opts.expDir, ...
  net.meta.trainOpts, ...
  opts.train, ...
  'val', find(imdb.images.set == 3)) ;


% --------------------------------------------------------------------
function fn = getBatch(opts)
% --------------------------------------------------------------------
switch lower(opts.networkType)
  case 'simplenn'
    fn = @(x,y) getSimpleNNBatch(x,y) ;
  case 'dagnn'
    bopts = struct('numGpus', numel(opts.train.gpus)) ;
    fn = @(x,y) getDagNNBatch(bopts,x,y) ;
end

% --------------------------------------------------------------------
function [images, labels] = getSimpleNNBatch(imdb, batch)
% --------------------------------------------------------------------
images = imdb.images.data(:,:,:,batch) ;
labels = imdb.images.labels(1,batch) ;
