clear all;close all;clc;

imgDir = './gsdam_result/open/';
outDir= './result/';
mkdir(outDir);
inputPath = dir(imgDir);

for imgNum = 1:length(inputPath),
     if inputPath(imgNum).name(1)=='.'
            continue;
     end
    inputImgName = strcat(inputPath(imgNum).name);
    imgFile = strcat(imgDir,inputImgName);
    outFile = [outDir inputPath(imgNum).name(1:end-4) '.png'];
    I=imread(imgFile);
    %your code here
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [m,n,z] = size(I); 
    if z==3
       I = rgb2gray(I);
    end
    I = I(2:m-1,2:n-1);
    I(I~=0)=255;
    imwrite(I,outFile); 
    imgLabel=bwlabel(I);
    imgLabel=imgLabel+1;
    save(outFile,'SegLabel'); 
end
