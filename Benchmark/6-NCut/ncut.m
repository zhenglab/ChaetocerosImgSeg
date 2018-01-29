addpath lib;

clear all;close all;clc;

imgDir = '../../Dataset/Image/';
outDir1 = './result/pb/';
outDir2 = './result/ncut/';
outDir3 = './mat/';
inputPath = dir(imgDir);

for imgNum =1:length(inputPath),
    if inputPath(imgNum).name(1)=='.'
            continue;
     end
    inputImgName = strcat(inputPath(imgNum).name);
    imgFile = strcat(imgDir,inputImgName);
    outFile1 = [outDir1 inputPath(imgNum).name(1:end-4) '.png'];
    outFile2 = [outDir2 inputPath(imgNum).name(1:end-4) '.png'];
    outFile3 = [outDir3 inputPath(imgNum).name(1:end-4) '.mat']; 
    %if exist(outFile1,'file'), continue; end

    I = imread_ncut(imgFile);
    nbSegments = 2;
    [SegLabel,NcutDiscrete,NcutEigenvectors,NcutEigenvalues,W,imageEdges]= NcutImage(I,nbSegments);
    save(outFile3,'SegLabel');
    bw = edge(SegLabel,0.01);
    pb= imdilate(bw,ones(2,2));
    imwrite(pb,outFile1);
    J1=showmask(I,imdilate(bw,ones(2,2)));
    imwrite(J1,outFile2);
end
