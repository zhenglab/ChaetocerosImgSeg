clear all;close all;clc;

imgDir = './result/';
outDir= './mat/';
mkdir(outDir);
inputPath = dir(imgDir);

for imgNum = 1:length(inputPath),
     if inputPath(imgNum).name(1)=='.'
            continue;
     end
    inputImgName = strcat(inputPath(imgNum).name);
    imgFile = strcat(imgDir,inputImgName);
    outFile = [outDir inputPath(imgNum).name(1:end-4) '.mat'];
    if exist(outFile,'file'), continue; end
    I=imread(imgFile);
    %your code here
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    I=rgb2gray(I);
    imgLabel=bwlabel(I);
    imgLabel=imgLabel+1;
    save(outFile,'SegLabel'); 
end
