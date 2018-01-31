clear all;close all;clc;

imgDir = './data/dataset/';
labelDir= './data/label1/';
outDir= './data/label/';
mkdir(outDir);

inputPath = dir(imgDir);

for imgNum = 1:length(inputPath),
     if inputPath(imgNum).name(1)=='.'
            continue;
     end
    inputImgName = strcat(inputPath(imgNum).name);
    imgFile = strcat(imgDir,inputImgName);
    labelFile = [labelDir inputPath(imgNum).name(1:end-4) '.png'];
    outFile = [outDir inputPath(imgNum).name(1:end-4) '.png'];
    
    img=imread(imgFile);
    label=imread(labelFile);
    img = rgb2gray(img);
    img(label~=0) = 0; 
    hist = imhist(img);
    hist(1) = 10000000;
    [sorthist,index] = sort(hist);

    for i=1:256-50
        label(img==(index(i)-1)) = 255;
    end
    imwrite(label,outFile); 
end
