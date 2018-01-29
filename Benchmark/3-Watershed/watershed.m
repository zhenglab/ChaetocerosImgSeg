clc; clear all; close all;

imgDir = '../../Dataset/Image/';
outDir1= './result/';
outDir2= './mat/';
mkdir(outDir1);
mkdir(outDir2);
inputPath = dir(imgDir);

for imgNum = 1:length(inputPath),
     if inputPath(imgNum).name(1)=='.'
            continue;
     end
    inputImgName = strcat(inputPath(imgNum).name);
    imgFile = strcat(imgDir,inputImgName);
    outFile1 = [outDir1 inputPath(imgNum).name(1:end-4) '.png'];
    outFile2 = [outDir2 inputPath(imgNum).name(1:end-4) '.mat'];
    I=imread(imgFile);
    I=rgb2gray(I);
    hy = fspecial('sobel');
    hx = hy';
    Iy = imfilter(double(I), hy, 'replicate');
    Ix = imfilter(double(I), hx, 'replicate');
    gradmag = sqrt(Ix.^2 + Iy.^2);
 
    se = strel('disk', 20); 
    Ie = imerode(I, se);
    Iobr = imreconstruct(Ie, I);
    Iobrd = imdilate(Iobr, se);
    Iobrcbr = imreconstruct(imcomplement(Iobrd), imcomplement(Iobr));
    Iobrcbr = imcomplement(Iobrcbr);
 
    fgm = imregionalmax(Iobrcbr);
    
    se2 = strel(ones(5,5));
    fgm2 = imclose(fgm, se2);
    fgm3 = imerode(fgm2, se2);
    
    fgm4 = bwareaopen(fgm3, 20);
    
    bw = im2bw(Iobrcbr, graythresh(Iobrcbr));
    
    D = bwdist(bw);
    DL = watershed(D);
    bgm = DL == 0;
    
    gradmag2 = imimposemin(gradmag, bgm | fgm4);
    L = watershed(gradmag2);
    
    fgm5 = imdilate(L == 0, ones(3, 3)) | bgm | fgm4;
    imwrite(fgm5,outFile1);
    imgLabel = bwlabel(fgm5); 
    imgLabel=imgLabel+1;
    save(outFile2,'SegLabel');
end

