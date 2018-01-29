clear all;close all;clc;

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
    %your code here
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    I=rgb2gray(I);
    BW_edge = edge(I,'canny',[0.04,0.10],1.5);
    %BW_edge = edge(I,'canny',[0.04,0.10],2.5);
    se=strel('disk',5);
    binary_dilate=imdilate(BW_edge,se);
    BW=imfill(binary_dilate,'holes');
    
    %Select Maximum Connected Region (MCR) 
    img=im2bw(BW);
    imLabel = bwlabel(img);                
    stats = regionprops(imLabel,'Area');     
    area = cat(1,stats.Area);  
    index = find(area == max(area));       
    img1= ismember(imLabel,index);    
    imgLabel = bwlabel(img1); 
    imgLabel=imgLabel+1;
    imwrite(img1,outFile1); 
    save(outFile2,'SegLabel');

end
