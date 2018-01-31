clear all;

clear all;close all;clc;

imgDir1 = './imgresult/';
imgDir2 = './data/label/';
outDir= './finalresult/';
mkdir(outDir);
inputPath = dir(imgDir1);

for imgNum = 1:length(inputPath),
     if inputPath(imgNum).name(1)=='.'
            continue;
     end
    inputImgName = strcat(inputPath(imgNum).name);
    imgFile1 = strcat(imgDir1,inputImgName);
    imgFile2 = strcat(imgDir2,inputImgName);

    outFile = [outDir inputPath(imgNum).name(1:end-4) '.png'];
    img=imread(imgFile1);
    positive=imread(imgFile2);
 
    [m,n]=size(img);
    for i=1:m
        for j=1:n
            if positive(i,j)==1
                img(i,j)=255;
            end
        end
    end
   imwrite(img,outFile);    
end
