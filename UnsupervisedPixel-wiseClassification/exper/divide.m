clc;
clear all;
imgdir = './data/dataset/';
divdir = './data/testset/';

mkdir(divdir);
inputPath = dir(imgdir);

for imgNum = 1:length(inputPath),
     if inputPath(imgNum).name(1)=='.'
            continue;
     end
    inputImgName = strcat(inputPath(imgNum).name);
    imgFile = strcat(imgdir,inputImgName);    
dst_h = 900;
dst_w = 900;
img = imread(imgFile);
[height,width,channel] = size(img);
numh = floor(height/dst_h);
if ((height/dst_h - numh) == 0)
    numh = numh+0;
else numh = numh+1;
end
numw = floor(width/dst_w);
if ((width/dst_w - numw) == 0)
    numw = numw+0;
else numw = numw+1;
end

for i=1:numh
    for j=1:numw
        if i==numh && j==numw
            temp = img((i-1)*dst_h+1:end , (j-1)*dst_w+1:end,:);
        elseif i==numh
            temp = img((i-1)*dst_h+1:end , (j-1)*dst_w+1:j*dst_w,:);
        elseif j==numw
            temp = img((i-1)*dst_h+1:i*dst_h , (j-1)*dst_w+1:end,:);
        else
        temp = img((i-1)*dst_h+1:i*dst_h , (j-1)*dst_w+1:j*dst_w,:);
        end
        imwrite(temp,[divdir,inputPath(imgNum).name(1:end-4),'_',int2str(i),'_',int2str(j),'.ppm']);
    end
end
end
