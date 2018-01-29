%SC indice
addpath lib;

clear all;close all;clc;

imgDir = '../../Dataset/Image';
gtDir = '../../Dataset/Groundtruth_mat';
inDir = '../canny/mat';
outDir = './canny_results';
mkdir(outDir);

tic;
regionBench(imgDir, gtDir, inDir, outDir);
toc;