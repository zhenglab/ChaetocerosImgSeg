addpath lib;

clear all;close all;clc;

imgDir = '../../Dataset/Image/';
outDir = './mat/';
mkdir(outDir);
inputPath = dir(imgDir);

tic;
for imgNum = 1:length(inputPath),
     if inputPath(imgNum).name(1)=='.'
            continue;
     end
    inputImgName = strcat(inputPath(imgNum).name);
    imgFile = strcat(imgDir,inputImgName);
    outFile = [outDir inputPath(imgNum).name(1:end-4) '.mat'];
    if exist(outFile,'file'), continue; end
    im2ucm(imgFile, outFile);
end
toc;
