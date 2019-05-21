clear all; clc; addpath(genpath(pwd));

filename='101_1.tif';
img = imread(filename);
if ndims(img) == 3; img = rgb2gray(img); end  % Color Images
disp(['Extracting features from ' filename ' ...']);
ffnew=ext_finger(img,1);

second='101_3.tif';
disp(['Computing similarity between ' filename ' and ' second ' from FVC2002']);
S=match(ffnew,ff{i},1);
