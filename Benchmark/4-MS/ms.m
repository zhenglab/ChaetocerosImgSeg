clear all;clc;

imgPath = '../../Dataset/Image';
outputLabPath = './mat';
outputMSPath = './result';

mkdir(outputLabPath);
mkdir(outputMSPath);

inputPath = dir(imgPath);

M = 2000;
hs = 10;
hr = 13;

for imgNum = 1:length(inputPath)
           if inputPath(imgNum).name(1)=='.'
            continue;
        end
        inputImgName = strcat(inputPath(imgNum).name);
        inputImgPathAndName = [imgPath inputImgName];

        inputImg = imread(inputImgPathAndName);

        [outputImg,SegLabel] = msseg(inputImg,hs,hr,M);

        outputLab = [outputLabPath inputPath(imgNum).name(1:end-4) '.mat'];
        outputMS = [outputMSPath inputImgName];
        imwrite(outputImg,outputMS);
        save(outputLab,'SegLabel');
end