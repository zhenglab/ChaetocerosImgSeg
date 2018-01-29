addpath lib;

clear all;close all;clc;

imgDir = '../../Dataset/Image/';
outDir = './boundary/';
mkdir(outDir);
inputPath = dir(imgDir);


for imgNum = 1:length(inputPath),
     if inputPath(imgNum).name(1)=='.'
            continue;
     end
    inputImgName = strcat(inputPath(imgNum).name);
    imgFile = strcat(imgDir,inputImgName);
    outFile = [outDir inputPath(imgNum).name(1:end-4) '.png'];
    if exist(outFile,'file'), continue; end
    gPb_orient = globalPb(imgFile);
    ucm = contours2ucm(gPb_orient, 'imageSize');
    imwrite(ucm,outFile);
end

