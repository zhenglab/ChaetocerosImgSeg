clear all;close all;clc;

gtDir = '../../Dataset/Groundtruth/';   %Ground truth
imgDir = '../Canny/result/';    %Segmentation result

inputPath = dir(imgDir);
F_total = 0;

for imgNum = 1:length(inputPath),
     if inputPath(imgNum).name(1)=='.'
            continue;
     end
    inputImgName = strcat(inputPath(imgNum).name);
    imgFile = strcat(imgDir,inputImgName);
    gtFile = [gtDir inputPath(imgNum).name(1:end-4) '.bmp'];
    disp(['Processing ' inputPath(imgNum).name]);
    
%Foe NCut and MS,gtFile is mat file got by Ground truth.
%1. NCut
    %load(imgFile);
    %load(gtFile);
    %seg = SegLabel-1;
    %groundtruth = groundTruth - 1;
    
%2. MS
    %load(imgFile);
    %load(gtFile);
    %seg = SegLabel;
    %groundtruth = groundTruth - 1;
    
%3. gPb-owt-ucm
    %load(imgFile);
    %load(gtFile);
    %groundtruth = groundTruth - 1;

 %if exist('ucm2', 'var'),
   %ucm = double(ucm2);
   %clear ucm2;
   %elseif ~exist('segs', 'var')
    %error('unexpected input in inFile');
 %end
     
    %labels2 = bwlabel(ucm <= 0.4);
    %seg = labels2(2:2:end, 2:2:end);
    %seg = seg - 1;
    
%4. Otsu, Canny, Watershed, GSDAM, EG, and our method
   seg = imread(imgFile);
    [x, y, z] = size(seg);
    if (z==3)
      seg = rgb2gray(seg);
    end
    seg = logical(seg);
    groundtruth = logical(rgb2gray((imread(gtFile))));
    
    score = ComputeFMeasure(seg,groundtruth);
    F_total = F_total + score; 
end

F_final = F_total / 141;