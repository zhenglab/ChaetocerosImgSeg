clear all;close all;clc;

imgDir1 = './data/dataset/';
imgDir2 = './data/gsdam/';
outDir= './data/label1/';
mkdir(outDir);
inputPath = dir(imgDir1);

for imgNum = 1:length(inputPath),
     if inputPath(imgNum).name(1)=='.'
            continue;
     end
    inputImgName = strcat(inputPath(imgNum).name);
    imgFile1 = strcat(imgDir1,inputImgName);
    imgFile2 = [imgDir2 inputPath(imgNum).name(1:end-4) '.png'];
    outFile = [outDir inputPath(imgNum).name(1:end-4) '.png'];
    I1=imread(imgFile1);
    I2=imread(imgFile2);
    I1=rgb2gray(I1);   
    [m,n,z]=size(I1);
    %BW_edge = edge(I,'canny',[0.04,0.10],1.5);
    BW_edge = edge(I1,'canny',[0.04,0.10],2.5);
    se=strel('disk',5);
    binary_dilate=imdilate(BW_edge,se);
    BW=imfill(binary_dilate,'holes');
    p = regionprops(BW, 'Perimeter','PixelIdxList');
    BW2 = zeros(size(BW));
    for i=1:size([p.Perimeter],2)
        if p(i).Perimeter >= 300
            PixelIdxList = p(i).PixelIdxList;
            BW2(PixelIdxList) = 1;
        end
    end
    BW_zf = uint8(BW2); 
    BW_zf = BW_zf | I2;
    BW_zf = uint8(BW_zf);
    imwrite(BW_zf,outFile);
end
